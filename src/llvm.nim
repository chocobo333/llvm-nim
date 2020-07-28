

{.passC: "`llvm-config --cflags`".}
{.passL: "`llvm-config --cflags --libs --ldflags all --system-libs`".}
{.passL: "-lLLVM".}
{.passL: "-Wl,-rpath `llvm-config --libdir`".}

import llvm/wrapper

export wrapper