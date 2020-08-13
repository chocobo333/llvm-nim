
##  This header declares the C interface to libLLVMVectorize.a, which
##  implements various vectorization transformations of the LLVM IR.
## 
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.

import ../prelude/platforms

import ../Types


proc addLoopVectorizePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddLoopVectorizePass", dynlib: LLVMlib.}
    ## * See llvm::createLoopVectorizePass function.

proc addSLPVectorizePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddSLPVectorizePass", dynlib: LLVMlib.}
    ## * See llvm::createSLPVectorizerPass function.
