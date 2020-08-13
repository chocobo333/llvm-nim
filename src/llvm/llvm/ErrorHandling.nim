
##  This file defines the C interface to LLVM's error handling mechanism.

import prelude/platforms


type
    FatalErrorHandler* = proc (reason: cstring) {.cdecl.}

proc installFatalErrorHandler*(handler: FatalErrorHandler) {.cdecl, importc: "LLVMInstallFatalErrorHandler", dynlib: LLVMlib.}
    ##  Install a fatal error handler. By default, if LLVM detects a fatal error, it
    ##  will call exit(1). This may not be appropriate in many contexts. For example,
    ##  doing exit(1) will bypass many crash reporting/tracing system tools. This
    ##  function allows you to install a callback that will be invoked prior to the
    ##  call to exit(1).

proc resetFatalErrorHandler*() {.cdecl, importc: "LLVMResetFatalErrorHandler", dynlib: LLVMlib.}
    ##  Reset the fatal error handler. This resets LLVM's fatal error handling
    ##  behavior to the default.

proc enablePrettyStackTrace*() {.cdecl, importc: "LLVMEnablePrettyStackTrace", dynlib: LLVMlib.}
    ##  Enable LLVM's built-in stack trace code. This intercepts the OS's crash
    ##  signals and prints which component of LLVM you were in at the time if the
    ##  crash.
