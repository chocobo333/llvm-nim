## ===-- llvm/LinkTimeOptimizer.h - LTO Public C Interface -------*- C++ -*-===//
##
##  Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
##  See https://llvm.org/LICENSE.txt for license information.
##  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
##
## ===----------------------------------------------------------------------===//
##
##  This header provides a C API to use the LLVM link time optimization
##  library. This is intended to be used by linkers which are C-only in
##  their implementation for performing LTO.
##
## ===----------------------------------------------------------------------===//
## *
##  @defgroup LLVMCLinkTimeOptimizer Link Time Optimization
##  @ingroup LLVMC
##
##  @{
##
## / This provides a dummy type for pointers to the LTO object.

type
  LlvmLtoT* = pointer

## / This provides a C-visible enumerator to manage status codes.
## / This should map exactly onto the C++ enumerator LTOStatus.

type
  LlvmLtoStatusT* {.size: sizeof(cint).} = enum
    _LTO_UNKNOWN, _LTO_OPT_SUCCESS, _LTO_READ_SUCCESS, _LTO_READ_FAILURE,
    _LTO_WRITE_FAILURE, _LTO_NO_TARGET, _LTO_NO_WORK, _LTO_MODULE_MERGE_FAILURE, _LTO_ASM_FAILURE, ##
                                                                                              ## Added
                                                                                              ## C-specific
                                                                                              ## error
                                                                                              ## codes
    _LTO_NULL_OBJECT


## / This provides C interface to initialize link time optimizer. This allows
## / linker to use dlopen() interface to dynamically load LinkTimeOptimizer.
## / extern "C" helps, because dlopen() interface uses name to find the symbol.

proc llvmCreateOptimizer*(): LlvmLtoT {.cdecl, importc: "llvm_create_optimizer", dynlib: LLVMlib.}
proc llvmDestroyOptimizer*(lto: LlvmLtoT) {.cdecl, importc: "llvm_destroy_optimizer", dynlib: LLVMlib.}
proc llvmReadObjectFile*(lto: LlvmLtoT; inputFilename: cstring): LlvmLtoStatusT {. cdecl, importc: "llvm_read_object_file", dynlib: LLVMlib.}
proc llvmOptimizeModules*(lto: LlvmLtoT; outputFilename: cstring): LlvmLtoStatusT {. cdecl, importc: "llvm_optimize_modules", dynlib: LLVMlib.}
## *
##  @}
##
