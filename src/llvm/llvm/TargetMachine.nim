# ===-- llvm-c/TargetMachine.h - Target Machine Library C Interface - C++ -*-=*\
# |*                                                                            *|
# |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
# |* Exceptions.                                                                *|
# |* See https://llvm.org/LICENSE.txt for license information.                  *|
# |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
# |*                                                                            *|
# |*===----------------------------------------------------------------------===*|
# |*                                                                            *|
# |* This header declares the C interface to the Target and TargetMachine       *|
# |* classes, which can be used to generate assembly or object files.           *|
# |*                                                                            *|
# |* Many exotic languages can interoperate with C code but have a harder time  *|
# |* with C++ due to name mangling. So in addition to C, this interface enables *|
# |* tools written in such languages.                                           *|
# |*                                                                            *|
# \*===----------------------------------------------------------------------===

import prelude/[
    opaques,
    platforms
]

import
    Types,
    Target

type
    TargetMachineRef* = ptr OpaqueTargetMachine

    TargetRef* = ptr target

    CodeGenOptLevel* {.size: sizeof(cint).} = enum
        CodeGenLevelNone
        CodeGenLevelLess
        CodeGenLevelDefault
        CodeGenLevelAggressive

    RelocMode* {.size: sizeof(cint).} = enum
        RelocDefault
        RelocStatic
        RelocPIC
        RelocDynamicNoPic
        RelocROPI
        RelocRWPI
        RelocROPI_RWPI

    CodeModel* {.size: sizeof(cint).} = enum
        CodeModelDefault
        CodeModelJITDefault
        CodeModelTiny
        CodeModelSmall
        CodeModelKernel
        CodeModelMedium
        CodeModelLarge

    CodeGenFileType* {.size: sizeof(cint).} = enum
        AssemblyFile
        ObjectFile


proc getFirstTarget*(): TargetRef {.cdecl, importc: "LLVMGetFirstTarget", dynlib: LLVMlib.}
    ## * Returns the first llvm::Target in the registered targets list.

proc getNextTarget*(t: TargetRef): TargetRef {.cdecl, importc: "LLVMGetNextTarget", dynlib: LLVMlib.}
    ## * Returns the next llvm::Target given a previous one (or null if there's none)

## ===-- Target ------------------------------------------------------------===
proc getTargetFromName*(name: cstring): TargetRef {.cdecl, importc: "LLVMGetTargetFromName", dynlib: LLVMlib.}
    ## * Finds the target corresponding to the given name and stores it in \p T.
    ##   Returns 0 on success.

proc getTargetFromTriple*(triple: cstring; t: ptr TargetRef;errorMessage: cstringArray): Bool {.cdecl, importc: "LLVMGetTargetFromTriple", dynlib: LLVMlib.}
    ## * Finds the target corresponding to the given triple and stores it in \p T.
    ##   Returns 0 on success. Optionally returns any error in ErrorMessage.
    ##   Use LLVMDisposeMessage to dispose the message.

proc getTargetName*(t: TargetRef): cstring {.cdecl, importc: "LLVMGetTargetName", dynlib: LLVMlib.}
    ## * Returns the name of a target. See llvm::Target::getName

proc getTargetDescription*(t: TargetRef): cstring {.cdecl, importc: "LLVMGetTargetDescription", dynlib: LLVMlib.}
    ## * Returns the description  of a target. See llvm::Target::getDescription

proc targetHasJIT*(t: TargetRef): Bool {.cdecl, importc: "LLVMTargetHasJIT", dynlib: LLVMlib.}
    ## * Returns if the target has a JIT

proc targetHasTargetMachine*(t: TargetRef): Bool {.cdecl, importc: "LLVMTargetHasTargetMachine", dynlib: LLVMlib.}
    ## * Returns if the target has a TargetMachine associated

proc targetHasAsmBackend*(t: TargetRef): Bool {.cdecl, importc: "LLVMTargetHasAsmBackend", dynlib: LLVMlib.}
    ## * Returns if the target as an ASM backend (required for emitting output)


## ===-- Target Machine ----------------------------------------------------===
proc createTargetMachine*(t: TargetRef; triple: cstring; cpu: cstring;features: cstring; level: CodeGenOptLevel;reloc: RelocMode;codeModel: CodeModel): TargetMachineRef {. cdecl, importc: "LLVMCreateTargetMachine", dynlib: LLVMlib.}
    ## * Creates a new llvm::TargetMachine. See llvm::Target::createTargetMachine

