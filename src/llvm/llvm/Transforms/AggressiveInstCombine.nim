
##  This header declares the C interface to libLLVMAggressiveInstCombine.a,
##  which combines instructions to form fewer, simple IR instructions.

import ../prelude/platforms

import ../Types


proc addAggressiveInstCombinerPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddAggressiveInstCombinerPass", dynlib: LLVMlib.}
    ## * See llvm::createAggressiveInstCombinerPass function.
