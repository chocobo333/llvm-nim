
##  This header declares the C interface to libLLVMBitWriter.a, which
##  implements output of the LLVM bitcode format.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.

import prelude/platforms

import Types


## ===-- Operations on modules ---------------------------------------------===

proc writeBitcodeToFile*(m: ModuleRef; path: cstring): cint {.cdecl, importc: "LLVMWriteBitcodeToFile", dynlib: LLVMlib.}
    ## * Writes a module to the specified path. Returns 0 on success.

proc writeBitcodeToFD*(m: ModuleRef; fd: cint; shouldClose: cint;unbuffered: cint): cint {. cdecl, importc: "LLVMWriteBitcodeToFD", dynlib: LLVMlib.}
    ## * Writes a module to an open file descriptor. Returns 0 on success.

proc writeBitcodeToFileHandle*(m: ModuleRef; handle: cint): cint {.cdecl, importc: "LLVMWriteBitcodeToFileHandle", dynlib: LLVMlib.}
    ## * Deprecated for LLVMWriteBitcodeToFD. Writes a module to an open file
    ##     descriptor. Returns 0 on success. Closes the Handle.

proc writeBitcodeToMemoryBuffer*(m: ModuleRef): MemoryBufferRef {.cdecl, importc: "LLVMWriteBitcodeToMemoryBuffer", dynlib: LLVMlib.}
    ## * Writes a module to a new memory buffer and returns it.