proc disposeTargetMachine*(t: TargetMachineRef) {.cdecl, importc: "LLVMDisposeTargetMachine", dynlib: LLVMlib.}
    ## * Dispose the LLVMTargetMachineRef instance generated by
    ##   LLVMCreateTargetMachine.

proc getTargetMachineTarget*(t: TargetMachineRef): TargetRef {.cdecl, importc: "LLVMGetTargetMachineTarget", dynlib: LLVMlib.}
    ## * Returns the Target used in a TargetMachine

proc getTargetMachineTriple*(t: TargetMachineRef): cstring {.cdecl, importc: "LLVMGetTargetMachineTriple", dynlib: LLVMlib.}
    ## * Returns the triple used creating this target machine. See
    ##   llvm::TargetMachine::getTriple. The result needs to be disposed with
    ##   LLVMDisposeMessage.

proc getTargetMachineCPU*(t: TargetMachineRef): cstring {.cdecl, importc: "LLVMGetTargetMachineCPU", dynlib: LLVMlib.}
    ## * Returns the cpu used creating this target machine. See
    ##   llvm::TargetMachine::getCPU. The result needs to be disposed with
    ##   LLVMDisposeMessage.

proc getTargetMachineFeatureString*(t: TargetMachineRef): cstring {.cdecl, importc: "LLVMGetTargetMachineFeatureString", dynlib: LLVMlib.}
    ## * Returns the feature string used creating this target machine. See
    ##   llvm::TargetMachine::getFeatureString. The result needs to be disposed with
    ##   LLVMDisposeMessage.

proc createTargetDataLayout*(t: TargetMachineRef): TargetDataRef {.cdecl, importc: "LLVMCreateTargetDataLayout", dynlib: LLVMlib.}
    ## * Create a DataLayout based on the targetMachine.

proc setTargetMachineAsmVerbosity*(t: TargetMachineRef; verboseAsm: Bool) {.cdecl, importc: "LLVMSetTargetMachineAsmVerbosity", dynlib: LLVMlib.}
    ## * Set the target machine's ASM verbosity.

proc targetMachineEmitToFile*(t: TargetMachineRef; m: ModuleRef; filename: cstring;codegen: CodeGenFileType;errorMessage: cstringArray): Bool {. cdecl, importc: "LLVMTargetMachineEmitToFile", dynlib: LLVMlib.}
    ## * Emits an asm or object file for the given module to the filename. This
    ##   wraps several c++ only classes (among them a file stream). Returns any
    ##   error in ErrorMessage. Use LLVMDisposeMessage to dispose the message.

proc targetMachineEmitToMemoryBuffer*(t: TargetMachineRef; m: ModuleRef;codegen: CodeGenFileType;errorMessage: cstringArray;outMemBuf: ptr MemoryBufferRef): Bool {.cdecl, importc: "LLVMTargetMachineEmitToMemoryBuffer", dynlib: LLVMlib.}
    ## * Compile the LLVM IR stored in \p M and store the result in \p OutMemBuf.


## ===-- Triple ------------------------------------------------------------===
proc getDefaultTargetTriple*(): cstring {.cdecl, importc: "LLVMGetDefaultTargetTriple", dynlib: LLVMlib.}
    ## * Get a triple for the host machine as a string. The result needs to be
    ##   disposed with LLVMDisposeMessage.

proc normalizeTargetTriple*(triple: cstring): cstring {.cdecl, importc: "LLVMNormalizeTargetTriple", dynlib: LLVMlib.}
    ## * Normalize a target triple. The result needs to be disposed with
    ##   LLVMDisposeMessage.

proc getHostCPUName*(): cstring {.cdecl, importc: "LLVMGetHostCPUName", dynlib: LLVMlib.}
    ## * Get the host CPU as a string. The result needs to be disposed with
    ##   LLVMDisposeMessage.

proc getHostCPUFeatures*(): cstring {.cdecl, importc: "LLVMGetHostCPUFeatures", dynlib: LLVMlib.}
    ## * Get the host CPU's features as a string. The result needs to be disposed
    ##   with LLVMDisposeMessage.

proc addAnalysisPasses*(t: TargetMachineRef; pm: PassManagerRef) {.cdecl, importc: "LLVMAddAnalysisPasses", dynlib: LLVMlib.}
    ## * Adds the target-specific analysis passes to the pass manager.
