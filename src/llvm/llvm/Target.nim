
##  This header declares the C interface to libLLVMTarget.a, which
##  implements target information.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.

import prelude/[
    opaques,
    platforms
]

import Types

type
    ByteOrdering* {.size: sizeof(cint).} = enum
        BigEndian
        LittleEndian


type
    TargetDataRef* = ptr OpaqueTargetData
    TargetLibraryInfoRef* = ptr OpaqueTargetLibraryInfotData

proc initializeAllTargetInfos*() {.inline, cdecl.} =
    ##  Declare all of the target-initialization functions that are available.
    ##  Declare all of the available assembly printer initialization functions.
    ##  Declare all of the available assembly parser initialization functions.
    ##  Declare all of the available disassembler initialization functions.
    ## * LLVMInitializeAllTargetInfos - The main program should call this function if
    ##     it wants access to all available targets that LLVM is configured to
    ##     support.
    discard

proc initializeAllTargets*() {.inline, cdecl.} =
    ## * LLVMInitializeAllTargets - The main program should call this function if it
    ##     wants to link in all available targets that LLVM is configured to
    ##     support.
    discard

proc initializeAllTargetMCs*() {.inline, cdecl.} =
    ## * LLVMInitializeAllTargetMCs - The main program should call this function if
    ##     it wants access to all available target MC that LLVM is configured to
    ##     support.
    discard

proc initializeAllAsmPrinters*() {.inline, cdecl.} =
    ## * LLVMInitializeAllAsmPrinters - The main program should call this function if
    ##     it wants all asm printers that LLVM is configured to support, to make them
    ##     available via the TargetRegistry.
    discard

proc initializeAllAsmParsers*() {.inline, cdecl.} =
    ## * LLVMInitializeAllAsmParsers - The main program should call this function if
    ##     it wants all asm parsers that LLVM is configured to support, to make them
    ##     available via the TargetRegistry.
    discard


proc initializeAllDisassemblers*() {.inline, cdecl.} =
    ## * LLVMInitializeAllDisassemblers - The main program should call this function
    ##     if it wants all disassemblers that LLVM is configured to support, to make
    ##     them available via the TargetRegistry.



proc initializeNativeTarget*(): Bool {.inline, cdecl.} =
    ## * LLVMInitializeNativeTarget - The main program should call this function to
    ##     initialize the native target corresponding to the host.  This is useful
    ##     for JIT applications to ensure that the target gets linked in correctly.
    ##  If we have a native target, initialize it to ensure it is linked in.
    return 1


proc initializeNativeAsmParser*(): Bool {.inline, cdecl.} =
    ## * LLVMInitializeNativeTargetAsmParser - The main program should call this
    ##     function to initialize the parser for the native target corresponding to the
    ##     host.
    return 1


proc initializeNativeAsmPrinter*(): Bool {.inline, cdecl.} =
    ## * LLVMInitializeNativeTargetAsmPrinter - The main program should call this
    ##     function to initialize the printer for the native target corresponding to
    ##     the host.
    return 1


proc initializeNativeDisassembler*(): Bool {.inline, cdecl.} =
    ## * LLVMInitializeNativeTargetDisassembler - The main program should call this
    ##     function to initialize the disassembler for the native target corresponding
    ##     to the host.
    return 1

## ===-- Target Data -------------------------------------------------------===
proc getModuleDataLayout*(m: ModuleRef): TargetDataRef {.cdecl, importc: "LLVMGetModuleDataLayout", dynlib: LLVMlib.}
    ##  Obtain the data layout for a module.
    ##
    ##  @see Module::getDataLayout()

proc setModuleDataLayout*(m: ModuleRef; dl: TargetDataRef) {.cdecl, importc: "LLVMSetModuleDataLayout", dynlib: LLVMlib.}
    ##  Set the data layout for a module.
    ##
    ##  @see Module::setDataLayout()

proc createTargetData*(stringRep: cstring): TargetDataRef {.cdecl, importc: "LLVMCreateTargetData", dynlib: LLVMlib.}
        ## * Creates target data from a target layout string.
        ##     See the constructor llvm::DataLayout::DataLayout.

proc disposeTargetData*(td: TargetDataRef) {.cdecl, importc: "LLVMDisposeTargetData", dynlib: LLVMlib.}
    ## * Deallocates a TargetData.
    ##     See the destructor llvm::DataLayout::~DataLayout.

proc addTargetLibraryInfo*(tli: TargetLibraryInfoRef; pm: PassManagerRef) {.cdecl, importc: "LLVMAddTargetLibraryInfo", dynlib: LLVMlib.}
    ## * Adds target library information to a pass manager. This does not take
    ##     ownership of the target library info.
    ##     See the method llvm::PassManagerBase::add.

