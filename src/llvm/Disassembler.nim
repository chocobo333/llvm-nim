## ===-- llvm-c/Disassembler.h - Disassembler Public C Interface ---*- C -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header provides a public interface to a disassembler library.         *|
## |* LLVM provides an implementation of this interface.                         *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===
## *
##  @defgroup LLVMCDisassembler Disassembler
##  @ingroup LLVMC
##
##  @{
##
## *
##  Create a disassembler for the TripleName.  Symbolic disassembly is supported
##  by passing a block of information in the DisInfo parameter and specifying the
##  TagType and callback functions as described above.  These can all be passed
##  as NULL.  If successful, this returns a disassembler context.  If not, it
##  returns NULL. This function is equivalent to calling
##  LLVMCreateDisasmCPUFeatures() with an empty CPU name and feature set.
##

proc createDisasm*(tripleName: cstring; disInfo: pointer; tagType: cint;getOpInfo: OpInfoCallback; symbolLookUp: SymbolLookupCallback): DisasmContextRef {. cdecl, importc: "LLVMCreateDisasm", dynlib: LLVMlib.}
## *
##  Create a disassembler for the TripleName and a specific CPU.  Symbolic
##  disassembly is supported by passing a block of information in the DisInfo
##  parameter and specifying the TagType and callback functions as described
##  above.  These can all be passed * as NULL.  If successful, this returns a
##  disassembler context.  If not, it returns NULL. This function is equivalent
##  to calling LLVMCreateDisasmCPUFeatures() with an empty feature set.
##

proc createDisasmCPU*(triple: cstring; cpu: cstring; disInfo: pointer; tagType: cint;getOpInfo: OpInfoCallback; symbolLookUp: SymbolLookupCallback): DisasmContextRef {. cdecl, importc: "LLVMCreateDisasmCPU", dynlib: LLVMlib.}
## *
##  Create a disassembler for the TripleName, a specific CPU and specific feature
##  string.  Symbolic disassembly is supported by passing a block of information
##  in the DisInfo parameter and specifying the TagType and callback functions as
##  described above.  These can all be passed * as NULL.  If successful, this
##  returns a disassembler context.  If not, it returns NULL.
##

proc createDisasmCPUFeatures*(triple: cstring; cpu: cstring; features: cstring;disInfo: pointer; tagType: cint;getOpInfo: OpInfoCallback;symbolLookUp: SymbolLookupCallback): DisasmContextRef {. cdecl, importc: "LLVMCreateDisasmCPUFeatures", dynlib: LLVMlib.}
## *
##  Set the disassembler's options.  Returns 1 if it can set the Options and 0
##  otherwise.
##

proc setDisasmOptions*(dc: DisasmContextRef; options: uint64T): cint {.cdecl, importc: "LLVMSetDisasmOptions", dynlib: LLVMlib.}
##  The option to produce marked up assembly.
##  The option to print immediates as hex.
##  The option use the other assembler printer variant
##  The option to set comment on instructions
##  The option to print latency information alongside instructions
## *
##  Dispose of a disassembler context.
##

proc disasmDispose*(dc: DisasmContextRef) {.cdecl, importc: "LLVMDisasmDispose", dynlib: LLVMlib.}
## *
##  Disassemble a single instruction using the disassembler context specified in
##  the parameter DC.  The bytes of the instruction are specified in the
##  parameter Bytes, and contains at least BytesSize number of bytes.  The
##  instruction is at the address specified by the PC parameter.  If a valid
##  instruction can be disassembled, its string is returned indirectly in
##  OutString whose size is specified in the parameter OutStringSize.  This
##  function returns the number of bytes in the instruction or zero if there was
##  no valid instruction.
##

proc disasmInstruction*(dc: DisasmContextRef; bytes: ptr uint8T; bytesSize: uint64T;pc: uint64T; outString: cstring; outStringSize: csize): csize {. cdecl, importc: "LLVMDisasmInstruction", dynlib: LLVMlib.}
## *
##  @}
##
