
##  This header declares the C interface to libLLVMInstCombine.a, which
##  combines instructions to form fewer, simple IR instructions.

import ../prelude/platforms

import ../Types


proc addInstructionCombiningPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddInstructionCombiningPass", dynlib: LLVMlib.}
    ## * See llvm::createInstructionCombiningPass function.
