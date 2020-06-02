# ===-- llvm-c/Analysis.h - Analysis Library C Interface --------*- C++ -*-===*\
# |*                                                                            *|
# |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
# |* Exceptions.                                                                *|
# |* See https://llvm.org/LICENSE.txt for license information.                  *|
# |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
# |*                                                                            *|
# |*===----------------------------------------------------------------------===*|
# |*                                                                            *|
# |* This header declares the C interface to libLLVMAnalysis.a, which           *|
# |* implements various analyses of the LLVM IR.                                *|
# |*                                                                            *|
# |* Many exotic languages can interoperate with C code but have a harder time  *|
# |* with C++ due to name mangling. So in addition to C, this interface enables *|
# |* tools written in such languages.                                           *|
# |*                                                                            *|
# \*===----------------------------------------------------------------------===

import prelude/platforms

import Types


type
    VerifierFailureAction* {.size: sizeof(cint).} = enum
        AbortProcessAction  ##  verifier will print to stderr and abort()
        PrintMessageAction  ##  verifier will print to stderr and return 1
        ReturnStatusAction  ##  verifier will just return 1


proc verifyModule*(m: ModuleRef; action: VerifierFailureAction;outMessage: cstringArray): Bool {.cdecl, importc: "LLVMVerifyModule", dynlib: LLVMlib.}
    ##  Verifies that a module is valid, taking the specified action if not.
    ##  Optionally returns a human-readable description of any invalid constructs.
    ##  OutMessage must be disposed with LLVMDisposeMessage.


proc verifyFunction*(fn: ValueRef; action: VerifierFailureAction): Bool {.cdecl, importc: "LLVMVerifyFunction", dynlib: LLVMlib.}
    ##  Verifies that a single function is valid, taking the specified action. Useful
    ##  for debugging.

proc viewFunctionCFG*(fn: ValueRef) {.cdecl, importc: "LLVMViewFunctionCFG", dynlib: LLVMlib.}
    ##  Open up a ghostview window that displays the CFG of the current function.
    ##  Useful for debugging.

proc viewFunctionCFGOnly*(fn: ValueRef) {.cdecl, importc: "LLVMViewFunctionCFGOnly", dynlib: LLVMlib.}
    ##  Open up a ghostview window that displays the CFG of the current function.
    ##  Useful for debugging.
