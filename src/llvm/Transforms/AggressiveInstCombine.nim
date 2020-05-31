## ===-- AggressiveInstCombine.h ---------------------------------*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMAggressiveInstCombine.a,    *|
## |* which combines instructions to form fewer, simple IR instructions.         *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===
## *
##  @defgroup LLVMCTransformsAggressiveInstCombine Aggressive Instruction Combining transformations
##  @ingroup LLVMCTransforms
##
##  @{
##
## * See llvm::createAggressiveInstCombinerPass function.

proc addAggressiveInstCombinerPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAggressiveInstCombinerPass", dynlib: LLVMlib.}
## *
##  @}
##
