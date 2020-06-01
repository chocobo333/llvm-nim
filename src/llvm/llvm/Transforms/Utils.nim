## ===-- Utils.h - Transformation Utils Library C Interface ------*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMTransformUtils.a, which     *|
## |* implements various transformation utilities of the LLVM IR.                *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

import ../prelude/platforms

import ../Types


proc addLowerSwitchPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLowerSwitchPass", dynlib: LLVMlib.}
    ## * See llvm::createLowerSwitchPass function.

proc addPromoteMemoryToRegisterPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddPromoteMemoryToRegisterPass", dynlib: LLVMlib.}
    ## * See llvm::createPromoteMemoryToRegisterPass function.

proc addAddDiscriminatorsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAddDiscriminatorsPass", dynlib: LLVMlib.}
    ## * See llvm::createAddDiscriminatorsPass function.