proc copyStringRepOfTargetData*(td: TargetDataRef): cstring {.cdecl, importc: "LLVMCopyStringRepOfTargetData", dynlib: LLVMlib.}
    ## * Converts target data to a target layout string. The string must be disposed
    ##     with LLVMDisposeMessage.
    ##     See the constructor llvm::DataLayout::DataLayout.

proc byteOrder*(td: TargetDataRef): ByteOrdering {.cdecl, importc: "LLVMByteOrder", dynlib: LLVMlib.}
    ## * Returns the byte order of a target, either LLVMBigEndian or
    ##     LLVMLittleEndian.
    ##     See the method llvm::DataLayout::isLittleEndian.

proc pointerSize*(td: TargetDataRef): cuint {.cdecl, importc: "LLVMPointerSize", dynlib: LLVMlib.}
    ## * Returns the pointer size in bytes for a target.
    ##     See the method llvm::DataLayout::getPointerSize.

proc pointerSizeForAS*(td: TargetDataRef; `as`: cuint): cuint {.cdecl, importc: "LLVMPointerSizeForAS", dynlib: LLVMlib.}
    ## * Returns the pointer size in bytes for a target for a specified
    ##     address space.
    ##     See the method llvm::DataLayout::getPointerSize.

proc intPtrType*(td: TargetDataRef): TypeRef {.cdecl, importc: "LLVMIntPtrType", dynlib: LLVMlib.}
    ## * Returns the integer type that is the same size as a pointer on a target.
    ##     See the method llvm::DataLayout::getIntPtrType.

proc intPtrTypeForAS*(td: TargetDataRef; `as`: cuint): TypeRef {.cdecl, importc: "LLVMIntPtrTypeForAS", dynlib: LLVMlib.}
    ## * Returns the integer type that is the same size as a pointer on a target.
    ##     This version allows the address space to be specified.
    ##     See the method llvm::DataLayout::getIntPtrType.

proc intPtrTypeInContext*(c: ContextRef; td: TargetDataRef): TypeRef {.cdecl, importc: "LLVMIntPtrTypeInContext", dynlib: LLVMlib.}
    ## * Returns the integer type that is the same size as a pointer on a target.
    ##     See the method llvm::DataLayout::getIntPtrType.

proc intPtrTypeForASInContext*(c: ContextRef; td: TargetDataRef;`as`: cuint): TypeRef {. cdecl, importc: "LLVMIntPtrTypeForASInContext", dynlib: LLVMlib.}
    ## * Returns the integer type that is the same size as a pointer on a target.
    ##     This version allows the address space to be specified.
    ##     See the method llvm::DataLayout::getIntPtrType.

proc sizeOfTypeInBits*(td: TargetDataRef; ty: TypeRef): culonglong {.cdecl, importc: "LLVMSizeOfTypeInBits", dynlib: LLVMlib.}
    ## * Computes the size of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeSizeInBits.

proc storeSizeOfType*(td: TargetDataRef; ty: TypeRef): culonglong {.cdecl, importc: "LLVMStoreSizeOfType", dynlib: LLVMlib.}
    ## * Computes the storage size of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeStoreSize.

proc aBISizeOfType*(td: TargetDataRef; ty: TypeRef): culonglong {.cdecl, importc: "LLVMABISizeOfType", dynlib: LLVMlib.}
    ## * Computes the ABI size of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeAllocSize.

proc aBIAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.cdecl, importc: "LLVMABIAlignmentOfType", dynlib: LLVMlib.}
    ## * Computes the ABI alignment of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeABISize.

proc callFrameAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.cdecl, importc: "LLVMCallFrameAlignmentOfType", dynlib: LLVMlib.}
    ## * Computes the call frame alignment of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeABISize.

proc preferredAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.cdecl, importc: "LLVMPreferredAlignmentOfType", dynlib: LLVMlib.}
    ## * Computes the preferred alignment of a type in bytes for a target.
    ##     See the method llvm::DataLayout::getTypeABISize.

proc preferredAlignmentOfGlobal*(td: TargetDataRef;globalVar: ValueRef): cuint {. cdecl, importc: "LLVMPreferredAlignmentOfGlobal", dynlib: LLVMlib.}
    ## * Computes the preferred alignment of a global variable in bytes for a target.
    ##     See the method llvm::DataLayout::getPreferredAlignment.

proc elementAtOffset*(td: TargetDataRef; structTy: TypeRef;offset: culonglong): cuint {. cdecl, importc: "LLVMElementAtOffset", dynlib: LLVMlib.}
    ## * Computes the structure element that contains the byte offset for a target.
    ##     See the method llvm::StructLayout::getElementContainingOffset.

proc offsetOfElement*(td: TargetDataRef; structTy: TypeRef;element: cuint): culonglong {. cdecl, importc: "LLVMOffsetOfElement", dynlib: LLVMlib.}
    ## * Computes the byte offset of the indexed struct element for a target.
    ##     See the method llvm::StructLayout::getElementContainingOffset.