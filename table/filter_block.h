// Copyright (c) 2012 The LevelDB Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file. See the AUTHORS file for names of contributors.
//
// A filter block is stored near the end of a Table file.  It contains
// filters (e.g., bloom filters) for all data blocks in the table combined
// into a single filter block.

#ifndef STORAGE_LEVELDB_TABLE_FILTER_BLOCK_H_
#define STORAGE_LEVELDB_TABLE_FILTER_BLOCK_H_

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

#include "leveldb/slice.h"
#include "util/hash.h"

namespace leveldb {

class FilterPolicy;

// A FilterBlockBuilder is used to construct all of the filters for a
// particular Table.  It generates a single string which is stored as
// a special block in the Table.
//
// The sequence of calls to FilterBlockBuilder must match the regexp:
//      (StartBlock AddKey*)* Finish
class FilterBlockBuilder {
 public:
  explicit FilterBlockBuilder(const FilterPolicy*);

  FilterBlockBuilder(const FilterBlockBuilder&) = delete;
  FilterBlockBuilder& operator=(const FilterBlockBuilder&) = delete;
  // 开始构建filter block
  void StartBlock(uint64_t block_offset);
  // 在table添加key的时候，有一个地方会专门存放key，当一个data block完成时，就会用存储的key来构建filter block
  void AddKey(const Slice& key);
    // 当一个filter block构建完成后，还需要做一些处理

    Slice Finish();

 private:
    // 真正构建filter block的地方

    void GenerateFilter();
    // 上面讲了那么多就是说的这个，里面有k_、bits_per_key_、filter block中是否存在key的方法和创建filter block的方法
  const FilterPolicy* policy_;
  std::string keys_;             // Flattened key contents   // 把key通过追加的方式全部放在keys_中
    std::vector<size_t> start_;    // Starting index in keys_ of each key 每个key在keys_中的位置
  std::string result_;           // Filter data computed so far 真正放bitmap的地方，table里面所有data block的bitmap全部都在这里面
  std::vector<Slice> tmp_keys_;  // policy_->CreateFilter() argument   临时存放keys的地方，后面会提到
  // 和start_类似，用来存放每个bitmap的索引，其实就是在result_中的起始地址，和result一起使用可以得到具体的bitmap
  std::vector<uint32_t> filter_offsets_;
};

class FilterBlockReader {
 public:
  // REQUIRES: "contents" and *policy must stay live while *this is live.
  FilterBlockReader(const FilterPolicy* policy, const Slice& contents);
  bool KeyMayMatch(uint64_t block_offset, const Slice& key);

 private:
  const FilterPolicy* policy_;
  const char* data_;    // Pointer to filter data (at block-start) 指向filter data开始的地方
  const char* offset_;  // Pointer to beginning of offset array (at block-end) 指向不同filter offset的数组开始的地方
  size_t num_;          // Number of entries in offset array
  size_t base_lg_;      // Encoding parameter (see kFilterBaseLg in .cc file)
};

}  // namespace leveldb

#endif  // STORAGE_LEVELDB_TABLE_FILTER_BLOCK_H_
