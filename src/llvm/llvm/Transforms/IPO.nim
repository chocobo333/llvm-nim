
##  This header declares the C interface to libLLVMIPO.a, which implements
##  various interprocedural transformations of the LLVM IR.

import ../prelude/platforms

import ../Types


proc addArgumentPromotionPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddArgumentPromotionPass", dynlib: LLVMlib.}
    ## * See llvm::createArgumentPromotionPass function.

proc addConstantMergePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddConstantMergePass", dynlib: LLVMlib.}
    ## * See llvm::createConstantMergePass function.

proc addMergeFunctionsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddMergeFunctionsPass", dynlib: LLVMlib.}
    ## * See llvm::createMergeFunctionsPass function.

proc addCalledValuePropagationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCalledValuePropagationPass", dynlib: LLVMlib.}
    ## * See llvm::createCalledValuePropagationPass function.

proc addDeadArgEliminationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddDeadArgEliminationPass", dynlib: LLVMlib.}
    ## * See llvm::createDeadArgEliminationPass function.

proc addFunctionAttrsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddFunctionAttrsPass", dynlib: LLVMlib.}
    ## * See llvm::createFunctionAttrsPass function.

proc addFunctionInliningPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddFunctionInliningPass", dynlib: LLVMlib.}
    ## * See llvm::createFunctionInliningPass function.

proc addAlwaysInlinerPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAlwaysInlinerPass", dynlib: LLVMlib.}
    ## * See llvm::createAlwaysInlinerPass function.

proc addGlobalDCEPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddGlobalDCEPass", dynlib: LLVMlib.}
    ## * See llvm::createGlobalDCEPass function.

proc addGlobalOptimizerPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddGlobalOptimizerPass", dynlib: LLVMlib.}
    ## * See llvm::createGlobalOptimizerPass function.

proc addIPConstantPropagationPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddIPConstantPropagationPass", dynlib: LLVMlib.}
    ## * See llvm::createIPConstantPropagationPass function.

proc addPruneEHPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddPruneEHPass", dynlib: LLVMlib.}
    ## * See llvm::createPruneEHPass function.

proc addIPSCCPPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddIPSCCPPass", dynlib: LLVMlib.}
    ## * See llvm::createIPSCCPPass function.

proc addInternalizePass*(a1: PassManagerRef; allButMain: cuint) {.cdecl, importc: "LLVMAddInternalizePass", dynlib: LLVMlib.}
    ## * See llvm::createInternalizePass function.

proc addInternalizePassWithMustPreservePredicate*(pm: PassManagerRef;context: pointer;mustPreserve: proc (a1: ValueRef; a2: pointer): Bool {.cdecl.}) {.cdecl, importc: "LLVMAddInternalizePassWithMustPreservePredicate", dynlib: LLVMlib.}
    ##  Create and add the internalize pass to the given pass manager with the
    ##  provided preservation callback.
    ##
    ##  The context parameter is forwarded to the callback on each invocation.
    ##  As such, it is the responsibility of the caller to extend its lifetime
    ##  until execution of this pass has finished.
    ##
    ##  @see llvm::createInternalizePass function.

proc addStripDeadPrototypesPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddStripDeadPrototypesPass", dynlib: LLVMlib.}
    ## * See llvm::createStripDeadPrototypesPass function.

proc addStripSymbolsPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddStripSymbolsPass", dynlib: LLVMlib.}
    ## * See llvm::createStripSymbolsPass function.