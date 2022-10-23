#
# Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
#
# SPDX-License-Identifier: GPL-2.0-only
#

cmake_minimum_required(VERSION 3.7.2)

set(CMAKE_SYSTEM_NAME Generic)
# For a generic system this is unused, so define it to something that will be
# obvious if someone accidentally uses it
set(CMAKE_SYSTEM_PROCESSOR seL4CPU)

set(LLVM_TOOLCHAIN ON)

set(CROSS_COMPILER_PREFIX ${TRIPLE}-)

set(CMAKE_ASM_COMPILER "clang")
set(CMAKE_ASM_COMPILER_ID Clang)
set(CMAKE_ASM_COMPILER_TARGET ${TRIPLE})

string(APPEND asm_common_flags " -Wno-unused-command-line-argument")

set(CMAKE_C_COMPILER "clang")
set(CMAKE_C_COMPILER_ID Clang)
set(CMAKE_C_COMPILER_TARGET ${TRIPLE})

set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_CXX_COMPILER_ID Clang)
set(CMAKE_CXX_COMPILER_TARGET ${TRIPLE})

string(APPEND c_common_flags " -Wno-sizeof-pointer-div")
string(APPEND c_common_flags " -Qunused-arguments")
string(APPEND c_common_flags " -Wno-constant-logical-operand")
# clang 11 has a regression in GlobalISel (only used at -O0) affecting the syscall
# stubs in libsel4runtime; see https://reviews.llvm.org/D83384#2189132
string(APPEND c_common_flags " -fno-experimental-isel")

set(CMAKE_LINKER "ld.lld")
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_C_LINK_EXECUTABLE>")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

mark_as_advanced(FORCE CMAKE_TOOLCHAIN_FILE)

find_program(CCACHE ccache)
if(NOT ("${CCACHE}" STREQUAL CCACHE-NOTFOUND))
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ${CCACHE})
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ${CCACHE})
endif()
mark_as_advanced(CCACHE)
