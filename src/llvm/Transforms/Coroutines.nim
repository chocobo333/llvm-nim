## ===-- Coroutines.h - Coroutines Library C Interface -----------*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMCoroutines.a, which         *|
## |* implements various scalar transformations of the LLVM IR.                  *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===
## *
##  @defgroup LLVMCTransformsCoroutines Coroutine transformations
##  @ingroup LLVMCTransforms
##
##  @{
##
## * See llvm::createCoroEarlyLegacyPass function.

proc addCoroEarlyPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroEarlyPass", dynlib: LLVMlib.}
## * See llvm::createCoroSplitLegacyPass function.

proc addCoroSplitPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroSplitPass", dynlib: LLVMlib.}
## * See llvm::createCoroElideLegacyPass function.

proc addCoroElidePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroElidePass", dynlib: LLVMlib.}
## * See llvm::createCoroCleanupLegacyPass function.

proc addCoroCleanupPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroCleanupPass", dynlib: LLVMlib.}
## *
##  @}
##
