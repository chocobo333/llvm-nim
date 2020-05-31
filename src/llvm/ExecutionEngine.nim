## ===-- llvm-c/ExecutionEngine.h - ExecutionEngine Lib C Iface --*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMExecutionEngine.o, which    *|
## |* implements various analyses of the LLVM IR.                                *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===
## *
##  @defgroup LLVMCExecutionEngine Execution Engine
##  @ingroup LLVMC
##
##  @{
##

proc linkInMCJIT*() {.cdecl, importc: "LLVMLinkInMCJIT", dynlib: LLVMlib.}
proc linkInInterpreter*() {.cdecl, importc: "LLVMLinkInInterpreter", dynlib: LLVMlib.}
type
    GenericValueRef* = ptr OpaqueGenericValue
    ExecutionEngineRef* = ptr OpaqueExecutionEngine
    MCJITMemoryManagerRef* = ptr OpaqueMCJITMemoryManager
    MCJITCompilerOptions* {.bycopy.} = object
        optLevel*: cuint
        codeModel*: CodeModel
        noFramePointerElim*: Bool
        enableFastISel*: Bool
        mcjmm*: MCJITMemoryManagerRef


## ===-- Operations on generic values --------------------------------------===

proc createGenericValueOfInt*(ty: TypeRef; n: culonglong;isSigned: Bool): GenericValueRef {. cdecl, importc: "LLVMCreateGenericValueOfInt", dynlib: LLVMlib.}
proc createGenericValueOfPointer*(p: pointer): GenericValueRef {.cdecl, importc: "LLVMCreateGenericValueOfPointer", dynlib: LLVMlib.}
proc createGenericValueOfFloat*(ty: TypeRef; n: cdouble): GenericValueRef {.cdecl, importc: "LLVMCreateGenericValueOfFloat", dynlib: LLVMlib.}
proc genericValueIntWidth*(genValRef: GenericValueRef): cuint {.cdecl, importc: "LLVMGenericValueIntWidth", dynlib: LLVMlib.}
proc genericValueToInt*(genVal: GenericValueRef; isSigned: Bool): culonglong {.cdecl, importc: "LLVMGenericValueToInt", dynlib: LLVMlib.}
proc genericValueToPointer*(genVal: GenericValueRef): pointer {.cdecl, importc: "LLVMGenericValueToPointer", dynlib: LLVMlib.}
proc genericValueToFloat*(tyRef: TypeRef; genVal: GenericValueRef): cdouble {.cdecl, importc: "LLVMGenericValueToFloat", dynlib: LLVMlib.}
proc disposeGenericValue*(genVal: GenericValueRef) {.cdecl, importc: "LLVMDisposeGenericValue", dynlib: LLVMlib.}
## ===-- Operations on execution engines -----------------------------------===

proc createExecutionEngineForModule*(outEE: ptr ExecutionEngineRef; m: ModuleRef;outError: cstringArray): Bool {.cdecl, importc: "LLVMCreateExecutionEngineForModule", dynlib: LLVMlib.}
proc createInterpreterForModule*(outInterp: ptr ExecutionEngineRef; m: ModuleRef;outError: cstringArray): Bool {.cdecl, importc: "LLVMCreateInterpreterForModule", dynlib: LLVMlib.}
proc createJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;optLevel: cuint;outError: cstringArray): Bool {. cdecl, importc: "LLVMCreateJITCompilerForModule", dynlib: LLVMlib.}
proc initializeMCJITCompilerOptions*(options: ptr MCJITCompilerOptions;sizeOfOptions: csize) {.cdecl, importc: "LLVMInitializeMCJITCompilerOptions", dynlib: LLVMlib.}
## *
##  Create an MCJIT execution engine for a module, with the given options. It is
##  the responsibility of the caller to ensure that all fields in Options up to
##  the given SizeOfOptions are initialized. It is correct to pass a smaller
##  value of SizeOfOptions that omits some fields. The canonical way of using
##  this is:
##
##  LLVMMCJITCompilerOptions options;
##  LLVMInitializeMCJITCompilerOptions(&options, sizeof(options));
##  ... fill in those options you care about
##  LLVMCreateMCJITCompilerForModule(&jit, mod, &options, sizeof(options),
##                                   &error);
##
##  Note that this is also correct, though possibly suboptimal:
##
##  LLVMCreateMCJITCompilerForModule(&jit, mod, 0, 0, &error);
##

