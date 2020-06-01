
const
    LLVMRoot = "/usr/local/opt/llvm/"


{.passC: "`llvm-config --cflags`".}
{.passL: "`llvm-config --cflags --libs --ldflags all --system-libs`".}
{.passL: "-lLLVM".}
{.passL: "-Wl,-rpath " & LLVMRoot & "lib".}


import llvm/[
    Analysis,
    BitReader,
    BitWriter,
    Comdat,
    Core,
    Debuginfo,
    Disassembler,
    DisassemblerTypes,
    Error,
    ErrorHandling,
    ExecutionEngine,
    ExternC,
    Initialization,
    IRReader,
    Linker,
    LinkTimeOptimizer,
    lto,
    Object,
    OrcBindings,
    Remarks,
    Support,
    Target,
    TargetMachine,
    Types
]

import llvm/Transforms/[
    AggressiveInstCombine,
    Coroutines,
    InstCombine,
    IPO,
    PassManagerBuilder,
    Scalar,
    Utils,
    Vectorize
]

export
    Analysis,
    BitReader,
    BitWriter,
    Comdat,
    Core,
    Debuginfo,
    Disassembler,
    DisassemblerTypes,
    Error,
    ErrorHandling,
    ExecutionEngine,
    ExternC,
    Initialization,
    IRReader,
    Linker,
    LinkTimeOptimizer,
    lto,
    Object,
    OrcBindings,
    Remarks,
    Support,
    Target,
    TargetMachine,
    Types

export
    AggressiveInstCombine,
    Coroutines,
    InstCombine,
    IPO,
    PassManagerBuilder,
    Scalar,
    Utils,
    Vectorize