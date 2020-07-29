
when defined(macosx):
    const
        LLVMlib* = "libLLVM.dylib"
elif defined(linux):
    const
        LLVMlib* = "libLLVM.so"