proc createMCJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;options: ptr MCJITCompilerOptions;sizeOfOptions: csize;outError: cstringArray): Bool {. cdecl, importc: "LLVMCreateMCJITCompilerForModule", dynlib: LLVMlib.}
proc disposeExecutionEngine*(ee: ExecutionEngineRef) {.cdecl, importc: "LLVMDisposeExecutionEngine", dynlib: LLVMlib.}
proc runStaticConstructors*(ee: ExecutionEngineRef) {.cdecl, importc: "LLVMRunStaticConstructors", dynlib: LLVMlib.}
proc runStaticDestructors*(ee: ExecutionEngineRef) {.cdecl, importc: "LLVMRunStaticDestructors", dynlib: LLVMlib.}
proc runFunctionAsMain*(ee: ExecutionEngineRef; f: ValueRef; argC: cuint;argV: cstringArray; envP: cstringArray): cint {.cdecl, importc: "LLVMRunFunctionAsMain", dynlib: LLVMlib.}
proc runFunction*(ee: ExecutionEngineRef; f: ValueRef; numArgs: cuint;args: ptr GenericValueRef): GenericValueRef {.cdecl, importc: "LLVMRunFunction", dynlib: LLVMlib.}
proc freeMachineCodeForFunction*(ee: ExecutionEngineRef; f: ValueRef) {.cdecl, importc: "LLVMFreeMachineCodeForFunction", dynlib: LLVMlib.}
proc addModule*(ee: ExecutionEngineRef; m: ModuleRef) {.cdecl, importc: "LLVMAddModule", dynlib: LLVMlib.}
proc removeModule*(ee: ExecutionEngineRef; m: ModuleRef; outMod: ptr ModuleRef;outError: cstringArray): Bool {.cdecl, importc: "LLVMRemoveModule", dynlib: LLVMlib.}
proc findFunction*(ee: ExecutionEngineRef; name: cstring;outFn: ptr ValueRef): Bool {. cdecl, importc: "LLVMFindFunction", dynlib: LLVMlib.}
proc recompileAndRelinkFunction*(ee: ExecutionEngineRef;fn: ValueRef): pointer {. cdecl, importc: "LLVMRecompileAndRelinkFunction", dynlib: LLVMlib.}
proc getExecutionEngineTargetData*(ee: ExecutionEngineRef): TargetDataRef {.cdecl, importc: "LLVMGetExecutionEngineTargetData", dynlib: LLVMlib.}
proc getExecutionEngineTargetMachine*(ee: ExecutionEngineRef): TargetMachineRef {. cdecl, importc: "LLVMGetExecutionEngineTargetMachine", dynlib: LLVMlib.}
proc addGlobalMapping*(ee: ExecutionEngineRef; global: ValueRef;`addr`: pointer) {. cdecl, importc: "LLVMAddGlobalMapping", dynlib: LLVMlib.}
proc getPointerToGlobal*(ee: ExecutionEngineRef; global: ValueRef): pointer {.cdecl, importc: "LLVMGetPointerToGlobal", dynlib: LLVMlib.}
proc getGlobalValueAddress*(ee: ExecutionEngineRef; name: cstring): uint64T {.cdecl, importc: "LLVMGetGlobalValueAddress", dynlib: LLVMlib.}
proc getFunctionAddress*(ee: ExecutionEngineRef; name: cstring): uint64T {.cdecl, importc: "LLVMGetFunctionAddress", dynlib: LLVMlib.}
## ===-- Operations on memory managers -------------------------------------===

type
    MemoryManagerAllocateCodeSectionCallback * = proc (opaque: pointer;size: uintptrT;alignment: cuint; sectionID: cuint; sectionName: cstring): ptr uint8T {.cdecl.}
  MemoryManagerAllocateDataSectionCallback * = proc (opaque: pointer;size: uintptrT;alignment: cuint; sectionID: cuint; sectionName: cstring;isReadOnly: Bool): ptr uint8T {. cdecl.}
  MemoryManagerFinalizeMemoryCallback* = proc (opaque: pointer;errMsg: cstringArray): Bool {. cdecl.}
  MemoryManagerDestroyCallback* = proc (opaque: pointer) {.cdecl.}

## *
##  Create a simple custom MCJIT memory manager. This memory manager can
##  intercept allocations in a module-oblivious way. This will return NULL
##  if any of the passed functions are NULL.
##
##  @param Opaque An opaque client object to pass back to the callbacks.
##  @param AllocateCodeSection Allocate a block of memory for executable code.
##  @param AllocateDataSection Allocate a block of memory for data.
##  @param FinalizeMemory Set page permissions and flush cache. Return 0 on
##    success, 1 on error.
##

proc createSimpleMCJITMemoryManager*(opaque: pointer;allocateCodeSection: MemoryManagerAllocateCodeSectionCallback;allocateDataSection: MemoryManagerAllocateDataSectionCallback; finalizeMemory: MemoryManagerFinalizeMemoryCallback;destroy: MemoryManagerDestroyCallback): MCJITMemoryManagerRef {. cdecl, importc: "LLVMCreateSimpleMCJITMemoryManager", dynlib: LLVMlib.}
proc disposeMCJITMemoryManager*(mm: MCJITMemoryManagerRef) {.cdecl, importc: "LLVMDisposeMCJITMemoryManager", dynlib: LLVMlib.}
## ===-- JIT Event Listener functions -------------------------------------===

proc createGDBRegistrationListener*(): JITEventListenerRef {.cdecl, importc: "LLVMCreateGDBRegistrationListener", dynlib: LLVMlib.}
proc createIntelJITEventListener*(): JITEventListenerRef {.cdecl, importc: "LLVMCreateIntelJITEventListener", dynlib: LLVMlib.}
proc createOProfileJITEventListener*(): JITEventListenerRef {.cdecl, importc: "LLVMCreateOProfileJITEventListener", dynlib: LLVMlib.}
proc createPerfJITEventListener*(): JITEventListenerRef {.cdecl, importc: "LLVMCreatePerfJITEventListener", dynlib: LLVMlib.}
## *
##  @}
##
