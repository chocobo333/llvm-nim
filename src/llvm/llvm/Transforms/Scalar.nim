## ===-- Scalar.h - Scalar Transformation Library C Interface ----*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMScalarOpts.a, which         *|
## |* implements various scalar transformations of the LLVM IR.                  *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

import ../prelude/platforms

import ../Types


proc addAggressiveDCEPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAggressiveDCEPass", dynlib: LLVMlib.}
    ## * See llvm::createAggressiveDCEPass function.

proc addDCEPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddDCEPass", dynlib: LLVMlib.}
    ## * See llvm::createDeadCodeEliminationPass function.

proc addBitTrackingDCEPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddBitTrackingDCEPass", dynlib: LLVMlib.}
    ## * See llvm::createBitTrackingDCEPass function.

proc addAlignmentFromAssumptionsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAlignmentFromAssumptionsPass", dynlib: LLVMlib.}
    ## * See llvm::createAlignmentFromAssumptionsPass function.

proc addCFGSimplificationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCFGSimplificationPass", dynlib: LLVMlib.}
    ## * See llvm::createCFGSimplificationPass function.

proc addDeadStoreEliminationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddDeadStoreEliminationPass", dynlib: LLVMlib.}
    ## * See llvm::createDeadStoreEliminationPass function.

proc addScalarizerPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddScalarizerPass", dynlib: LLVMlib.}
    ## * See llvm::createScalarizerPass function.

proc addMergedLoadStoreMotionPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddMergedLoadStoreMotionPass", dynlib: LLVMlib.}
    ## * See llvm::createMergedLoadStoreMotionPass function.

proc addGVNPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddGVNPass", dynlib: LLVMlib.}
    ## * See llvm::createGVNPass function.

proc addNewGVNPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddNewGVNPass", dynlib: LLVMlib.}
    ## * See llvm::createGVNPass function.

proc addIndVarSimplifyPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddIndVarSimplifyPass", dynlib: LLVMlib.}
    ## * See llvm::createIndVarSimplifyPass function.

proc addInstructionCombiningPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddInstructionCombiningPass", dynlib: LLVMlib.}
    ## * See llvm::createInstructionCombiningPass function.

proc addJumpThreadingPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddJumpThreadingPass", dynlib: LLVMlib.}
    ## * See llvm::createJumpThreadingPass function.

proc addLICMPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLICMPass", dynlib: LLVMlib.}
    ## * See llvm::createLICMPass function.

proc addLoopDeletionPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopDeletionPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopDeletionPass function.

proc addLoopIdiomPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopIdiomPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopIdiomPass function

proc addLoopRotatePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopRotatePass", dynlib: LLVMlib.}
    ## * See llvm::createLoopRotatePass function.

proc addLoopRerollPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopRerollPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopRerollPass function.

proc addLoopUnrollPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopUnrollPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopUnrollPass function.

proc addLoopUnrollAndJamPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopUnrollAndJamPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopUnrollAndJamPass function.

proc addLoopUnswitchPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopUnswitchPass", dynlib: LLVMlib.}
    ## * See llvm::createLoopUnswitchPass function.

proc addLowerAtomicPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLowerAtomicPass", dynlib: LLVMlib.}
    ## * See llvm::createLowerAtomicPass function.

proc addMemCpyOptPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddMemCpyOptPass", dynlib: LLVMlib.}
    ## * See llvm::createMemCpyOptPass function.

proc addPartiallyInlineLibCallsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddPartiallyInlineLibCallsPass", dynlib: LLVMlib.}
    ## * See llvm::createPartiallyInlineLibCallsPass function.

proc addReassociatePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddReassociatePass", dynlib: LLVMlib.}
    ## * See llvm::createReassociatePass function.

proc addSCCPPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddSCCPPass", dynlib: LLVMlib.}
    ## * See llvm::createSCCPPass function.

proc addScalarReplAggregatesPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddScalarReplAggregatesPass", dynlib: LLVMlib.}
    ## * See llvm::createSROAPass function.

proc addScalarReplAggregatesPassSSA*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddScalarReplAggregatesPassSSA", dynlib: LLVMlib.}
    ## * See llvm::createSROAPass function.

proc addScalarReplAggregatesPassWithThreshold*(pm: PassManagerRef;threshold: cint) {.cdecl, importc: "LLVMAddScalarReplAggregatesPassWithThreshold", dynlib: LLVMlib.}
    ## * See llvm::createSROAPass function.

proc addSimplifyLibCallsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddSimplifyLibCallsPass", dynlib: LLVMlib.}
    ## * See llvm::createSimplifyLibCallsPass function.

proc addTailCallEliminationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddTailCallEliminationPass", dynlib: LLVMlib.}
    ## * See llvm::createTailCallEliminationPass function.

proc addConstantPropagationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddConstantPropagationPass", dynlib: LLVMlib.}
    ## * See llvm::createConstantPropagationPass function.

proc addDemoteMemoryToRegisterPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddDemoteMemoryToRegisterPass", dynlib: LLVMlib.}
    ## * See llvm::demotePromoteMemoryToRegisterPass function.

proc addVerifierPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddVerifierPass", dynlib: LLVMlib.}
    ## * See llvm::createVerifierPass function.

proc addCorrelatedValuePropagationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCorrelatedValuePropagationPass", dynlib: LLVMlib.}
    ## * See llvm::createCorrelatedValuePropagationPass function

proc addEarlyCSEPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddEarlyCSEPass", dynlib: LLVMlib.}
    ## * See llvm::createEarlyCSEPass function

proc addEarlyCSEMemSSAPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddEarlyCSEMemSSAPass", dynlib: LLVMlib.}
    ## * See llvm::createEarlyCSEPass function

proc addLowerExpectIntrinsicPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLowerExpectIntrinsicPass", dynlib: LLVMlib.}
    ## * See llvm::createLowerExpectIntrinsicPass function

proc addLowerConstantIntrinsicsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLowerConstantIntrinsicsPass", dynlib: LLVMlib.}
    ## * See llvm::createLowerConstantIntrinsicsPass function

proc addTypeBasedAliasAnalysisPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddTypeBasedAliasAnalysisPass", dynlib: LLVMlib.}
    ## * See llvm::createTypeBasedAliasAnalysisPass function

proc addScopedNoAliasAAPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddScopedNoAliasAAPass", dynlib: LLVMlib.}
    ## * See llvm::createScopedNoAliasAAPass function

proc addBasicAliasAnalysisPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddBasicAliasAnalysisPass", dynlib: LLVMlib.}
    ## * See llvm::createBasicAliasAnalysisPass function

proc addUnifyFunctionExitNodesPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddUnifyFunctionExitNodesPass", dynlib: LLVMlib.}
    ## * See llvm::createUnifyFunctionExitNodesPass function
