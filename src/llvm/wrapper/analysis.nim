
import ../raw

import
    types,
    core


export VerifierFailureAction
    # AbortProcessAction  ##  verifier will print to stderr and abort()
    # PrintMessageAction  ##  verifier will print to stderr and return 1
    # ReturnStatusAction  ##  verifier will just return 1


# proc verifyModule*(m: ModuleRef; action: VerifierFailureAction;outMessage: cstringArray): Bool {.cdecl, importc: "LLVMVerifyModule", dynlib: LLVMlib.}
proc verify*(self: Module, action: VerifierFailureAction = PrintMessageAction): bool {.discardable.} =
    ##  Verifies that a module is valid, taking the specified action if not.
    ##  Optionally returns a human-readable description of any invalid constructs.
    ##  Returns **false** on success, **true** otherwise.
    result = self.module.verifyModule(action, nil)


# proc verifyFunction*(fn: ValueRef; action: VerifierFailureAction): Bool {.cdecl, importc: "LLVMVerifyFunction", dynlib: LLVMlib.}
proc verify*(fn: Value, action: VerifierFailureAction = PrintMessageAction): bool {.discardable.} =
    ##  Verifies that a single function is valid, taking the specified action. Useful
    ##  for debugging.
    ##  Returns **false** on success, **true** otherwise.
    fn.value.verifyFunction(action)

# proc viewFunctionCFG*(fn: ValueRef) {.cdecl, importc: "LLVMViewFunctionCFG", dynlib: LLVMlib.}
#     ##  Open up a ghostview window that displays the CFG of the current function.
#     ##  Useful for debugging.

# proc viewFunctionCFGOnly*(fn: ValueRef) {.cdecl, importc: "LLVMViewFunctionCFGOnly", dynlib: LLVMlib.}
#     ##  Open up a ghostview window that displays the CFG of the current function.
#     ##  Useful for debugging.
