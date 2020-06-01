
const
    LLVMRoot = "/usr/local/opt/llvm/"


{.passC: "`llvm-config --cflags`".}
{.passL: "`llvm-config --cflags --libs --ldflags all --system-libs`".}
{.passL: "-lLLVM".}
{.passL: "-Wl,-rpath " & LLVMRoot & "lib".}