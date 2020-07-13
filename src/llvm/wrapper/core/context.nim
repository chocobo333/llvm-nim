
import ../raw

import types


type
    Context* = ref ContextObj


proc finalizer(self: Context) =
    ##  Finalizer a `Context` instance.
    ## 
    ##  This should be called for every call to `newContext`() or memory
    ##  will be leaked.
    ##  but, will be automatically called by runtime gc.
    if self.context.isNil:
        return
    self.context.contextDispose()

proc newContext*(): Context =
    ##  Create a new context.
    ##
    ##  Contexts are execution states for the core LLVM IR system.
    ##
    ##  Most types are tied to a context instance. Multiple contexts can
    ##  exist simultaneously. A single context is not thread safe. However,
    ##  different contexts can execute on different threads simultaneously.
    ## 
    ##  Wrapping:
    ##  * `contextCreate() <../llvm/Core.html#contextCreate>`_
    new[ContextObj](result, finalizer)
    result.context = contextCreate()

proc globalContext*(): Context =
    #  Obtain global context instance
    new[ContextObj](result, finalizer)
    result.context = getGlobalContext()