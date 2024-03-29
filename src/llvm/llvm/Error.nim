
##  This file defines the C interface to LLVM's Error class.

import prelude/[
    opaques,
    platforms
]


type
    ErrorRef* = ptr OpaqueError
    ##  Opaque reference to an error instance. Null serves as the 'success' value.


type
    ErrorTypeId* = pointer
    ##  Error type identifier.


proc getErrorTypeId*(err: ErrorRef): ErrorTypeId {.cdecl, importc: "LLVMGetErrorTypeId", dynlib: LLVMlib.}
    ##  Returns the type id for the given error instance, which must be a failure
    ##  value (i.e. non-null).

proc consumeError*(err: ErrorRef) {.cdecl, importc: "LLVMConsumeError", dynlib: LLVMlib.}
    ##  Dispose of the given error without handling it. This operation consumes the
    ##  error, and the given LLVMErrorRef value is not usable once this call returns.
    ##  Note: This method *only* needs to be called if the error is not being passed
    ##  to some other consuming operation, e.g. LLVMGetErrorMessage.

proc getErrorMessage*(err: ErrorRef): cstring {.cdecl, importc: "LLVMGetErrorMessage", dynlib: LLVMlib.}
    ##  Returns the given string's error message. This operation consumes the error,
    ##  and the given LLVMErrorRef value is not usable once this call returns.
    ##  The caller is responsible for disposing of the string by calling
    ##  LLVMDisposeErrorMessage.

proc disposeErrorMessage*(errMsg: cstring) {.cdecl, importc: "LLVMDisposeErrorMessage", dynlib: LLVMlib.}
    ##  Dispose of the given error message.

proc getStringErrorTypeId*(): ErrorTypeId {.cdecl, importc: "LLVMGetStringErrorTypeId", dynlib: LLVMlib.}
    ##  Returns the type id for llvm StringError.
