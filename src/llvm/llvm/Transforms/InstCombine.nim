## ===-- Scalar.h - Scalar Transformation Library C Interface ----*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMInstCombine.a, which        *|
## |* combines instructions to form fewer, simple IR instructions.               *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

import ../prelude/platforms

import ../Types


proc addInstructionCombiningPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddInstructionCombiningPass", dynlib: LLVMlib.}
    ## * See llvm::createInstructionCombiningPass function.
