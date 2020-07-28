
const
    LLVMLib = "/usr/local/opt/llvm/"


{.passC: "`llvm-config --cflags`".}
{.passL: "`llvm-config --cflags --libs --ldflags all --system-libs`".}
{.passL: "-lLLVM".}
{.passL: "-Wl,-rpath " & LLVMLib.}

import llvm/wrapper

export wrapper