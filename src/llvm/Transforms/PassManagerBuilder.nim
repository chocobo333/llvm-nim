## ===-- llvm-c/Transform/PassManagerBuilder.h - PMB C Interface ---*- C -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to the PassManagerBuilder class.      *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

type
    PassManagerBuilderRef* = ptr OpaquePassManagerBuilder

## *
##  @defgroup LLVMCTransformsPassManagerBuilder Pass manager builder
##  @ingroup LLVMCTransforms
##
##  @{
##
## * See llvm::PassManagerBuilder.

proc passManagerBuilderCreate*(): PassManagerBuilderRef {.cdecl, importc: "LLVMPassManagerBuilderCreate", dynlib: LLVMlib.}
proc passManagerBuilderDispose*(pmb: PassManagerBuilderRef) {.cdecl, importc: "LLVMPassManagerBuilderDispose", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::OptLevel.

proc passManagerBuilderSetOptLevel*(pmb: PassManagerBuilderRef;optLevel: cuint) {. cdecl, importc: "LLVMPassManagerBuilderSetOptLevel", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::SizeLevel.

proc passManagerBuilderSetSizeLevel*(pmb: PassManagerBuilderRef;sizeLevel: cuint) {. cdecl, importc: "LLVMPassManagerBuilderSetSizeLevel", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::DisableUnitAtATime.

proc passManagerBuilderSetDisableUnitAtATime*(pmb: PassManagerBuilderRef;value: Bool) {.cdecl, importc: "LLVMPassManagerBuilderSetDisableUnitAtATime", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::DisableUnrollLoops.

proc passManagerBuilderSetDisableUnrollLoops*(pmb: PassManagerBuilderRef;value: Bool) {.cdecl, importc: "LLVMPassManagerBuilderSetDisableUnrollLoops", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::DisableSimplifyLibCalls

proc passManagerBuilderSetDisableSimplifyLibCalls*(pmb: PassManagerBuilderRef;value: Bool) {.cdecl,
                 importc: "LLVMPassManagerBuilderSetDisableSimplifyLibCalls",
                 dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::Inliner.

proc passManagerBuilderUseInlinerWithThreshold*(pmb: PassManagerBuilderRef;threshold: cuint) {.cdecl,
                      importc: "LLVMPassManagerBuilderUseInlinerWithThreshold",
                      dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::populateFunctionPassManager.

proc passManagerBuilderPopulateFunctionPassManager*(pmb: PassManagerBuilderRef;pm: PassManagerRef) {.cdecl, importc: "LLVMPassManagerBuilderPopulateFunctionPassManager", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::populateModulePassManager.

proc passManagerBuilderPopulateModulePassManager*(pmb: PassManagerBuilderRef;pm: PassManagerRef) {.cdecl, importc: "LLVMPassManagerBuilderPopulateModulePassManager", dynlib: LLVMlib.}
## * See llvm::PassManagerBuilder::populateLTOPassManager.

proc passManagerBuilderPopulateLTOPassManager*(pmb: PassManagerBuilderRef;pm: PassManagerRef; internalize: Bool; runInliner: Bool) {.cdecl, importc: "LLVMPassManagerBuilderPopulateLTOPassManager", dynlib: LLVMlib.}
## *
##  @}
##
