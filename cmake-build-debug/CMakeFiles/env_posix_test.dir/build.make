# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.16.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.16.1/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/zy/code/leveldb

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/zy/code/leveldb/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/env_posix_test.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/env_posix_test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/env_posix_test.dir/flags.make

CMakeFiles/env_posix_test.dir/util/testutil.cc.o: CMakeFiles/env_posix_test.dir/flags.make
CMakeFiles/env_posix_test.dir/util/testutil.cc.o: ../util/testutil.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zy/code/leveldb/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/env_posix_test.dir/util/testutil.cc.o"
	/Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/env_posix_test.dir/util/testutil.cc.o -c /Users/zy/code/leveldb/util/testutil.cc

CMakeFiles/env_posix_test.dir/util/testutil.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/env_posix_test.dir/util/testutil.cc.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/zy/code/leveldb/util/testutil.cc > CMakeFiles/env_posix_test.dir/util/testutil.cc.i

CMakeFiles/env_posix_test.dir/util/testutil.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/env_posix_test.dir/util/testutil.cc.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/zy/code/leveldb/util/testutil.cc -o CMakeFiles/env_posix_test.dir/util/testutil.cc.s

CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o: CMakeFiles/env_posix_test.dir/flags.make
CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o: ../util/env_posix_test.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zy/code/leveldb/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o"
	/Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o -c /Users/zy/code/leveldb/util/env_posix_test.cc

CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/zy/code/leveldb/util/env_posix_test.cc > CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.i

CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/zy/code/leveldb/util/env_posix_test.cc -o CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.s

# Object files for target env_posix_test
env_posix_test_OBJECTS = \
"CMakeFiles/env_posix_test.dir/util/testutil.cc.o" \
"CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o"

# External object files for target env_posix_test
env_posix_test_EXTERNAL_OBJECTS =

env_posix_test: CMakeFiles/env_posix_test.dir/util/testutil.cc.o
env_posix_test: CMakeFiles/env_posix_test.dir/util/env_posix_test.cc.o
env_posix_test: CMakeFiles/env_posix_test.dir/build.make
env_posix_test: libleveldb.a
env_posix_test: lib/libgmockd.a
env_posix_test: lib/libgtestd.a
env_posix_test: CMakeFiles/env_posix_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/zy/code/leveldb/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable env_posix_test"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/env_posix_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/env_posix_test.dir/build: env_posix_test

.PHONY : CMakeFiles/env_posix_test.dir/build

CMakeFiles/env_posix_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/env_posix_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/env_posix_test.dir/clean

CMakeFiles/env_posix_test.dir/depend:
	cd /Users/zy/code/leveldb/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/zy/code/leveldb /Users/zy/code/leveldb /Users/zy/code/leveldb/cmake-build-debug /Users/zy/code/leveldb/cmake-build-debug /Users/zy/code/leveldb/cmake-build-debug/CMakeFiles/env_posix_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/env_posix_test.dir/depend

