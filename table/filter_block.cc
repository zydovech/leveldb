// Copyright (c) 2012 The LevelDB Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file. See the AUTHORS file for names of contributors.

#include "table/filter_block.h"

#include "leveldb/filter_policy.h"
#include "util/coding.h"

namespace leveldb {

// See doc/table_format.md for an explanation of the filter block format.

// Generate new filter every 2KB of data 2k数据一个filter， 2k一个索引
static const size_t kFilterBaseLg = 11;
static const size_t kFilterBase = 1 << kFilterBaseLg; //2k

FilterBlockBuilder::FilterBlockBuilder(const FilterPolicy* policy)
    : policy_(policy) {}

void FilterBlockBuilder::StartBlock(uint64_t block_offset) {

  uint64_t filter_index = (block_offset / kFilterBase); //算出对应的block_offset，在第一个filter_index
  assert(filter_index >= filter_offsets_.size());
  while (filter_index > filter_offsets_.size()) {//如果filter_index大于filter_offsets_，则创建一个fliter
    GenerateFilter();
  }
}
//把key添加到start里面
void FilterBlockBuilder::AddKey(const Slice& key) {
  Slice k = key;
  start_.push_back(keys_.size());
  keys_.append(k.data(), k.size());
}

Slice FilterBlockBuilder::Finish() {
  if (!start_.empty()) {
    GenerateFilter();
  }

  // Append array of per-filter offsets
  //所有filter都是连在一起的，在filter数据的后面，放在不同filter的offset组成的数组，所以可以通过这个数组来分离出不同的filter
  const uint32_t array_offset = result_.size();

  for (size_t i = 0; i < filter_offsets_.size(); i++) {
    //把offset编码到result里面
    PutFixed32(&result_, filter_offsets_[i]);
  }
  //把offset的起始地址编码
  PutFixed32(&result_, array_offset);
  //添加一个标志
  result_.push_back(kFilterBaseLg);  // Save encoding parameter in result
  return Slice(result_);
}

void FilterBlockBuilder::GenerateFilter() {
  const size_t num_keys = start_.size();//key的数量
  if (num_keys == 0) {//如果是0，就代表已经处理过了，filter_offsets就继续使用当前位置，这就是一个data block大于2k的话，占有多个索引，但是指向相同的位置
    // Fast path if there are no keys for this filter
    filter_offsets_.push_back(result_.size());
    return;
  }

  // Make list of keys from flattened key structure
  start_.push_back(keys_.size());  // Simplify length computation
  //先把所有的key，都放到tmp_keys里面
  tmp_keys_.resize(num_keys);
  for (size_t i = 0; i < num_keys; i++) {
    const char* base = keys_.data() + start_[i];
    size_t length = start_[i + 1] - start_[i];
    tmp_keys_[i] = Slice(base, length);
  }

  // Generate filter for current set of keys and append to result_.
  filter_offsets_.push_back(result_.size());
  //用当前的key来重新生成一个bitmap
  policy_->CreateFilter(&tmp_keys_[0], static_cast<int>(num_keys), &result_);
  //清楚tmp_keys、keys、start，因为当前这一批已经结束了
  tmp_keys_.clear();
  keys_.clear();
  start_.clear();
}

FilterBlockReader::FilterBlockReader(const FilterPolicy* policy,
                                     const Slice& contents)
    : policy_(policy), data_(nullptr), offset_(nullptr), num_(0), base_lg_(0) {
  size_t n = contents.size();
  if (n < 5) return;  // 1 byte for base_lg_ and 4 for start of offset array
  base_lg_ = contents[n - 1];
  //这个last_word就是指向的offset的开始位置
  uint32_t last_word = DecodeFixed32(contents.data() + n - 5);
  if (last_word > n - 5) return;
  data_ = contents.data();
  offset_ = data_ + last_word;
  //计算有多少个filter data
  num_ = (n - 5 - last_word) / 4;
}

bool FilterBlockReader::KeyMayMatch(uint64_t block_offset, const Slice& key) {
    //计算该block对应的filter index
    uint64_t index = block_offset >> base_lg_;
  if (index < num_) {//在范围内
      //根据
    uint32_t start = DecodeFixed32(offset_ + index * 4); //解码出第index个filter的开始位置
    uint32_t limit = DecodeFixed32(offset_ + index * 4 + 4); //结束位置
    if (start <= limit && limit <= static_cast<size_t>(offset_ - data_)) {
      Slice filter = Slice(data_ + start, limit - start); //得到filter数据
      return policy_->KeyMayMatch(key, filter);
    } else if (start == limit) {
      // Empty filters do not match any keys
      return false;
    }
  }
  return true;  // Errors are treated as potential matches
}

}  // namespace leveldb
