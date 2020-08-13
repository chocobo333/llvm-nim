
##  This header declares the C interface to libLLVMCoroutines.a, which
##  implements various scalar transformations of the LLVM IR.
##  
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.

import ../prelude/platforms

import ../Types


proc addCoroEarlyPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroEarlyPass", dynlib: LLVMlib.}
    ## * See llvm::createCoroEarlyLegacyPass function.

proc addCoroSplitPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroSplitPass", dynlib: LLVMlib.}
    ## * See llvm::createCoroSplitLegacyPass function.

proc addCoroElidePass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroElidePass", dynlib: LLVMlib.}
    ## * See llvm::createCoroElideLegacyPass function.

proc addCoroCleanupPass*(pm: PassManagerRef) {.cdecl, importc: "LLVMAddCoroCleanupPass", dynlib: LLVMlib.}
    ## * See llvm::createCoroCleanupLegacyPass function.
