# ===-- llvm-c/BitReader.h - BitReader Library C Interface ------*- C++ -*-===*\
# |*                                                                            *|
# |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
# |* Exceptions.                                                                *|
# |* See https://llvm.org/LICENSE.txt for license information.                  *|
# |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
# |*                                                                            *|
# |*===----------------------------------------------------------------------===*|
# |*                                                                            *|
# |* This header declares the C interface to libLLVMBitReader.a, which          *|
# |* implements input of the LLVM bitcode format.                               *|
# |*                                                                            *|
# |* Many exotic languages can interoperate with C code but have a harder time  *|
# |* with C++ due to name mangling. So in addition to C, this interface enables *|
# |* tools written in such languages.                                           *|
# |*                                                                            *|
# \*===----------------------------------------------------------------------===

import prelude/platforms

import Types


proc parseBitcode*(memBuf: MemoryBufferRef; outModule: ptr ModuleRef;outMessage: cstringArray): Bool {.cdecl, importc: "LLVMParseBitcode", dynlib: LLVMlib.}
    ##  Builds a module from the bitcode in the specified memory buffer, returning a
    ##    reference to the module via the OutModule parameter. Returns 0 on success.
    ##    Optionally returns a human-readable error message via OutMessage.
    ##    This is deprecated. Use LLVMParseBitcode2.

proc parseBitcode2*(memBuf: MemoryBufferRef; outModule: ptr ModuleRef): Bool {.cdecl, importc: "LLVMParseBitcode2", dynlib: LLVMlib.}
    ##  Builds a module from the bitcode in the specified memory buffer, returning a
    ##    reference to the module via the OutModule parameter. Returns 0 on success.

proc parseBitcodeInContext*(contextRef: ContextRef; memBuf: MemoryBufferRef;outModule: ptr ModuleRef;outMessage: cstringArray): Bool {. cdecl, importc: "LLVMParseBitcodeInContext", dynlib: LLVMlib.}
    ##  This is deprecated. Use LLVMParseBitcodeInContext2.
proc parseBitcodeInContext2*(contextRef: ContextRef; memBuf: MemoryBufferRef;outModule: ptr ModuleRef): Bool {.cdecl, importc: "LLVMParseBitcodeInContext2", dynlib: LLVMlib.}

proc getBitcodeModuleInContext*(contextRef: ContextRef; memBuf: MemoryBufferRef;outM: ptr ModuleRef; outMessage: cstringArray): Bool {. cdecl, importc: "LLVMGetBitcodeModuleInContext", dynlib: LLVMlib.}
    ## * Reads a module from the specified path, returning via the OutMP parameter
    ## a module provider which performs lazy deserialization. Returns 0 on success.
    ## Optionally returns a human-readable error message via OutMessage.
    ## This is deprecated. Use LLVMGetBitcodeModuleInContext2.


proc getBitcodeModuleInContext2*(contextRef: ContextRef; memBuf: MemoryBufferRef; outM: ptr ModuleRef): Bool {.cdecl, importc: "LLVMGetBitcodeModuleInContext2", dynlib: LLVMlib.}
    ## * Reads a module from the specified path, returning via the OutMP parameter a
    ##  module provider which performs lazy deserialization. Returns 0 on success.

proc getBitcodeModule*(memBuf: MemoryBufferRef; outM: ptr ModuleRef;outMessage: cstringArray): Bool {.cdecl, importc: "LLVMGetBitcodeModule", dynlib: LLVMlib.}
    ##  This is deprecated. Use LLVMGetBitcodeModule2.
proc getBitcodeModule2*(memBuf: MemoryBufferRef; outM: ptr ModuleRef): Bool {.cdecl, importc: "LLVMGetBitcodeModule2", dynlib: LLVMlib.}

