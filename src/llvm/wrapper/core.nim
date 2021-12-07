

##  This module exposes parts of the LLVM library as a C API.
##
##  This modules provide an interface to libLLVMCore, which implements
##  the LLVM intermediate representation as well as other related types
##  and utilities.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.

## / External users depend on the following values being stable. It is not safe
## / to reorder them.

import ../raw

import types

import sequtils


# type ##  Terminator Instructions
#     ## *
#     ##  Emits an error if two values disagree, otherwise the resulting value is
#     ##  that of the operands.
#     ##
#     ##  @see Module::ModFlagBehavior::Error
#     ##
#     Opcode* {.size: sizeof(cint).} = enum
#         Ret = 1
#         Br = 2
#         Switch = 3
#         IndirectBr = 4
#         Invoke = 5              ##  removed 6 due to API changes
#         Unreachable = 7
#         Add = 8
#         FAdd = 9
#         Sub = 10
#         FSub = 11
#         Mul = 12
#         FMul = 13
#         UDiv = 14
#         SDiv = 15
#         FDiv = 16
#         URem = 17
#         SRem = 18
#         FRem = 19
#         ##  Logical Operators
#         Shl = 20
#         LShr = 21
#         AShr = 22
#         And = 23
#         Or = 24
#         Xor = 25
#         ##  Memory Operators
#         Alloca = 26
#         Load = 27
#         Store = 28
#         GetElementPtr = 29
#         ##  Cast Operators
#         Trunc = 30
#         ZExt = 31
#         SExt = 32
#         FPToUI = 33
#         FPToSI = 34
#         UIToFP = 35
#         SIToFP = 36
#         FPTrunc = 37
#         FPExt = 38
#         PtrToInt = 39
#         IntToPtr = 40
#         BitCast = 41
#         ICmp = 42
#         FCmp = 43,
#         PHI = 44
#         Call = 45
#         Select = 46
#         UserOp1 = 47
#         UserOp2 = 48
#         VAArg = 49
#         ExtractElement = 50,
#         InsertElement = 51
#         ShuffleVector = 52
#         ExtractValue = 53
#         InsertValue = 54
#         Fence = 55
#         AtomicCmpXchg = 56
#         AtomicRMW = 57
#         ##  Exception Handling Operators
#         Resume = 58
#         LandingPad = 59
#         AddrSpaceCast = 60
#         ##  Other Operators
#         CleanupRet = 61
#         CatchRet = 62
#         CatchPad = 63
#         CleanupPad = 64
#         CatchSwitch = 65
#         FNeg = 66
#         ##  Standard Binary Operators
#         CallBr = 67
#         ##  Standard Unary Operators
#         Freeze = 68 
#         ##  Atomic operators
#     Linkage* {.size: sizeof(cint).} = enum
#         ExternalLinkage             ## *< Externally visible function
#         AvailableExternallyLinkage
#         LinkOnceAnyLinkage          ## *< Keep one copy of function when linking (inline)
#         LinkOnceODRLinkage          ## *< Same, but only replaced by something
#                                     ## equivalent.
#         LinkOnceODRAutoHideLinkage  ## *< Obsolete
#         WeakAnyLinkage              ## *< Keep one copy of function when linking (weak)
#         WeakODRLinkage              ## *< Same, but only replaced by something
#                                     ## equivalent.
#         AppendingLinkage            ## *< Special purpose, only applies to global arrays
#         InternalLinkage             ## *< Rename collisions when linking (static
#                                     ## functions)
#         PrivateLinkage              ## *< Like Internal, but omit from symbol table
#         DLLImportLinkage            ## *< Obsolete
#         DLLExportLinkage            ## *< Obsolete
#         ExternalWeakLinkage         ## *< ExternalWeak linkage description
#         GhostLinkage                ## *< Obsolete
#         CommonLinkage               ## *< Tentative definitions
#         LinkerPrivateLinkage        ## *< Like Private, but linker removes.
#         LinkerPrivateWeakLinkage    ## *< Like LinkerPrivate, but is weak.
#     Visibility* {.size: sizeof(cint).} = enum
#         DefaultVisibility       ## *< The GV is visible
#         HiddenVisibility        ## *< The GV is hidden
#         ProtectedVisibility     ## *< The GV is protected
#     UnnamedAddr* {.size: sizeof(cint).} = enum
#         NoUnnamedAddr           ## *< Address of the GV is significant.
#         LocalUnnamedAddr        ## *< Address of the GV is locally insignificant.
#         GlobalUnnamedAddr       ## *< Address of the GV is globally insignificant.
#     DLLStorageClass* {.size: sizeof(cint).} = enum
#         DefaultStorageClass = 0
#         DLLImportStorageClass = 1   ## *< Function to be imported from DLL.
#         DLLExportStorageClass = 2
#     CallConv* {.size: sizeof(cint).} = enum
#         CCallConv = 0
#         FastCallConv = 8
#         ColdCallConv = 9
#         GHCCallConv = 10
#         HiPECallConv = 11
#         WebKitJSCallConv = 12
#         AnyRegCallConv = 13
#         PreserveMostCallConv = 14
#         PreserveAllCallConv = 15
#         SwiftCallConv = 16
#         CXXFASTTLSCallConv = 17
#         X86StdcallCallConv = 64
#         X86FastcallCallConv = 65
#         ARMAPCSCallConv = 66
#         ARMAAPCSCallConv = 67
#         ARMAAPCSVFPCallConv = 68
#         MSP430INTRCallConv = 69
#         X86ThisCallCallConv = 70
#         PTXKernelCallConv = 71
#         PTXDeviceCallConv = 72
#         SPIRFUNCCallConv = 75
#         SPIRKERNELCallConv = 76
#         IntelOCLBICallConv = 77
#         X8664SysVCallConv = 78
#         Win64CallConv = 79
#         X86VectorCallCallConv = 80
#         HHVMCallConv = 81
#         HHVMCCallConv = 82
#         X86INTRCallConv = 83
#         AVRINTRCallConv = 84
#         AVRSIGNALCallConv = 85
#         AVRBUILTINCallConv = 86
#         AMDGPUVSCallConv = 87
#         AMDGPUGSCallConv = 88
#         AMDGPUPSCallConv = 89
#         AMDGPUCSCallConv = 90
#         AMDGPUKERNELCallConv = 91
#         X86RegCallCallConv = 92
#         AMDGPUHSCallConv = 93
#         MSP430BUILTINCallConv = 94
#         AMDGPULSCallConv = 95
#         AMDGPUESCallConv = 96
#     IntPredicate* {.size: sizeof(cint).} = enum
#         IntEQ = 32  ## *< equal
#         IntNE       ## *< not equal
#         IntUGT      ## *< unsigned greater than
#         IntUGE      ## *< unsigned greater or equal
#         IntULT      ## *< unsigned less than
#         IntULE      ## *< unsigned less or equal
#         IntSGT      ## *< signed greater than
#         IntSGE      ## *< signed greater or equal
#         IntSLT      ## *< signed less than
#         IntSLE      ## *< signed less or equal
#     RealPredicate* {.size: sizeof(cint).} = enum
#         RealPredicateFalse  ## *< Always false (always folded)
#         RealOEQ             ## *< True if ordered and equal
#         RealOGT             ## *< True if ordered and greater than
#         RealOGE             ## *< True if ordered and greater than or equal
#         RealOLT             ## *< True if ordered and less than
#         RealOLE             ## *< True if ordered and less than or equal
#         RealONE             ## *< True if ordered and operands are unequal
#         RealORD             ## *< True if ordered (no nans)
#         RealUNO             ## *< True if unordered: isnan(X) | isnan(Y)
#         RealUEQ             ## *< True if unordered or equal
#         RealUGT             ## *< True if unordered or greater than
#         RealUGE             ## *< True if unordered, greater than, or equal
#         RealULT             ## *< True if unordered or less than
#         RealULE             ## *< True if unordered, less than, or equal
#         RealUNE             ## *< True if unordered or not equal
#         RealPredicateTrue   ## *< Always true (always folded)
#     LandingPadClauseTy* {.size: sizeof(cint).} = enum
#         LandingPadCatch     ## *< A catch clause
#         LandingPadFilter    ## *< A filter clause
#     ThreadLocalMode* {.size: sizeof(cint).} = enum
#         NotThreadLocal = 0
#         GeneralDynamicTLSModel
#         LocalDynamicTLSModel
#         InitialExecTLSModel
#         LocalExecTLSModel
#     AtomicOrdering* {.size: sizeof(cint).} = enum
#         AtomicOrderingNotAtomic = 0         ## *< A load or store which is not atomic
#         AtomicOrderingUnordered = 1         ## *< Lowest level of atomicity, guarantees
#                                             ## somewhat sane results, lock free.
#         AtomicOrderingMonotonic = 2         ## *< guarantees that if you take all the
#                                             ## operations affecting a specific address,
#                                             ## a consistent ordering exists
#         AtomicOrderingAcquire = 4           ## *< Acquire provides a barrier of the sort
#                                             ## necessary to acquire a lock to access other
#                                             ## memory with normal loads and stores.
#         AtomicOrderingRelease = 5           ## *< Release is similar to Acquire, but with
#                                             ## a barrier of the sort necessary to release
#                                             ## a lock.
#         AtomicOrderingAcquireRelease = 6    ## *< provides both an Acquire and a
#                                             ## Release barrier (for fences and
#                                             ## operations which both read and write
#                                             ## memory).
#         AtomicOrderingSequentiallyConsistent = 7
#     AtomicRMWBinOp* {.size: sizeof(cint).} = enum
#         AtomicRMWBinOpXchg  ## *< Set the new value and return the one old
#         AtomicRMWBinOpAdd   ## *< Add a value and return the old one
#         AtomicRMWBinOpSub   ## *< Subtract a value and return the old one
#         AtomicRMWBinOpAnd   ## *< And a value and return the old one
#         AtomicRMWBinOpNand  ## *< Not-And a value and return the old one
#         AtomicRMWBinOpOr    ## *< OR a value and return the old one
#         AtomicRMWBinOpXor   ## *< Xor a value and return the old one
#         AtomicRMWBinOpMax   ## *< Sets the value if it's greater than the
#                             ## original using a signed comparison and return
#                             ## the old one
#         AtomicRMWBinOpMin   ## *< Sets the value if it's Smaller than the
#                             ## original using a signed comparison and return
#                             ## the old one
#         AtomicRMWBinOpUMax  ## *< Sets the value if it's greater than the
#                             ## original using an unsigned comparison and return
#                             ## the old one
#         AtomicRMWBinOpUMin  ## *< Sets the value if it's greater than the
#                             ## original using an unsigned comparison and return
#                             ## the old one
#         AtomicRMWBinOpFAdd  ## *< Add a floating point value and return the
#                             ## old one
#         AtomicRMWBinOpFSub  ## *< Subtract a floating point value and return the
#                             ## old one
#     DiagnosticSeverity* {.size: sizeof(cint).} = enum
#         DSError
#         DSWarning
#         DSRemark
#         DSNote
#     InlineAsmDialect* {.size: sizeof(cint).} = enum
#         InlineAsmDialectATT
#         InlineAsmDialectIntel
#     ModuleFlagBehavior* {.size: sizeof(cint).} = enum
#         ModuleFlagBehaviorError     ## *
#                                     ##  Emits a warning if two values disagree. The result value will be the
#                                     ##  operand for the flag from the first module being linked.
#                                     ##
#                                     ##  @see Module::ModFlagBehavior::Warning
#                                     ##
#         ModuleFlagBehaviorWarning   ## *
#                                     ##  Adds a requirement that another module flag be present and have a
#                                     ##  specified value after linking is performed. The value must be a metadata
#                                     ##  pair, where the first element of the pair is the ID of the module flag
#                                     ##  to be restricted, and the second element of the pair is the value the
#                                     ##  module flag should be restricted to. This behavior can be used to
#                                     ##  restrict the allowable results (via triggering of an error) of linking
#                                     ##  IDs with the **Override** behavior.
#                                     ##
#                                     ##  @see Module::ModFlagBehavior::Require
#                                     ##
#         ModuleFlagBehaviorRequire   ## *
#                                     ##  Uses the specified value, regardless of the behavior or value of the
#                                     ##  other module. If both modules specify **Override**, but the values
#                                     ##  differ, an error will be emitted.
#                                     ##
#                                     ##  @see Module::ModFlagBehavior::Override
#                                     ##
#         ModuleFlagBehaviorOverride, ## *
#                                     ##  Appends the two values, which are required to be metadata nodes.
#                                     ##
#                                     ##  @see Module::ModFlagBehavior::Append
#                                     ##
#         ModuleFlagBehaviorAppend    ## *
#                                     ##  Appends the two values, which are required to be metadata
#                                     ##  nodes. However, duplicate entries in the second list are dropped
#                                     ##  during the append operation.
#                                     ##
#                                     ##  @see Module::ModFlagBehavior::AppendUnique
#                                     ##
#         ModuleFlagBehaviorAppendUnique

# const
#     AttributeReturnIndex* = 0
#     ##  ISO C restricts enumerator values to range of 'int'
#     ##  Attribute index are either LLVMAttributeReturnIndex,
#     ##  LLVMAttributeFunctionIndex or a parameter number from 1 to N.

#     AttributeFunctionIndex* = -1
#     ##  (4294967295 is too large)
#     ##  LLVMAttributeFunctionIndex = ~0U,

# type
#     AttributeIndex* = cuint

export
    Context,
    Module,
    Type,
    Value,
    BasicBlock,
    Builder

export
    VoidType,
    HalfType,
    FloatType,
    DoubleType,
    X86FP80Type,
    FP128Type,
    PPC_FP128Type,
    LabelType,
    IntegerType,
    FunctionType,
    StructType,
    ArrayType,
    PointerType,
    VectorType,
    MetadataType,
    X86MMXType,
    TokenType
export
    FunctionValue


# REGION: Kinds

export TypeKind
    # VoidTypeKind       ## *< type with no size
    # HalfTypeKind       ## *< 16 bit floating point type
    # FloatTypeKind      ## *< 32 bit floating point type
    # DoubleTypeKind     ## *< 64 bit floating point type
    # X86FP80TypeKind    ## *< 80 bit floating point type (X87)
    # FP128TypeKind      ## *< 128 bit floating point type (112-bit mantissa)
    # PPC_FP128TypeKind  ## *< 128 bit floating point type (two 64-bits)
    # LabelTypeKind      ## *< Labels
    # IntegerTypeKind    ## *< Arbitrary bit width integers
    # FunctionTypeKind   ## *< Functions
    # StructTypeKind     ## *< Structures
    # ArrayTypeKind      ## *< Arrays
    # PointerTypeKind    ## *< Pointers
    # VectorTypeKind     ## *< SIMD 'packed' format, or other vector type
    # MetadataTypeKind   ## *< Metadata
    # X86MMXTypeKind     ## *< X86 MMX
    # TokenTypeKind      ## *< Tokens

export ValueKind
    # ArgumentValueKind
    # BasicBlockValueKind
    # MemoryUseValueKind
    # MemoryDefValueKind
    # MemoryPhiValueKind
    # FunctionValueKind
    # GlobalAliasValueKind
    # GlobalIFuncValueKind
    # GlobalVariableValueKind
    # BlockAddressValueKind
    # ConstantExprValueKind
    # ConstantArrayValueKind
    # ConstantStructValueKind
    # ConstantVectorValueKind
    # UndefValueValueKind
    # ConstantAggregateZeroValueKind
    # ConstantDataArrayValueKind
    # ConstantDataVectorValueKind
    # ConstantIntValueKind
    # ConstantFPValueKind
    # ConstantPointerNullValueKind
    # ConstantTokenNoneValueKind
    # MetadataAsValueValueKind
    # InlineAsmValueKind
    # InstructionValueKind

# proc initializeCore*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeCore", dynlib: LLVMlib.}

# proc shutdown*() {.cdecl, importc: "LLVMShutdown", dynlib: LLVMlib.}
#     ## * Deallocate and destroy all ManagedStatic variables.
#     ##     @see llvm::llvm_shutdown
#     ##     @see ManagedStatic


# ## ===-- Error handling ----------------------------------------------------===

# proc createMessage*(message: cstring): cstring {.cdecl, importc: "LLVMCreateMessage", dynlib: LLVMlib.}
# proc disposeMessage*(message: cstring) {.cdecl, importc: "LLVMDisposeMessage", dynlib: LLVMlib.}


# type
#     DiagnosticHandler* = proc (a1: DiagnosticInfoRef; a2: pointer) {.cdecl.}
#     YieldCallback* = proc (a1: ContextRef; a2: pointer) {.cdecl.}


# REGION: Context

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
    newContext(contextCreate())

proc globalContext*(): Context =
    #  Obtain global context instance
    newContext(getGlobalContext())

# proc contextSetDiagnosticHandler*(c: ContextRef; handler: DiagnosticHandler;diagnosticContext: pointer) {.cdecl, importc: "LLVMContextSetDiagnosticHandler", dynlib: LLVMlib.}
#     ##  Set the diagnostic handler for this context.

# proc contextGetDiagnosticHandler*(c: ContextRef): DiagnosticHandler {.cdecl, importc: "LLVMContextGetDiagnosticHandler", dynlib: LLVMlib.}
#     ##  Get the diagnostic handler of this context.

# proc contextGetDiagnosticContext*(c: ContextRef): pointer {.cdecl, importc: "LLVMContextGetDiagnosticContext", dynlib: LLVMlib.}
#     ##  Get the diagnostic context of this context.

# proc contextSetYieldCallback*(c: ContextRef; callback: YieldCallback;opaqueHandle: pointer) {.cdecl, importc: "LLVMContextSetYieldCallback", dynlib: LLVMlib.}
#     ##  Set the yield callback function for this context.
#     ##
#     ##  @see LLVMContext::setYieldCallback()

# proc contextShouldDiscardValueNames*(c: ContextRef): Bool {.cdecl, importc: "LLVMContextShouldDiscardValueNames", dynlib: LLVMlib.}
#     ##  Retrieve whether the given context is set to discard all value names.
#     ##
#     ##  @see LLVMContext::shouldDiscardValueNames()

# proc contextSetDiscardValueNames*(c: ContextRef; `discard`: Bool) {.cdecl, importc: "LLVMContextSetDiscardValueNames", dynlib: LLVMlib.}
#     ##  Set whether the given context discards all value names.
#     ##
#     ##  If true, only the names of GlobalValue objects will be available in the IR.
#     ##  This can be used to save memory and runtime, especially in release mode.
#     ##
#     ##  @see LLVMContext::setDiscardValueNames()

# proc contextDispose*(c: ContextRef) {.cdecl, importc: "LLVMContextDispose", dynlib: LLVMlib.}
#     ##  Destroy a context instance.
#     ##
#     ##  This should be called for every call to LLVMContextCreate() or memory
#     ##  will be leaked.

# proc getDiagInfoDescription*(di: DiagnosticInfoRef): cstring {.cdecl, importc: "LLVMGetDiagInfoDescription", dynlib: LLVMlib.}
#     ##  Return a string representation of the DiagnosticInfo. Use
#     ##  LLVMDisposeMessage to free the string.
#     ##
#     ##  @see DiagnosticInfo::print()

# proc getDiagInfoSeverity*(di: DiagnosticInfoRef): DiagnosticSeverity {.cdecl, importc: "LLVMGetDiagInfoSeverity", dynlib: LLVMlib.}
#     ##  Return an enum LLVMDiagnosticSeverity.
#     ##
#     ##  @see DiagnosticInfo::getSeverity()

# proc getMDKindIDInContext*(c: ContextRef; name: cstring; sLen: cuint): cuint {.cdecl, importc: "LLVMGetMDKindIDInContext", dynlib: LLVMlib.}
# proc getMDKindID*(name: cstring; sLen: cuint): cuint {.cdecl, importc: "LLVMGetMDKindID", dynlib: LLVMlib.}

# proc getEnumAttributeKindForName*(name: cstring; sLen: csize_t): cuint {.cdecl, importc: "LLVMGetEnumAttributeKindForName", dynlib: LLVMlib.}
#     ##  Return an unique id given the name of a enum attribute,
#     ##  or 0 if no attribute by that name exists.
#     ##
#     ##  See http://llvm.org/docs/LangRef.html#parameter-attributes
#     ##  and http://llvm.org/docs/LangRef.html#function-attributes
#     ##  for the list of available attributes.
#     ##
#     ##  NB: Attribute names and/or id are subject to change without
#     ##  going through the C API deprecation cycle.

# proc getLastEnumAttributeKind*(): cuint {.cdecl, importc: "LLVMGetLastEnumAttributeKind", dynlib: LLVMlib.}

# proc createEnumAttribute*(c: ContextRef; kindID: cuint; val: uint64T): AttributeRef {. cdecl, importc: "LLVMCreateEnumAttribute", dynlib: LLVMlib.}
#     ##  Create an enum attribute.

# proc getEnumAttributeKind*(a: AttributeRef): cuint {.cdecl, importc: "LLVMGetEnumAttributeKind", dynlib: LLVMlib.}
#     ##  Get the unique id corresponding to the enum attribute
#     ##  passed as argument.

# proc getEnumAttributeValue*(a: AttributeRef): uint64T {.cdecl, importc: "LLVMGetEnumAttributeValue", dynlib: LLVMlib.}
#     ##  Get the enum attribute's value. 0 is returned if none exists.

# proc createStringAttribute*(c: ContextRef; k: cstring; kLength: cuint; v: cstring;vLength: cuint): AttributeRef {.cdecl, importc: "LLVMCreateStringAttribute", dynlib: LLVMlib.}
#     ##  Create a string attribute.

# proc getStringAttributeKind*(a: AttributeRef; length: ptr cuint): cstring {.cdecl, importc: "LLVMGetStringAttributeKind", dynlib: LLVMlib.}
#     ##  Get the string attribute's kind.

# proc getStringAttributeValue*(a: AttributeRef; length: ptr cuint): cstring {.cdecl, importc: "LLVMGetStringAttributeValue", dynlib: LLVMlib.}
#     ##  Get the string attribute's value.

# proc isEnumAttribute*(a: AttributeRef): Bool {.cdecl, importc: "LLVMIsEnumAttribute", dynlib: LLVMlib.}
#     ##  Check for the different types of attributes.
# proc isStringAttribute*(a: AttributeRef): Bool {.cdecl, importc: "LLVMIsStringAttribute", dynlib: LLVMlib.}


# REGION: Module

proc newModule*(name: string): Module =
    ##  Create a new, empty module in a specific context.
    ##
    ##  If `cxt` is **nil**, created module consists in the global cnotext.
    ##
    ##  This is equivalent to calling ``newModule(name, getGlobalContext())``
    ##
    ##  Wrapping:
    ##  * `moduleCreateWithName(cstring)<../llvm/Core.html#moduleCreateWithName,cstring>`_
    ##  * `moduleCreateWithNameInContext(cstring, ContextRef)<../llvm/Core.html#moduleCreateWithNameInContext,cstring,ContextRef>`_
    result = newModule(
        moduleCreateWithName(name)
    )
proc newModule*(name: string, cxt: Context): Module =
    ##  Create a new, empty module in a specific context.
    ##
    ##  If `cxt` is **nil**, created module consists in the global cnotext.
    ##
    ##  This is equivalent to calling ``newModule(name, getGlobalContext())``
    ##
    ##  Wrapping:
    ##  * `moduleCreateWithName(cstring)<../llvm/Core.html#moduleCreateWithName,cstring>`_
    ##  * `moduleCreateWithNameInContext(cstring, ContextRef)<../llvm/Core.html#moduleCreateWithNameInContext,cstring,ContextRef>`_
    result = newModule(
        moduleCreateWithNameInContext(name, cxt.context)
    )

proc clone*(self: Module): Module =
    ##  Return an exact copy of the specified module.
    ##  
    ##  See also:
    ##  * `newModule(string, Context)<#newModule,string,Context>`_
    ##  
    ##  Wrapping:
    ##  * `cloneModule(ModuleRef)<../llvm/Core.html#cloneModule,ModuleRef>`_
    newModule(cloneModule(self.module))

proc newModule*(other: Module): Module =
    ##  Return an exact copy of the specified module.
    ## 
    ##  See also:
    ##  * `newModule(string, Context)<#newModule,string,Context>`_
    ## 
    ##  Wrapping:
    ##  * `cloneModule(ModuleRef)<../llvm/Core.html#cloneModule,ModuleRef>`_
    result = other.clone()

proc identifier*(self: Module): string =
    ##  Obtain the identifier of a module.
    ## 
    ##  Wrapping:
    ##  * `getModuleIdentifier(ModuleRef, ptr csize_t)<../llvm/Core.html#getModuleIdentifier,ModuleRef,ptr.csize_t>`_
    var
        len: csize_t
    $self.module.getModuleIdentifier(len.addr)

proc `identifier=`*(self: Module, id: string) =
    ##  Set the identifier of a module to a string Ident with length Len.
    ##
    ##  Wrapping:
    ##  * `setModuleIdentifier(ModuleRef, ptr csize_t)<../llvm/Core.html#setModuleIdentifier,ModuleRef,cstring,csize_t>`_
    self.module.setModuleIdentifier(id, csize_t id.len)

proc sourceFileName*(self: Module): string =
    ##  Obtain the module's original source file name.
    ## 
    ##  Wrapping:
    ##  * `getSourceFileName(ModuleRef, ptr csize_t)<../llvm/Core.html#getSourceFileName,ModuleRef,ptr.csize_t>`_
    var
        len: csize_t
    $self.module.getSourceFileName(len.addr)

proc `sourceFileName=`*(self: Module, name: string) =
    ##  Set the original source file name of a module to a string Name.
    ## 
    ##  Wrapping:
    ##  * `setSourceFileName(ModuleRef, cstring, csize_t)<../llvm/Core.html#setSourceFileName,ModuleRef,cstring,csize_t>`_
    self.module.setSourceFileName(name, csize_t name.len)

proc dataLayout*(self: Module): string =
    ##  Obtain the data layout for a module.
    ##  Wrapping:
    ##  * `getDataLayoutStr(ModuleRef)<../llvm/Core.html#getDataLayoutStr,ModuleRef>`_
    $self.module.getDataLayoutStr()

proc `dataLayout=`*(self: Module, dataLayoutStr: string) =
    ##  Set the data layout for a module.
    ##  Wrapping:
    ##  * `setDataLayoutStr(ModuleRef, cstring)<../llvm/Core.html#setDataLayout,ModuleRef,cstring>`_
    self.module.setDataLayout(dataLayoutStr)

proc target*(self: Module): string =
    ##  Obtain the target triple for a module.
    ##  Wrapping:
    ##  * `getTarget(ModuleRef)<../llvm/Core.html#getTarget,ModuleRef>`_
    $self.module.getTarget()

proc `target=`*(self: Module, triple: string) =
    ##  Set the target triple for a module.
    ##  Wrapping:
    ##  * `setTarget(ModuleRef,cstring)<../llvm/Core.html#setTarget,ModuleRef,cstring>`_
    self.module.setTarget(triple)

# proc copyModuleFlagsMetadata*(m: ModuleRef;len: ptr csize_t): ptr ModuleFlagEntry {. cdecl, importc: "LLVMCopyModuleFlagsMetadata", dynlib: LLVMlib.}
#     ##  Returns the module flags as an array of flag-key-value triples.  The caller
#     ##  is responsible for freeing this array by calling
#     ##  \c LLVMDisposeModuleFlagsMetadata.
#     ##
#     ##  @see Module::getModuleFlagsMetadata()

# proc disposeModuleFlagsMetadata*(entries: ptr ModuleFlagEntry) {.cdecl, importc: "LLVMDisposeModuleFlagsMetadata", dynlib: LLVMlib.}
# ##    Destroys module flags metadata entries.

# proc moduleFlagEntriesGetFlagBehavior*(entries: ptr ModuleFlagEntry;index: cuint): ModuleFlagBehavior {. cdecl, importc: "LLVMModuleFlagEntriesGetFlagBehavior", dynlib: LLVMlib.}
#     ##  Returns the flag behavior for a module flag entry at a specific index.
#     ##
#     ##  @see Module::ModuleFlagEntry::Behavior

# proc moduleFlagEntriesGetKey*(entries: ptr ModuleFlagEntry; index: cuint;len: ptr csize_t): cstring {.cdecl, importc: "LLVMModuleFlagEntriesGetKey", dynlib: LLVMlib.}
#     ##  Returns the key for a module flag entry at a specific index.
#     ##
#     ##  @see Module::ModuleFlagEntry::Key

# proc moduleFlagEntriesGetMetadata*(entries: ptr ModuleFlagEntry;index: cuint): MetadataRef {. cdecl, importc: "LLVMModuleFlagEntriesGetMetadata", dynlib: LLVMlib.}
#     ##  Returns the metadata for a module flag entry at a specific index.
#     ##
#     ##  @see Module::ModuleFlagEntry::Val

# proc getModuleFlag*(m: ModuleRef; key: cstring; keyLen: csize_t): MetadataRef {.cdecl, importc: "LLVMGetModuleFlag", dynlib: LLVMlib.}
#     ##  Add a module-level flag to the module-level flags metadata if it doesn't
#     ##  already exist.
#     ##
#     ##  @see Module::getModuleFlag()

# proc addModuleFlag*(m: ModuleRef; behavior: ModuleFlagBehavior; key: cstring;keyLen: csize_t; val: MetadataRef) {.cdecl, importc: "LLVMAddModuleFlag", dynlib: LLVMlib.}
#     ##  Add a module-level flag to the module-level flags metadata if it doesn't
#     ##  already exist.
#     ##
#     ##  @see Module::addModuleFlag()

proc dump*(self: Module) =
    ##  Dump a representation of a module to stderr.
    ##
    ##  Wrapping:
    ##  * `dumpModule(ModuleRef)<../llvm/Core.html#dumpModule,ModuleRef>`_
    self.module.dumpModule()
    
proc printToFile*(self: Module, filename: string): bool {.discardable.} =
    ##  Print a representation of a module to a file.
    ##  Returns **false** on success, **true** otherwise.
    ## 
    ##  Wrapping:
    ##  * `printModuleToFile(ModuleRef, cstring, cstringArray)<../llvm/Core.html#printModuleToFile,ModuleRef,cstring,cstringArray>`_
    var
        err = allocCStringArray([])
    result = self.module.printModuleToFile(filename, err)
    # FIXME:
    if err[0] != "":
        stderr.writeLine err[0]
    err[0].disposeMessage
    deallocCStringArray(err)

proc `$`*(self: Module): string =
    ##  Return a string representation of the module.
    ## 
    ##  Wrapping:
    ##  * `printModuleToString(ModuleRef)<../llvm/Core.html#printModuleToString,ModuleRef>`_
    var
        tmp = self.module.printModuleToString()
    result = $tmp
    tmp.disposeMessage()

# proc getModuleInlineAsm*(m: ModuleRef; len: ptr csize_T): cstring {.cdecl, importc: "LLVMGetModuleInlineAsm", dynlib: LLVMlib.}
#     ##  Get inline assembly for a module.
#     ##
#     ##  @see Module::getModuleInlineAsm()

# proc setModuleInlineAsm2*(m: ModuleRef; `asm`: cstring; len: csize_t) {.cdecl, importc: "LLVMSetModuleInlineAsm2", dynlib: LLVMlib.}
#     ##  Set inline assembly for a module.
#     ##
#     ##  @see Module::setModuleInlineAsm()

# proc appendModuleInlineAsm*(m: ModuleRef; `asm`: cstring; len: csize_t) {.cdecl, importc: "LLVMAppendModuleInlineAsm", dynlib: LLVMlib.}
#     ##  Append inline assembly to a module.
#     ##
#     ##  @see Module::appendModuleInlineAsm()

# proc getInlineAsm*(ty: TypeRef; asmString: cstring; asmStringSize: csize_t; constraints: cstring; constraintsSize: csize_t;hasSideEffects: Bool; isAlignStack: Bool;dialect: InlineAsmDialect): ValueRef {.cdecl, importc: "LLVMGetInlineAsm", dynlib: LLVMlib.}
#     ##  Create the specified uniqued inline asm string.
#     ##
#     ##  @see InlineAsm::get()

proc context*(self: Module): Context =
    ##  Obtain the context to which this module is associated.
    ## 
    ##  Wrapping:
    ##  * `getModuleContext(ModuleRef)<../llvm/Core.html#getModuleContext,ModuleRef>`_
    self.context

# proc getTypeByName*(m: ModuleRef; name: cstring): TypeRef {.cdecl, importc: "LLVMGetTypeByName", dynlib: LLVMlib.}
#     ##  Obtain a Type from a module by its registered name.

# proc getFirstNamedMetadata*(m: ModuleRef): NamedMDNodeRef {.cdecl, importc: "LLVMGetFirstNamedMetadata", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the first NamedMDNode in a Module.
#     ##
#     ##  @see llvm::Module::named_metadata_begin()

# proc getLastNamedMetadata*(m: ModuleRef): NamedMDNodeRef {.cdecl, importc: "LLVMGetLastNamedMetadata", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the last NamedMDNode in a Module.
#     ##
#     ##  @see llvm::Module::named_metadata_end()

# proc getNextNamedMetadata*(namedMDNode: NamedMDNodeRef): NamedMDNodeRef {.cdecl, importc: "LLVMGetNextNamedMetadata", dynlib: LLVMlib.}
#     ##  Advance a NamedMDNode iterator to the next NamedMDNode.
#     ##
#     ##  Returns NULL if the iterator was already at the end and there are no more
#     ##  named metadata nodes.

# proc getPreviousNamedMetadata*(namedMDNode: NamedMDNodeRef): NamedMDNodeRef {.cdecl, importc: "LLVMGetPreviousNamedMetadata", dynlib: LLVMlib.}
#     ##  Decrement a NamedMDNode iterator to the previous NamedMDNode.
#     ##
#     ##  Returns NULL if the iterator was already at the beginning and there are
#     ##  no previous named metadata nodes.

# proc getNamedMetadata*(m: ModuleRef; name: cstring;nameLen: csize_t): NamedMDNodeRef {. cdecl, importc: "LLVMGetNamedMetadata", dynlib: LLVMlib.}
#     ##  Retrieve a NamedMDNode with the given name, returning NULL if no such
#     ##  node exists.
#     ##
#     ##  @see llvm::Module::getNamedMetadata()

# proc getOrInsertNamedMetadata*(m: ModuleRef; name: cstring; nameLen: csize_t): NamedMDNodeRef {. cdecl, importc: "LLVMGetOrInsertNamedMetadata", dynlib: LLVMlib.}
#     ##  Retrieve a NamedMDNode with the given name, creating a new node if no such
#     ##  node exists.
#     ##
#     ##  @see llvm::Module::getOrInsertNamedMetadata()

# proc getNamedMetadataName*(namedMD: NamedMDNodeRef;nameLen: ptr csize_t): cstring {. cdecl, importc: "LLVMGetNamedMetadataName", dynlib: LLVMlib.}
#     ##  Retrieve the name of a NamedMDNode.
#     ##
#     ##  @see llvm::NamedMDNode::getName()

# proc getNamedMetadataNumOperands*(m: ModuleRef; name: cstring): cuint {.cdecl, importc: "LLVMGetNamedMetadataNumOperands", dynlib: LLVMlib.}
#     ##  Obtain the number of operands for named metadata in a module.
#     ##
#     ##  @see llvm::Module::getNamedMetadata()

# proc getNamedMetadataOperands*(m: ModuleRef; name: cstring; dest: ptr ValueRef) {.cdecl, importc: "LLVMGetNamedMetadataOperands", dynlib: LLVMlib.}
#     ##  Obtain the named metadata operands for a module.
#     ##
#     ##  The passed LLVMValueRef pointer should refer to an array of
#     ##  LLVMValueRef at least LLVMGetNamedMetadataNumOperands long. This
#     ##  array will be populated with the LLVMValueRef instances. Each
#     ##  instance corresponds to a llvm::MDNode.
#     ##
#     ##  @see llvm::Module::getNamedMetadata()
#     ##  @see llvm::MDNode::getOperand()

# proc addNamedMetadataOperand*(m: ModuleRef; name: cstring; val: ValueRef) {.cdecl, importc: "LLVMAddNamedMetadataOperand", dynlib: LLVMlib.}
#     ##  Add an operand to named metadata.
#     ##
#     ##  @see llvm::Module::getNamedMetadata()
#     ##  @see llvm::MDNode::addOperand()

# proc getDebugLocDirectory*(val: ValueRef; length: ptr cuint): cstring {.cdecl, importc: "LLVMGetDebugLocDirectory", dynlib: LLVMlib.}
#     ##  Return the directory of the debug location for this value, which must be
#     ##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
#     ##
#     ##  @see llvm::Instruction::getDebugLoc()
#     ##  @see llvm::GlobalVariable::getDebugInfo()
#     ##  @see llvm::Function::getSubprogram()

# proc getDebugLocFilename*(val: ValueRef; length: ptr cuint): cstring {.cdecl, importc: "LLVMGetDebugLocFilename", dynlib: LLVMlib.}
#     ##  Return the filename of the debug location for this value, which must be
#     ##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
#     ##
#     ##  @see llvm::Instruction::getDebugLoc()
#     ##  @see llvm::GlobalVariable::getDebugInfo()
#     ##  @see llvm::Function::getSubprogram()

# proc getDebugLocLine*(val: ValueRef): cuint {.cdecl, importc: "LLVMGetDebugLocLine", dynlib: LLVMlib.}
#     ##  Return the line number of the debug location for this value, which must be
#     ##  an llvm::Instruction, llvm::GlobalVariable, or llvm::Function.
#     ##
#     ##  @see llvm::Instruction::getDebugLoc()
#     ##  @see llvm::GlobalVariable::getDebugInfo()
#     ##  @see llvm::Function::getSubprogram()

# proc getDebugLocColumn*(val: ValueRef): cuint {.cdecl, importc: "LLVMGetDebugLocColumn", dynlib: LLVMlib.}
#     ##  Return the column number of the debug location for this value, which must be
#     ##  an llvm::Instruction.
#     ##
#     ##  @see llvm::Instruction::getDebugLoc()

proc addFunction*(self: Module, name: string, fnty: FunctionType): FunctionValue =
    ##  Add a function to a module under a specified name.
    ## 
    ##  Wrapping:
    ##  * `addFunction(Moduleref, cstring, TypeRef)<../llvm/Core.html#addFunction,ModuleRef,cstring,TypeRef>`_
    runnableExamples:
        import llvm

        var
            `mod` = newModule("main")
            fnty = functionType(voidType(), @[])
            fn = `mod`.addFunction("test", fnty)

        assert $`mod` == """; ModuleID = 'main'
source_filename = "main"

declare void @test()
"""
    assert fnty.kind == FunctionTypeKind
    newValue[FunctionValue](self.module.addFunction(name, fnty.typ))

# proc getNamedFunction*(m: ModuleRef; name: cstring): ValueRef {.cdecl, importc: "LLVMGetNamedFunction", dynlib: LLVMlib.}
#     ##  Obtain a Function value from a Module by its name.
#     ##
#     ##  The returned value corresponds to a llvm::Function value.
#     ##
#     ##  @see llvm::Module::getFunction()

# proc getFirstFunction*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetFirstFunction", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the first Function in a Module.
#     ##
#     ##  @see llvm::Module::begin()
proc firstFunction*(m: Module): FunctionValue =
    newValue[FunctionValue](m.module.getFirstFunction())

# proc getLastFunction*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetLastFunction", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the last Function in a Module.
#     ##
#     ##  @see llvm::Module::end()
proc lastFunction*(m: Module): FunctionValue =
    newValue[FunctionValue](m.module.getLastFunction())

# proc getNextFunction*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextFunction", dynlib: LLVMlib.}
#     ##  Advance a Function iterator to the next Function.
#     ##
#     ##  Returns NULL if the iterator was already at the end and there are no more
#     ##  functions.
proc nextFunction*(v: FunctionValue): FunctionValue =
    let a = v.value.getNextFunction()
    if a.isNil:
        nil
    else:
        newValue[FunctionValue](a)

iterator funcs*(m: Module): FunctionValue =
    var ret = m.firstFunction
    while not ret.isNil:
        yield ret
        ret = ret.nextFunction

# proc getPreviousFunction*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousFunction", dynlib: LLVMlib.}
#     ##  Decrement a Function iterator to the previous Function.
#     ##
#     ##  Returns NULL if the iterator was already at the beginning and there are
#     ##  no previous functions.

# proc setModuleInlineAsm*(m: ModuleRef; `asm`: cstring) {.cdecl, importc: "LLVMSetModuleInlineAsm", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMSetModuleInlineAsm2 instead.



# REGION: Type

proc kind*(self: Type): TypeKind =
    ##  Obtain the enumerated type of a Type instance.
    ## 
    ##  Wrapping:
    ##  * `getTypeKind(TypeRef)<../llvm/Core.html#getTypeKind,TypeRef>`_
    runnableExamples:
        from llvm/raw import getTypeKind

        var
            llInt = intType(113)

        assert llInt.kind == llInt.typ.getTypeKind()
    self.kind

proc isSized*(self: Type): bool =
    ##  Whether the type has a known size.
    ##
    ##  Things that don't have a size are abstract types, labels, and void.a
    ##  Wrapping:
    ##  * `typeIsSized(TypeRef)<../llvm/Core.html#typeIsSized,TypeRef>`_
    runnableExamples:
        assert intType(113).isSized
        assert not voidType().isSized
        assert not functionType(voidType(), @[]).isSized
    self.typ.typeIsSized()

# proc getTypeContext*(ty: TypeRef): ContextRef {.cdecl, importc: "LLVMGetTypeContext", dynlib: LLVMlib.}
#     ##  Obtain the context to which this type instance is associated.
#     ##
#     ##  @see llvm::Type::getContext()

proc dump*(self: Type) =
    ##  Dump a representation of a type to stderr.
    ## 
    ##  Wrapping:
    ##  * `dumpType(TypeRef)<../llvm/Core.html#dumpType,TypeRef>`_
    self.typ.dumpType()

proc `$`*(self: Type): string =
    ##  Return a string representation of the type. Use
    ## 
    ##  Wrapping:
    ##  * `printTypeToString(TypeRef)<../llvm/Core.html#printTypeToString,TypeRef>`_
    runnableExamples:
        var
            llInt = intType(113)
                
        assert $llInt == "i113"
    var
        tmp = self.typ.printTypeToString()
    result = $tmp
    tmp.disposeMessage()


# ##  Functions in this section operate on integer types.

# ##  Obtain an integer type from a context with specified bit width.
# proc int1TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt1TypeInContext", dynlib: LLVMlib.}
# proc int8TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt8TypeInContext", dynlib: LLVMlib.}
# proc int16TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt16TypeInContext", dynlib: LLVMlib.}
# proc int32TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt32TypeInContext", dynlib: LLVMlib.}
# proc int64TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt64TypeInContext", dynlib: LLVMlib.}
# proc int128TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMInt128TypeInContext", dynlib: LLVMlib.}
# proc intTypeInContext*(c: ContextRef; numBits: cuint): TypeRef {.cdecl, importc: "LLVMIntTypeInContext", dynlib: LLVMlib.}

proc intType*(cxt: Context, nbits: uint): IntegerType =
    ##  Obtain an integer type from the global context with a specified bit
    ##  width.
    ## 
    ##  Wrapping:
    ##  * `intTypeInContext(cuint)<../llvm/Core.html#intTypeInContext,ContextRef,cuint>`_
    runnableExamples:
        var
            cxt = globalContext()
            llInt = cxt.intType(113)

        assert $llInt == "i113"
    newType[IntegerType](cxt.context.intTypeInContext(cuint nbits))

# ##  Obtain an integer type from the global context with a specified bit
# ##  width.
# proc int1Type*(): TypeRef {.cdecl, importc: "LLVMInt1Type", dynlib: LLVMlib.}
# proc int8Type*(): TypeRef {.cdecl, importc: "LLVMInt8Type", dynlib: LLVMlib.}
# proc int16Type*(): TypeRef {.cdecl, importc: "LLVMInt16Type", dynlib: LLVMlib.}
# proc int32Type*(): TypeRef {.cdecl, importc: "LLVMInt32Type", dynlib: LLVMlib.}
# proc int64Type*(): TypeRef {.cdecl, importc: "LLVMInt64Type", dynlib: LLVMlib.}
# proc int128Type*(): TypeRef {.cdecl, importc: "LLVMInt128Type", dynlib: LLVMlib.}
proc intType*(nbits: uint): IntegerType =
    ##  Obtain an integer type from the global context with a specified bit
    ##  width.
    ## 
    ##  Wrapping:
    ##  * `intType(cuint)<../llvm/Core.html#intType,cuint>`_
    runnableExamples:
        var
            llInt = intType(113)

        assert $llInt == "i113"
    newType[IntegerType](intType(cuint nbits))
# proc getIntTypeWidth*(integerTy: TypeRef): cuint {.cdecl, importc: "LLVMGetIntTypeWidth", dynlib: LLVMlib.}


# proc halfTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMHalfTypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 16-bit floating point type from a context.

# proc floatTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMFloatTypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 32-bit floating point type from a context.
proc floatType*(cxt: Context): FloatType =
    newType[FloatType](floatTypeInContext(cxt.context))

# proc doubleTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMDoubleTypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 64-bit floating point type from a context.

# proc x86FP80TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMX86FP80TypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 80-bit floating point type (X87) from a context.

# proc fP128TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMFP128TypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 128-bit floating point type (112-bit mantissa) from a
#     ##  context.

# proc pPCFP128TypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMPPCFP128TypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 128-bit floating point type (two 64-bits) from a context.


# ##  Obtain a floating point type from the global context.
# ##
# ##  These map to the functions in this group of the same name.
# proc halfType*(): TypeRef {.cdecl, importc: "LLVMHalfType", dynlib: LLVMlib.}
# proc floatType*(): TypeRef {.cdecl, importc: "LLVMFloatType", dynlib: LLVMlib.}
# proc doubleType*(): TypeRef {.cdecl, importc: "LLVMDoubleType", dynlib: LLVMlib.}
# proc x86FP80Type*(): TypeRef {.cdecl, importc: "LLVMX86FP80Type", dynlib: LLVMlib.}
# proc fP128Type*(): TypeRef {.cdecl, importc: "LLVMFP128Type", dynlib: LLVMlib.}
# proc pPCFP128Type*(): TypeRef {.cdecl, importc: "LLVMPPCFP128Type", dynlib: LLVMlib.}


proc functionType*(retTy: Type, paramTypes: openArray[Type], isVarArg: bool = false): FunctionType =
    ##  Obtain a function type consisting of a specified signature.
    ##
    ##  The function is defined as a tuple of a return Type, a list of
    ##  parameter types, and whether the function is variadic.
    ## 
    ##  Wrapping:
    ##  * `functionType(TypeRef, ptr TypeRef, cuint, Bool)<../llvm/Core.html#functionType,TypeRef,ptr.TypeRef,cuint,Bool>`_
    runnableExamples:
        var
            fnty = functionType(voidType(), (@[Type intType(64), intType(32)]))

        assert $fnty == "void (i64, i32)"
    runnableExamples:
        var
            fnty = functionType(intType(32), @[])

        assert $fnty == "i32 ()"
    var
        s = paramTypes.map(proc(a: Type): TypeRef = a.typ)
        adr = if s.len > 0: s[0].addr else: nil
    newType[FunctionType](functionType(retTy.typ, adr, cuint s.len, isVarArg))

# proc isFunctionVarArg*(functionTy: TypeRef): Bool {.cdecl, importc: "LLVMIsFunctionVarArg", dynlib: LLVMlib.}
#     ##  Returns whether a function type is variadic.

# proc getReturnType*(functionTy: TypeRef): TypeRef {.cdecl, importc: "LLVMGetReturnType", dynlib: LLVMlib.}
#     ##  Obtain the Type this function Type returns.

# proc countParamTypes*(functionTy: TypeRef): cuint {.cdecl, importc: "LLVMCountParamTypes", dynlib: LLVMlib.}
#     ##  Obtain the number of parameters this function accepts.

# proc getParamTypes*(functionTy: TypeRef; dest: ptr TypeRef) {.cdecl, importc: "LLVMGetParamTypes", dynlib: LLVMlib.}
#     ##  Obtain the types of a function's parameters.
#     ##
#     ##  The Dest parameter should point to a pre-allocated array of
#     ##  LLVMTypeRef at least LLVMCountParamTypes() large. On return, the
#     ##  first LLVMCountParamTypes() entries in the array will be populated
#     ##  with LLVMTypeRef instances.
#     ##
#     ##  @param FunctionTy The function type to operate on.
#     ##  @param Dest Memory address of an array to be filled with result.


# ##  These functions relate to LLVMTypeRef instances.
# ##
# ##  @see llvm::StructType
proc createStruct*(cxt: Context, elementTypes: openArray[Type], packed: bool = false): StructType =
    ##  Create a new structure type in a context.
    ##
    ##  A structure is specified by a list of inner elements/types and
    ##  whether these can be packed together.
    ## 
    ##  Wrapping:
    ##  * `structTypeInContext(cxt: Context, elementTypes: openArray[Type], packed: bool)<../llvm/Core.html#structTypeInContext,ContextRef,ptr.TypeRef,cuint,Bool>`_
    var
        s = elementTypes.map(proc(a: Type): TypeRef = a.typ)
        adr = if s.len > 0: s[0].addr else: nil
    newType[StructType](structTypeInContext(cxt.context, adr, cuint s.len, packed))

# proc structType*(elementTypes: ptr TypeRef; elementCount: cuint;packed: Bool): TypeRef {. cdecl, importc: "LLVMStructType", dynlib: LLVMlib.}
#     ##  Create a new structure type in the global context.
#     ##
#     ##  @see llvm::StructType::create()

proc createStruct*(cxt: Context, name: string): StructType =
    ##  Create an empty structure in a context having a specified name.
    ## 
    ##  Wrapping:
    ##  * `structCreateNamed(c: ContextRef; name: cstring)<../llvm/Core.html#createStruct,ContextRef,cstring>`_
    newType[StructType](structCreateNamed(cxt.context, name))

# proc getStructName*(ty: TypeRef): cstring {.cdecl, importc: "LLVMGetStructName", dynlib: LLVMlib.}
#     ##  Obtain the name of a structure.
#     ##
#     ##  @see llvm::StructType::getName()

# proc structSetBody*(structTy: TypeRef; elementTypes: ptr TypeRef; elementCount: cuint;packed: Bool) {.cdecl, importc: "LLVMStructSetBody", dynlib: LLVMlib.}
#     ##  Set the contents of a structure type.
#     ##
#     ##  @see llvm::StructType::setBody()
proc `body=`*(struct: Type, elementTypes: openArray[Type], packed: bool = false) =
    var
        s = elementTypes.map(proc(a: Type): TypeRef = a.typ)
        adr = if s.len > 0: s[0].addr else: nil
        l = cuint s.len
    structSetBody(struct.typ, adr, l, packed)

# proc countStructElementTypes*(structTy: TypeRef): cuint {.cdecl, importc: "LLVMCountStructElementTypes", dynlib: LLVMlib.}
#     ##  Get the number of elements defined inside the structure.
#     ##
#     ##  @see llvm::StructType::getNumElements()

# proc getStructElementTypes*(structTy: TypeRef; dest: ptr TypeRef) {.cdecl, importc: "LLVMGetStructElementTypes", dynlib: LLVMlib.}
#     ##  Get the elements within a structure.
#     ##
#     ##  The function is passed the address of a pre-allocated array of
#     ##  LLVMTypeRef at least LLVMCountStructElementTypes() long. After
#     ##  invocation, this array will be populated with the structure's
#     ##  elements. The objects in the destination array will have a lifetime
#     ##  of the structure type itself, which is the lifetime of the context it
#     ##  is contained in.

# proc structGetTypeAtIndex*(structTy: TypeRef; i: cuint): TypeRef {.cdecl, importc: "LLVMStructGetTypeAtIndex", dynlib: LLVMlib.}
#     ##  Get the type of the element at a given index in the structure.
#     ##
#     ##  @see llvm::StructType::getTypeAtIndex()

# proc isPackedStruct*(structTy: TypeRef): Bool {.cdecl, importc: "LLVMIsPackedStruct", dynlib: LLVMlib.}
#     ##  Determine whether a structure is packed.
#     ##
#     ##  @see llvm::StructType::isPacked()

# proc isOpaqueStruct*(structTy: TypeRef): Bool {.cdecl, importc: "LLVMIsOpaqueStruct", dynlib: LLVMlib.}
#     ##  Determine whether a structure is opaque.
#     ##
#     ##  @see llvm::StructType::isOpaque()

# proc isLiteralStruct*(structTy: TypeRef): Bool {.cdecl, importc: "LLVMIsLiteralStruct", dynlib: LLVMlib.}
#     ##  Determine whether a structure is literal.
#     ##
#     ##  @see llvm::StructType::isLiteral()


# ##  Sequential types represents "arrays" of types. This is a super class
# ##  for array, vector, and pointer types.
# proc getElementType*(ty: TypeRef): TypeRef {.cdecl, importc: "LLVMGetElementType", dynlib: LLVMlib.}
#     ##  Obtain the type of elements within a sequential type.
#     ##
#     ##  This works on array, vector, and pointer types.
#     ##
#     ##  @see llvm::SequentialType::getElementType()

# proc getSubtypes*(tp: TypeRef; arr: ptr TypeRef) {.cdecl, importc: "LLVMGetSubtypes", dynlib: LLVMlib.}
#     ##  Returns type's subtypes
#     ##
#     ##  @see llvm::Type::subtypes()

# proc getNumContainedTypes*(tp: TypeRef): cuint {.cdecl, importc: "LLVMGetNumContainedTypes", dynlib: LLVMlib.}
#     ##   Return the number of types in the derived type.
#     ##
#     ##  @see llvm::Type::getNumContainedTypes()

# proc arrayType*(elementType: TypeRef; elementCount: cuint): TypeRef {.cdecl, importc: "LLVMArrayType", dynlib: LLVMlib.}
#     ##  Create a fixed size array type that refers to a specific type.
#     ##
#     ##  The created type will exist in the context that its element type
#     ##  exists in.
#     ##
#     ##  @see llvm::ArrayType::get()

# proc getArrayLength*(arrayTy: TypeRef): cuint {.cdecl, importc: "LLVMGetArrayLength", dynlib: LLVMlib.}
#     ##  Obtain the length of an array type.
#     ##
#     ##  This only works on types that represent arrays.
#     ##
#     ##  @see llvm::ArrayType::getNumElements()

# proc pointerType*(elementType: TypeRef; addressSpace: cuint): TypeRef {.cdecl, importc: "LLVMPointerType", dynlib: LLVMlib.}
#     ##  Create a pointer type that points to a defined type.
#     ##
#     ##  The created type will exist in the context that its pointee type
#     ##  exists in.
#     ##
#     ##  @see llvm::PointerType::get()
proc pointerType*(elementType: Type, addressSpace: int = 0): PointerType =
    newType[PointerType](pointerType(elementType.typ, cuint addressSpace))

# proc getPointerAddressSpace*(pointerTy: TypeRef): cuint {.cdecl, importc: "LLVMGetPointerAddressSpace", dynlib: LLVMlib.}
#     ##  Obtain the address space of a pointer type.
#     ##
#     ##  This only works on types that represent pointers.
#     ##
#     ##  @see llvm::PointerType::getAddressSpace()

# proc vectorType*(elementType: TypeRef; elementCount: cuint): TypeRef {.cdecl, importc: "LLVMVectorType", dynlib: LLVMlib.}
#     ##  Create a vector type that contains a defined type and has a specific
#     ##  number of elements.
#     ##
#     ##  The created type will exist in the context thats its element type
#     ##  exists in.
#     ##
#     ##  @see llvm::VectorType::get()

# proc getVectorSize*(vectorTy: TypeRef): cuint {.cdecl, importc: "LLVMGetVectorSize", dynlib: LLVMlib.}
#     ##  Obtain the number of elements in a vector type.
#     ##
#     ##  This only works on types that represent vectors.
#     ##
#     ##  @see llvm::VectorType::getNumElements()

proc voidType*(cxt: Context): VoidType =
    ##  Create a void type in a context.
    ## 
    ##  Wrapping:
    ##  * `voidType(ContextRef)<../llvm/Core.html#voidType,ContextRef>`_
    newType[VoidType](cxt.context.voidTypeInContext())


# proc labelTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMLabelTypeInContext", dynlib: LLVMlib.}
#     ##  Create a label type in a context.

# proc x86MMXTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMX86MMXTypeInContext", dynlib: LLVMlib.}
#     ##  Create a X86 MMX type in a context.

# proc tokenTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMTokenTypeInContext", dynlib: LLVMlib.}
#     ##  Create a token type in a context.

# proc metadataTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMMetadataTypeInContext", dynlib: LLVMlib.}
#     ##  Create a metadata type in a context.

##  These are similar to the above functions except they operate on the
##  global context.
proc voidType*(): VoidType =
    ##  Create a void type in the global context.
    ## 
    ##  Wrapping:
    ##  * `voidType()<../llvm/Core.html#voidType>`_
    runnableExamples:
        var
            llVoid = voidType()

        assert $llVoid == "void"
    newType[VoidType](raw.voidType())
# proc labelType*(): TypeRef {.cdecl, importc: "LLVMLabelType", dynlib: LLVMlib.}
# proc x86MMXType*(): TypeRef {.cdecl, importc: "LLVMX86MMXType", dynlib: LLVMlib.}


# REGION: Value

# ##  Functions in this section work on all LLVMValueRef instances,
# ##  regardless of their sub-type. They correspond to functions available
# ##  on llvm::Value.
proc typ*(self: Value): Type =
    ##  Obtain the type of a value.
    ## 
    ##  Wrapping:
    ##  * `typeOfX(ValueRef)<../llvm/Core.html#typeOfX,ValueRef>`_
    newType[Type](self.value.typeOfX())

proc kind*(self: Value): ValueKind =
    ##  Obtain the enumerated type of a Value instance.
    ##  Wrapping:
    ##  * `getValueKind(ValueRef)<../llvm/Core.html#getValueKind,ValueRef>`_
    self.kind

proc name*(self: Value): string =
    ##  Obtain the string name of a value.
    ## 
    ##  Wrapping:
    ##  * `getValueName2(ValueRef, ptr csize_t)<../llvm/Core.html#getValueName2,ValueRef,ptr.csize_t>`_
    var
        len: csize_t
    result = $self.value.getValueName2(len.addr)

proc `name=`*(self: Value, name: string) =
    ##  Set the string name of a value.
    ## 
    ##  Wrapping:
    ##  * `setValueName2(ValueRef, cstring, csize_t)<../llvm/Core.html#setValueName2,ValueRef,cstring,csize_t>`_
    self.value.setValueName2(name, cuint name.len)

proc dump*(self: Value) =
    ##  Dump a representation of a value to stderr.
    ## 
    ##  Wrapping:
    ##  * `dumpValue(ValueRef)<../llvm/Core.html#dumpValue,ValueRef>`_
    self.value.dumpValue()

proc `$`*(self: Value): string =
    ##  Return a string representation of the value.
    ## 
    ##  Wrapping:
    ##  * `printValueToString(ValueRef)<../llvm/Core.html#printValueToString,ValueRef>`_
    var
        tmp = self.value.printValueToString()
    result = $tmp
    tmp.disposeMessage()

# proc replaceAllUsesWith*(oldVal: ValueRef; newVal: ValueRef) {.cdecl, importc: "LLVMReplaceAllUsesWith", dynlib: LLVMlib.}
#     ##  Replace all uses of a value with another one.
#     ##
#     ##  @see llvm::Value::replaceAllUsesWith()

# proc isConstant*(val: ValueRef): Bool {.cdecl, importc: "LLVMIsConstant", dynlib: LLVMlib.}
#     ##  Determine whether the specified value instance is constant.

# proc isUndef*(val: ValueRef): Bool {.cdecl, importc: "LLVMIsUndef", dynlib: LLVMlib.}
#     ##  Determine whether a value instance is undefined.

# proc isAArgument*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAArgument", dynlib: LLVMlib.}
#     ##  Convert value instances between types.
#     ##
#     ##  Internally, an LLVMValueRef is "pinned" to a specific type. This
#     ##  series of functions allows you to cast an instance to a specific
#     ##  type.
#     ##
#     ##  If the cast is not valid for the specified type, NULL is returned.
#     ##
#     ##  @see llvm::dyn_cast_or_null<>
# proc isABasicBlock*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsABasicBlock", dynlib: LLVMlib.}
# proc isAInlineAsm*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAInlineAsm", dynlib: LLVMlib.}
# proc isAUser*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUser", dynlib: LLVMlib.}
# proc isAConstant*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstant", dynlib: LLVMlib.}
# proc isABlockAddress*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsABlockAddress", dynlib: LLVMlib.}
# proc isAConstantAggregateZero*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantAggregateZero", dynlib: LLVMlib.}
# proc isAConstantArray*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantArray", dynlib: LLVMlib.}
# proc isAConstantDataSequential*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantDataSequential", dynlib: LLVMlib.}
# proc isAConstantDataArray*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantDataArray", dynlib: LLVMlib.}
# proc isAConstantDataVector*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantDataVector", dynlib: LLVMlib.}
# proc isAConstantExpr*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantExpr", dynlib: LLVMlib.}
# proc isAConstantFP*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantFP", dynlib: LLVMlib.}
# proc isAConstantInt*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantInt", dynlib: LLVMlib.}
# proc isAConstantPointerNull*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantPointerNull", dynlib: LLVMlib.}
# proc isAConstantStruct*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantStruct", dynlib: LLVMlib.}
# proc isAConstantTokenNone*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantTokenNone", dynlib: LLVMlib.}
# proc isAConstantVector*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAConstantVector", dynlib: LLVMlib.}
# proc isAGlobalValue*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGlobalValue", dynlib: LLVMlib.}
# proc isAGlobalAlias*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGlobalAlias", dynlib: LLVMlib.}
# proc isAGlobalIFunc*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGlobalIFunc", dynlib: LLVMlib.}
# proc isAGlobalObject*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGlobalObject", dynlib: LLVMlib.}
# proc isAFunction*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFunction", dynlib: LLVMlib.}
# proc isAGlobalVariable*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGlobalVariable", dynlib: LLVMlib.}
# proc isAUndefValue*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUndefValue", dynlib: LLVMlib.}
# proc isAInstruction*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAInstruction", dynlib: LLVMlib.}
# proc isAUnaryOperator*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUnaryOperator", dynlib: LLVMlib.}
# proc isABinaryOperator*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsABinaryOperator", dynlib: LLVMlib.}
# proc isACallInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACallInst", dynlib: LLVMlib.}
# proc isAIntrinsicInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAIntrinsicInst", dynlib: LLVMlib.}
# proc isADbgInfoIntrinsic*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsADbgInfoIntrinsic", dynlib: LLVMlib.}
# proc isADbgVariableIntrinsic*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsADbgVariableIntrinsic", dynlib: LLVMlib.}
# proc isADbgDeclareInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsADbgDeclareInst", dynlib: LLVMlib.}
# proc isADbgLabelInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsADbgLabelInst", dynlib: LLVMlib.}
# proc isAMemIntrinsic*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMemIntrinsic", dynlib: LLVMlib.}
# proc isAMemCpyInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMemCpyInst", dynlib: LLVMlib.}
# proc isAMemMoveInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMemMoveInst", dynlib: LLVMlib.}
# proc isAMemSetInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMemSetInst", dynlib: LLVMlib.}
# proc isACmpInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACmpInst", dynlib: LLVMlib.}
# proc isAFCmpInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFCmpInst", dynlib: LLVMlib.}
# proc isAICmpInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAICmpInst", dynlib: LLVMlib.}
# proc isAExtractElementInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAExtractElementInst", dynlib: LLVMlib.}
# proc isAGetElementPtrInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAGetElementPtrInst", dynlib: LLVMlib.}
# proc isAInsertElementInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAInsertElementInst", dynlib: LLVMlib.}
# proc isAInsertValueInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAInsertValueInst", dynlib: LLVMlib.}
# proc isALandingPadInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsALandingPadInst", dynlib: LLVMlib.}
# proc isAPHINode*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAPHINode", dynlib: LLVMlib.}
# proc isASelectInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsASelectInst", dynlib: LLVMlib.}
# proc isAShuffleVectorInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAShuffleVectorInst", dynlib: LLVMlib.}
# proc isAStoreInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAStoreInst", dynlib: LLVMlib.}
# proc isABranchInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsABranchInst", dynlib: LLVMlib.}
# proc isAIndirectBrInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAIndirectBrInst", dynlib: LLVMlib.}
# proc isAInvokeInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAInvokeInst", dynlib: LLVMlib.}
# proc isAReturnInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAReturnInst", dynlib: LLVMlib.}
# proc isASwitchInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsASwitchInst", dynlib: LLVMlib.}
# proc isAUnreachableInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUnreachableInst", dynlib: LLVMlib.}
# proc isAResumeInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAResumeInst", dynlib: LLVMlib.}
# proc isACleanupReturnInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACleanupReturnInst", dynlib: LLVMlib.}
# proc isACatchReturnInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACatchReturnInst", dynlib: LLVMlib.}
# proc isACatchSwitchInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACatchSwitchInst", dynlib: LLVMlib.}
# proc isACallBrInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACallBrInst", dynlib: LLVMlib.}
# proc isAFuncletPadInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFuncletPadInst", dynlib: LLVMlib.}
# proc isACatchPadInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACatchPadInst", dynlib: LLVMlib.}
# proc isACleanupPadInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACleanupPadInst", dynlib: LLVMlib.}
# proc isAUnaryInstruction*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUnaryInstruction", dynlib: LLVMlib.}
# proc isAAllocaInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAAllocaInst", dynlib: LLVMlib.}
# proc isACastInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsACastInst", dynlib: LLVMlib.}
# proc isAAddrSpaceCastInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAAddrSpaceCastInst", dynlib: LLVMlib.}
# proc isABitCastInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsABitCastInst", dynlib: LLVMlib.}
# proc isAFPExtInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFPExtInst", dynlib: LLVMlib.}
# proc isAFPToSIInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFPToSIInst", dynlib: LLVMlib.}
# proc isAFPToUIInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFPToUIInst", dynlib: LLVMlib.}
# proc isAFPTruncInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFPTruncInst", dynlib: LLVMlib.}
# proc isAIntToPtrInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAIntToPtrInst", dynlib: LLVMlib.}
# proc isAPtrToIntInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAPtrToIntInst", dynlib: LLVMlib.}
# proc isASExtInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsASExtInst", dynlib: LLVMlib.}
# proc isASIToFPInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsASIToFPInst", dynlib: LLVMlib.}
# proc isATruncInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsATruncInst", dynlib: LLVMlib.}
# proc isAUIToFPInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAUIToFPInst", dynlib: LLVMlib.}
# proc isAZExtInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAZExtInst", dynlib: LLVMlib.}
# proc isAExtractValueInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAExtractValueInst", dynlib: LLVMlib.}
# proc isALoadInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsALoadInst", dynlib: LLVMlib.}
# proc isAVAArgInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAVAArgInst", dynlib: LLVMlib.}
# proc isAFreezeInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFreezeInst", dynlib: LLVMlib.}
# proc isAAtomicCmpXchgInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAAtomicCmpXchgInst", dynlib: LLVMlib.}
# proc isAAtomicRMWInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAAtomicRMWInst", dynlib: LLVMlib.}
# proc isAFenceInst*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAFenceInst", dynlib: LLVMlib.}
# proc isAMDNode*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMDNode", dynlib: LLVMlib.}
# proc isAMDString*(val: ValueRef): ValueRef {.cdecl, importc: "LLVMIsAMDString", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMGetValueName2 instead.

# proc getValueName*(val: ValueRef): cstring {.cdecl, importc: "LLVMGetValueName", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMSetValueName2 instead.

# proc setValueName*(val: ValueRef; name: cstring) {.cdecl, importc: "LLVMSetValueName", dynlib: LLVMlib.}
# ##  This module defines functions that allow you to inspect the uses of a
# ##  LLVMValueRef.
# ##
# ##  It is possible to obtain an LLVMUseRef for any LLVMValueRef instance.
# ##  Each LLVMUseRef (which corresponds to a llvm::Use instance) holds a
# ##  llvm::User and llvm::Value.
# proc getFirstUse*(val: ValueRef): UseRef {.cdecl, importc: "LLVMGetFirstUse", dynlib: LLVMlib.}
#     ##  Obtain the first use of a value.
#     ##
#     ##  Uses are obtained in an iterator fashion. First, call this function
#     ##  to obtain a reference to the first use. Then, call LLVMGetNextUse()
#     ##  on that instance and all subsequently obtained instances until
#     ##  LLVMGetNextUse() returns NULL.
#     ##
#     ##  @see llvm::Value::use_begin()

# proc getNextUse*(u: UseRef): UseRef {.cdecl, importc: "LLVMGetNextUse", dynlib: LLVMlib.}
#     ##  Obtain the next use of a value.
#     ##
#     ##  This effectively advances the iterator. It returns NULL if you are on
#     ##  the final use and no more are available.

# proc getUser*(u: UseRef): ValueRef {.cdecl, importc: "LLVMGetUser", dynlib: LLVMlib.}
#     ##  Obtain the user value for a user.
#     ##
#     ##  The returned value corresponds to a llvm::User type.
#     ##
#     ##  @see llvm::Use::getUser()

# proc getUsedValue*(u: UseRef): ValueRef {.cdecl, importc: "LLVMGetUsedValue", dynlib: LLVMlib.}
#     ##  Obtain the value this use corresponds to.
#     ##
#     ##  @see llvm::Use::get().


# ##  Function in this group pertain to LLVMValueRef instances that descent
# ##  from llvm::User. This includes constants, instructions, and
# ##  operators.
# proc getOperand*(val: ValueRef; index: cuint): ValueRef {.cdecl, importc: "LLVMGetOperand", dynlib: LLVMlib.}
#     ##  Obtain an operand at a specific index in a llvm::User value.
#     ##
#     ##  @see llvm::User::getOperand()

# proc getOperandUse*(val: ValueRef; index: cuint): UseRef {.cdecl, importc: "LLVMGetOperandUse", dynlib: LLVMlib.}
#     ##  Obtain the use of an operand at a specific index in a llvm::User value.
#     ##
#     ##  @see llvm::User::getOperandUse()

# proc setOperand*(user: ValueRef; index: cuint; val: ValueRef) {.cdecl, importc: "LLVMSetOperand", dynlib: LLVMlib.}
#     ##  Set an operand at a specific index in a llvm::User value.
#     ##
#     ##  @see llvm::User::setOperand()

# proc getNumOperands*(val: ValueRef): cint {.cdecl, importc: "LLVMGetNumOperands", dynlib: LLVMlib.}
#     ##  Obtain the number of operands in a llvm::User value.
#     ##
#     ##  @see llvm::User::getNumOperands()


# ##  This section contains APIs for interacting with LLVMValueRef that
# ##  correspond to llvm::Constant instances.
# ##
# ##  These functions will work for any LLVMValueRef in the llvm::Constant
# ##  class hierarchy.
# proc constNull*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMConstNull", dynlib: LLVMlib.}
#     ##  Obtain a constant value referring to the null instance of a type.
#     ##
#     ##  @see llvm::Constant::getNullValue()
#     ##  all zeroes

# proc constAllOnes*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMConstAllOnes", dynlib: LLVMlib.}
#     ##  Obtain a constant value referring to the instance of a type
#     ##  consisting of all ones.
#     ##
#     ##  This is only valid for integer types.
#     ##
#     ##  @see llvm::Constant::getAllOnesValue()

# proc getUndef*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMGetUndef", dynlib: LLVMlib.}
#     ##  Obtain a constant value referring to an undefined value of a type.
#     ##
#     ##  @see llvm::UndefValue::get()
proc undef*(ty: Type): UndefValue =
    ##  Obtain a constant value referring to an undefined value of a type.
    ## 
    ##  Wrapping:
    ##  * `getUndef()<../llvm/Core.html#getUndef,TypeRef>`_
    newValue[UndefValue](ty.typ.getUndef)

# proc isNull*(val: ValueRef): Bool {.cdecl, importc: "LLVMIsNull", dynlib: LLVMlib.}
#     ##  Determine whether a value instance is null.
#     ##
#     ##  @see llvm::Constant::isNullValue()

# proc constPointerNull*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMConstPointerNull", dynlib: LLVMlib.}
#     ##  Obtain a constant that is a constant pointer pointing to NULL for a
#     ##  specified type.


# ##  Functions in this group model LLVMValueRef instances that correspond
# ##  to constants referring to scalar types.
# ##
# ##  For integer types, the LLVMTypeRef parameter should correspond to a
# ##  llvm::IntegerType instance and the returned LLVMValueRef will
# ##  correspond to a llvm::ConstantInt.
# ##
# ##  For floating point types, the LLVMTypeRef returned corresponds to a
# ##  llvm::ConstantFP.

proc constInt*(intTy: IntegerType, n: int, signExtend: bool = false): Value =
    ##  Obtain a constant value for an integer type.
    ##
    ##  The returned value corresponds to a llvm::ConstantInt.
    ##
    ##  @see llvm::ConstantInt::get()
    ##
    ##  @param IntTy Integer type to obtain value of.
    ## 
    ##  @param N The value the returned instance should refer to.
    ## 
    ##  @param SignExtend Whether to sign extend the produced value.
    ## 
    ##  Wrapping:
    ##  * `constInt(TypeRef, ulonglong, Bool)<../llvm/Core.html#constInt,TypeRef,culonglong,Bool>`_
    newValue[Value](intTy.typ.constInt(cast[culonglong](n), signExtend))

# proc constIntOfArbitraryPrecision*(intTy: TypeRef; numWords: cuint;words: ptr uint64T): ValueRef {.cdecl, importc: "LLVMConstIntOfArbitraryPrecision", dynlib: LLVMlib.}
#     ##  Obtain a constant value for an integer of arbitrary precision.
#     ##
#     ##  @see llvm::ConstantInt::get()

# proc constIntOfString*(intTy: TypeRef; text: cstring;radix: uint8T): ValueRef {.cdecl, importc: "LLVMConstIntOfString", dynlib: LLVMlib.}
#     ##  Obtain a constant value for an integer parsed from a string.
#     ##
#     ##  A similar API, LLVMConstIntOfStringAndSize is also available. If the
#     ##  string's length is available, it is preferred to call that function
#     ##  instead.
#     ##
#     ##  @see llvm::ConstantInt::get()

# proc constIntOfStringAndSize*(intTy: TypeRef; text: cstring; sLen: cuint;radix: uint8T): ValueRef {. cdecl, importc: "LLVMConstIntOfStringAndSize", dynlib: LLVMlib.}
#     ##  Obtain a constant value for an integer parsed from a string with
#     ##  specified length.
#     ##
#     ##  @see llvm::ConstantInt::get()

# proc constReal*(realTy: TypeRef; n: cdouble): ValueRef {.cdecl, importc: "LLVMConstReal", dynlib: LLVMlib.}
#     ##  Obtain a constant value referring to a double floating point value.
proc constReal*(typ: Type, n: BiggestFloat): Value =
    newValue[Value](typ.typ.constReal(cast[cdouble](n)))
    

# proc constRealOfString*(realTy: TypeRef; text: cstring): ValueRef {.cdecl, importc: "LLVMConstRealOfString", dynlib: LLVMlib.}
#     ##  Obtain a constant for a floating point value parsed from a string.
#     ##
#     ##  A similar API, LLVMConstRealOfStringAndSize is also available. It
#     ##  should be used if the input string's length is known.

# proc constRealOfStringAndSize*(realTy: TypeRef; text: cstring;sLen: cuint): ValueRef {. cdecl, importc: "LLVMConstRealOfStringAndSize", dynlib: LLVMlib.}
#     ##  Obtain a constant for a floating point value parsed from a string.

# proc constIntGetZExtValue*(constantVal: ValueRef): culonglong {.cdecl, importc: "LLVMConstIntGetZExtValue", dynlib: LLVMlib.}
#     ##  Obtain the zero extended value for an integer constant value.
#     ##
#     ##  @see llvm::ConstantInt::getZExtValue()

# proc constIntGetSExtValue*(constantVal: ValueRef): clonglong {.cdecl, importc: "LLVMConstIntGetSExtValue", dynlib: LLVMlib.}
#     ##  Obtain the sign extended value for an integer constant value.
#     ##
#     ##  @see llvm::ConstantInt::getSExtValue()

# proc constRealGetDouble*(constantVal: ValueRef; losesInfo: ptr Bool): cdouble {.cdecl, importc: "LLVMConstRealGetDouble", dynlib: LLVMlib.}
#     ##  Obtain the double value for an floating point constant value.
#     ##  losesInfo indicates if some precision was lost in the conversion.
#     ##
#     ##  @see llvm::ConstantFP::getDoubleValue


# ##  Functions in this group operate on composite constants.
# proc constStringInContext*(c: ContextRef; str: cstring; length: cuint;dontNullTerminate: Bool): ValueRef {.cdecl, importc: "LLVMConstStringInContext", dynlib: LLVMlib.}
#     ##  Create a ConstantDataSequential and initialize it with a string.
#     ##
#     ##  @see llvm::ConstantDataArray::getString()
proc constString*(cxt: Context, str: string, dontNullTerminate: Bool = false): Value =
    newValue[Value](constStringInContext(cxt.context, str, cuint str.len, dontNullTerminate))

# proc constString*(str: cstring; length: cuint;dontNullTerminate: Bool): ValueRef {. cdecl, importc: "LLVMConstString", dynlib: LLVMlib.}
#     ##  Create a ConstantDataSequential with string content in the global context.
#     ##
#     ##  This is the same as LLVMConstStringInContext except it operates on the
#     ##  global context.
#     ##
#     ##  @see LLVMConstStringInContext()
#     ##  @see llvm::ConstantDataArray::getString()

# proc isConstantString*(c: ValueRef): Bool {.cdecl, importc: "LLVMIsConstantString", dynlib: LLVMlib.}
#     ##  Returns true if the specified constant is an array of i8.
#     ##
#     ##  @see ConstantDataSequential::getAsString()

# proc getAsString*(c: ValueRef; length: ptr csize_t): cstring {.cdecl, importc: "LLVMGetAsString", dynlib: LLVMlib.}
#     ##  Get the given constant data sequential as a string.
#     ##
#     ##  @see ConstantDataSequential::getAsString()

# proc constStructInContext*(c: ContextRef; constantVals: ptr ValueRef; count: cuint;packed: Bool): ValueRef {.cdecl, importc: "LLVMConstStructInContext", dynlib: LLVMlib.}
#     ##  Create an anonymous ConstantStruct with the specified values.
#     ##
#     ##  @see llvm::ConstantStruct::getAnon()
proc constStruct*(cxt: Context, constantVals: openArray[Value], packed: bool = false): Value =
    var
        s = constantVals.map(proc(a: Value): ValueRef = a.value)
        adr = if s.len > 0: s[0].addr else: nil
        l = cuint s.len
    newValue[Value](constStructInContext(cxt.context, adr, l, packed))

# proc constStruct*(constantVals: ptr ValueRef; count: cuint;packed: Bool): ValueRef {. cdecl, importc: "LLVMConstStruct", dynlib: LLVMlib.}
#     ##  Create a ConstantStruct in the global Context.
#     ##
#     ##  This is the same as LLVMConstStructInContext except it operates on the
#     ##  global Context.
#     ##
#     ##  @see LLVMConstStructInContext()

# proc constArray*(elementTy: TypeRef; constantVals: ptr ValueRef;length: cuint): ValueRef {. cdecl, importc: "LLVMConstArray", dynlib: LLVMlib.}
#     ##  Create a ConstantArray from values.
#     ##
#     ##  @see llvm::ConstantArray::get()

# proc constNamedStruct*(structTy: TypeRef; constantVals: ptr ValueRef; count: cuint): ValueRef {. cdecl, importc: "LLVMConstNamedStruct", dynlib: LLVMlib.}
#     ##  Create a non-anonymous ConstantStruct from values.
#     ##
#     ##  @see llvm::ConstantStruct::get()
proc constStruct*(structType: Type, constantVals: openArray[Value]): Value =
    var
        s = constantVals.map(proc(a: Value): ValueRef = a.value)
        adr = if s.len > 0: s[0].addr else: nil
        l = cuint s.len
    newValue[Value](constNamedStruct(structType.typ, adr, l))

# proc getElementAsConstant*(c: ValueRef; idx: cuint): ValueRef {.cdecl, importc: "LLVMGetElementAsConstant", dynlib: LLVMlib.}
#     ##  Get an element at specified index as a constant.
#     ##
#     ##  @see ConstantDataSequential::getElementAsConstant()

# proc constVector*(scalarConstantVals: ptr ValueRef; size: cuint): ValueRef {.cdecl, importc: "LLVMConstVector", dynlib: LLVMlib.}
#     ##  Create a ConstantVector from values.
#     ##
#     ##  @see llvm::ConstantVector::get()


# ##  Functions in this group correspond to APIs on llvm::ConstantExpr.
# ##
# ##  @see llvm::ConstantExpr.
# proc getConstOpcode*(constantVal: ValueRef): Opcode {.cdecl, importc: "LLVMGetConstOpcode", dynlib: LLVMlib.}
# proc alignOf*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMAlignOf", dynlib: LLVMlib.}
# proc sizeOfX*(ty: TypeRef): ValueRef {.cdecl, importc: "LLVMSizeOf", dynlib: LLVMlib.}
# proc constNeg*(constantVal: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNeg", dynlib: LLVMlib.}
# proc constNSWNeg*(constantVal: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNSWNeg", dynlib: LLVMlib.}
# proc constNUWNeg*(constantVal: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNUWNeg", dynlib: LLVMlib.}
# proc constFNeg*(constantVal: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFNeg", dynlib: LLVMlib.}
# proc constNot*(constantVal: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNot", dynlib: LLVMlib.}
# proc constAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstAdd", dynlib: LLVMlib.}
# proc constNSWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNSWAdd", dynlib: LLVMlib.}
# proc constNUWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNUWAdd", dynlib: LLVMlib.}
# proc constFAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFAdd", dynlib: LLVMlib.}
# proc constSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstSub", dynlib: LLVMlib.}
# proc constNSWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNSWSub", dynlib: LLVMlib.}
# proc constNUWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNUWSub", dynlib: LLVMlib.}
# proc constFSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFSub", dynlib: LLVMlib.}
# proc constMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstMul", dynlib: LLVMlib.}
# proc constNSWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNSWMul", dynlib: LLVMlib.}
# proc constNUWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstNUWMul", dynlib: LLVMlib.}
# proc constFMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFMul", dynlib: LLVMlib.}
# proc constUDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstUDiv", dynlib: LLVMlib.}
# proc constExactUDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstExactUDiv", dynlib: LLVMlib.}
# proc constSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstSDiv", dynlib: LLVMlib.}
# proc constExactSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstExactSDiv", dynlib: LLVMlib.}
# proc constFDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFDiv", dynlib: LLVMlib.}
# proc constURem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstURem", dynlib: LLVMlib.}
# proc constSRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstSRem", dynlib: LLVMlib.}
# proc constFRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFRem", dynlib: LLVMlib.}
# proc constAnd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstAnd", dynlib: LLVMlib.}
# proc constOr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstOr", dynlib: LLVMlib.}
# proc constXor*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstXor", dynlib: LLVMlib.}
# proc constICmp*(predicate: IntPredicate; lHSConstant: ValueRef;rHSConstant: ValueRef): ValueRef {. cdecl, importc: "LLVMConstICmp", dynlib: LLVMlib.}
# proc constFCmp*(predicate: RealPredicate; lHSConstant: ValueRef;rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstFCmp", dynlib: LLVMlib.}
# proc constShl*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstShl", dynlib: LLVMlib.}
# proc constLShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstLShr", dynlib: LLVMlib.}
# proc constAShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstAShr", dynlib: LLVMlib.}
# proc constGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef;numIndices: cuint): ValueRef {. cdecl, importc: "LLVMConstGEP", dynlib: LLVMlib.}
proc constGep*(constantVal: Value, constantIndices: openArray[Value]): Value =
    var
        s = constantIndices.map(proc(a: Value): ValueRef = a.value)
        adr = if s.len > 0: s[0].addr else: nil
        l = cuint s.len
    newValue[Value](constGEP(constantVal.value, adr, l))
# proc constGEP2*(ty: TypeRef; constantVal: ValueRef; constantIndices: ptr ValueRef;numIndices: cuint): ValueRef {.cdecl, importc: "LLVMConstGEP2", dynlib: LLVMlib.}
# proc constInBoundsGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef;numIndices: cuint): ValueRef {.cdecl, importc: "LLVMConstInBoundsGEP", dynlib: LLVMlib.}
# proc constInBoundsGEP2*(ty: TypeRef; constantVal: ValueRef;constantIndices: ptr ValueRef;numIndices: cuint): ValueRef {. cdecl, importc: "LLVMConstInBoundsGEP2", dynlib: LLVMlib.}
# proc constTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstTrunc", dynlib: LLVMlib.}
# proc constSExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstSExt", dynlib: LLVMlib.}
# proc constZExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstZExt", dynlib: LLVMlib.}
# proc constFPTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstFPTrunc", dynlib: LLVMlib.}
# proc constFPExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstFPExt", dynlib: LLVMlib.}
# proc constUIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstUIToFP", dynlib: LLVMlib.}
# proc constSIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstSIToFP", dynlib: LLVMlib.}
# proc constFPToUI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstFPToUI", dynlib: LLVMlib.}
# proc constFPToSI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstFPToSI", dynlib: LLVMlib.}
# proc constPtrToInt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstPtrToInt", dynlib: LLVMlib.}
# proc constIntToPtr*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstIntToPtr", dynlib: LLVMlib.}
# proc constBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstBitCast", dynlib: LLVMlib.}
# proc constAddrSpaceCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstAddrSpaceCast", dynlib: LLVMlib.}
# proc constZExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstZExtOrBitCast", dynlib: LLVMlib.}
# proc constSExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstSExtOrBitCast", dynlib: LLVMlib.}
# proc constTruncOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstTruncOrBitCast", dynlib: LLVMlib.}
# proc constPointerCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstPointerCast", dynlib: LLVMlib.}
# proc constIntCast*(constantVal: ValueRef; toType: TypeRef;isSigned: Bool): ValueRef {. cdecl, importc: "LLVMConstIntCast", dynlib: LLVMlib.}
# proc constFPCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.cdecl, importc: "LLVMConstFPCast", dynlib: LLVMlib.}
# proc constSelect*(constantCondition: ValueRef; constantIfTrue: ValueRef;constantIfFalse: ValueRef): ValueRef {.cdecl, importc: "LLVMConstSelect", dynlib: LLVMlib.}
# proc constExtractElement*(vectorConstant: ValueRef;indexConstant: ValueRef): ValueRef {. cdecl, importc: "LLVMConstExtractElement", dynlib: LLVMlib.}
# proc constInsertElement*(vectorConstant: ValueRef; elementValueConstant: ValueRef;indexConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstInsertElement", dynlib: LLVMlib.}
# proc constShuffleVector*(vectorAConstant: ValueRef; vectorBConstant: ValueRef;maskConstant: ValueRef): ValueRef {.cdecl, importc: "LLVMConstShuffleVector", dynlib: LLVMlib.}
# proc constExtractValue*(aggConstant: ValueRef; idxList: ptr cuint;numIdx: cuint): ValueRef {. cdecl, importc: "LLVMConstExtractValue", dynlib: LLVMlib.}
# proc constInsertValue*(aggConstant: ValueRef; elementValueConstant: ValueRef;idxList: ptr cuint; numIdx: cuint): ValueRef {.cdecl, importc: "LLVMConstInsertValue", dynlib: LLVMlib.}
# proc blockAddress*(f: ValueRef; bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMBlockAddress", dynlib: LLVMlib.}

# proc constInlineAsm*(ty: TypeRef; asmString: cstring; constraints: cstring;hasSideEffects: Bool; isAlignStack: Bool): ValueRef {.cdecl, importc: "LLVMConstInlineAsm", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMGetInlineAsm instead.


# ##  This group contains functions that operate on global values. Functions in
# ##  this group relate to functions in the llvm::GlobalValue class tree.
# ##
# ##  @see llvm::GlobalValue
# proc getGlobalParent*(global: ValueRef): ModuleRef {.cdecl, importc: "LLVMGetGlobalParent", dynlib: LLVMlib.}
# proc isDeclaration*(global: ValueRef): Bool {.cdecl, importc: "LLVMIsDeclaration", dynlib: LLVMlib.}
# proc getLinkage*(global: ValueRef): Linkage {.cdecl, importc: "LLVMGetLinkage", dynlib: LLVMlib.}
# proc setLinkage*(global: ValueRef; linkage: Linkage) {.cdecl, importc: "LLVMSetLinkage", dynlib: LLVMlib.}
# proc getSection*(global: ValueRef): cstring {.cdecl, importc: "LLVMGetSection", dynlib: LLVMlib.}
# proc setSection*(global: ValueRef; section: cstring) {.cdecl, importc: "LLVMSetSection", dynlib: LLVMlib.}
# proc getVisibility*(global: ValueRef): Visibility {.cdecl, importc: "LLVMGetVisibility", dynlib: LLVMlib.}
# proc setVisibility*(global: ValueRef; viz: Visibility) {.cdecl, importc: "LLVMSetVisibility", dynlib: LLVMlib.}
# proc getDLLStorageClass*(global: ValueRef): DLLStorageClass {.cdecl, importc: "LLVMGetDLLStorageClass", dynlib: LLVMlib.}
# proc setDLLStorageClass*(global: ValueRef; class: DLLStorageClass) {.cdecl, importc: "LLVMSetDLLStorageClass", dynlib: LLVMlib.}
# proc getUnnamedAddress*(global: ValueRef): UnnamedAddr {.cdecl, importc: "LLVMGetUnnamedAddress", dynlib: LLVMlib.}
# proc setUnnamedAddress*(global: ValueRef; unnamedAddr: UnnamedAddr) {.cdecl, importc: "LLVMSetUnnamedAddress", dynlib: LLVMlib.}

# proc globalGetValueType*(global: ValueRef): TypeRef {.cdecl, importc: "LLVMGlobalGetValueType", dynlib: LLVMlib.}
#     ##  Returns the "value type" of a global value.  This differs from the formal
#     ##  type of a global value which is always a pointer type.
#     ##
#     ##  @see llvm::GlobalValue::getValueType()

# proc hasUnnamedAddr*(global: ValueRef): Bool {.cdecl, importc: "LLVMHasUnnamedAddr", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMGetUnnamedAddress instead.

# proc setUnnamedAddr*(global: ValueRef; hasUnnamedAddr: Bool) {.cdecl, importc: "LLVMSetUnnamedAddr", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMSetUnnamedAddress instead.


# ##  Functions in this group only apply to values with alignment, i.e.
# ##  global variables, load and store instructions.
# proc getAlignment*(v: ValueRef): cuint {.cdecl, importc: "LLVMGetAlignment", dynlib: LLVMlib.}
#     ##  Obtain the preferred alignment of the value.
#     ##  @see llvm::AllocaInst::getAlignment()
#     ##  @see llvm::LoadInst::getAlignment()
#     ##  @see llvm::StoreInst::getAlignment()
#     ##  @see llvm::GlobalValue::getAlignment()

# proc setAlignment*(v: ValueRef; bytes: cuint) {.cdecl, importc: "LLVMSetAlignment", dynlib: LLVMlib.}
#     ##  Set the preferred alignment of the value.
#     ##  @see llvm::AllocaInst::setAlignment()
#     ##  @see llvm::LoadInst::setAlignment()
#     ##  @see llvm::StoreInst::setAlignment()
#     ##  @see llvm::GlobalValue::setAlignment()

# proc globalSetMetadata*(global: ValueRef; kind: cuint; md: MetadataRef) {.cdecl, importc: "LLVMGlobalSetMetadata", dynlib: LLVMlib.}
#     ##  Sets a metadata attachment, erasing the existing metadata attachment if
#     ##  it already exists for the given kind.
#     ##
#     ##  @see llvm::GlobalObject::setMetadata()

# proc globalEraseMetadata*(global: ValueRef; kind: cuint) {.cdecl, importc: "LLVMGlobalEraseMetadata", dynlib: LLVMlib.}
#     ##  Erases a metadata attachment of the given kind if it exists.
#     ##
#     ##  @see llvm::GlobalObject::eraseMetadata()

# proc globalClearMetadata*(global: ValueRef) {.cdecl, importc: "LLVMGlobalClearMetadata", dynlib: LLVMlib.}
#     ##  Removes all metadata attachments from this value.
#     ##
#     ##  @see llvm::GlobalObject::clearMetadata()

# proc globalCopyAllMetadata*(value: ValueRef;numEntries: ptr csize_t): ptr ValueMetadataEntry {. cdecl, importc: "LLVMGlobalCopyAllMetadata", dynlib: LLVMlib.}
#     ##  Retrieves an array of metadata entries representing the metadata attached to
#     ##  this value. The caller is responsible for freeing this array by calling
#     ##  \c LLVMDisposeValueMetadataEntries.
#     ##
#     ##  @see llvm::GlobalObject::getAllMetadata()

# proc disposeValueMetadataEntries*(entries: ptr ValueMetadataEntry) {.cdecl, importc: "LLVMDisposeValueMetadataEntries", dynlib: LLVMlib.}
#     ##  Destroys value metadata entries.

# proc valueMetadataEntriesGetKind*(entries: ptr ValueMetadataEntry;index: cuint): cuint {. cdecl, importc: "LLVMValueMetadataEntriesGetKind", dynlib: LLVMlib.}
#     ##  Returns the kind of a value metadata entry at a specific index.

# proc valueMetadataEntriesGetMetadata*(entries: ptr ValueMetadataEntry;index: cuint): MetadataRef {. cdecl, importc: "LLVMValueMetadataEntriesGetMetadata", dynlib: LLVMlib.}
#     ##  Returns the underlying metadata node of a value metadata entry at a
#     ##  specific index.

# ##  This group contains functions that operate on global variable values.
# ##
# ##  @see llvm::GlobalVariable
# proc addGlobal*(m: ModuleRef; ty: TypeRef; name: cstring): ValueRef {.cdecl, importc: "LLVMAddGlobal", dynlib: LLVMlib.}
proc newGlobal*(module: Module, typ: Type, name: string): GlobalVariable =
    ##  Wrapping:
    ##  * `addGlobal(ModuleRef, TypeRef, cstring)<../llvm/Core.html#addGlobal,ModuleRef,TypeRef,cstring>`_
    runnableExamples:
        let
            module = newModule("main")
            Int64 = intType(64)
            global = module.newGlobal(Int64, "a")
        assert global.kind == GlobalVariableValueKind
    newValue[GlobalVariable](module.module.addGlobal(typ.typ, name))

# proc addGlobalInAddressSpace*(m: ModuleRef; ty: TypeRef; name: cstring;addressSpace: cuint): ValueRef {.cdecl, importc: "LLVMAddGlobalInAddressSpace", dynlib: LLVMlib.}
# proc getNamedGlobal*(m: ModuleRef; name: cstring): ValueRef {.cdecl, importc: "LLVMGetNamedGlobal", dynlib: LLVMlib.}
# proc getFirstGlobal*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetFirstGlobal", dynlib: LLVMlib.}
# proc getLastGlobal*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetLastGlobal", dynlib: LLVMlib.}
# proc getNextGlobal*(globalVar: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextGlobal", dynlib: LLVMlib.}
# proc getPreviousGlobal*(globalVar: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousGlobal", dynlib: LLVMlib.}
# proc deleteGlobal*(globalVar: ValueRef) {.cdecl, importc: "LLVMDeleteGlobal", dynlib: LLVMlib.}
# proc getInitializer*(globalVar: ValueRef): ValueRef {.cdecl, importc: "LLVMGetInitializer", dynlib: LLVMlib.}
# proc setInitializer*(globalVar: ValueRef; constantVal: ValueRef) {.cdecl, importc: "LLVMSetInitializer", dynlib: LLVMlib.}
proc `initializer=`*(globalVar: Value, constantVal: Value) =
    setInitializer(globalVar.value, constantVal.value)
# proc isThreadLocal*(globalVar: ValueRef): Bool {.cdecl, importc: "LLVMIsThreadLocal", dynlib: LLVMlib.}
# proc setThreadLocal*(globalVar: ValueRef; isThreadLocal: Bool) {.cdecl, importc: "LLVMSetThreadLocal", dynlib: LLVMlib.}
# proc isGlobalConstant*(globalVar: ValueRef): Bool {.cdecl, importc: "LLVMIsGlobalConstant", dynlib: LLVMlib.}
proc constant*(globalVar: Value): bool =
    isGlobalConstant(globalVar.value)
# proc setGlobalConstant*(globalVar: ValueRef; isConstant: Bool) {.cdecl, importc: "LLVMSetGlobalConstant", dynlib: LLVMlib.}
proc `constant=`*(globalVar: Value, isConstant: bool) =
    setGlobalConstant(globalVar.value, isConstant)
# proc getThreadLocalMode*(globalVar: ValueRef): ThreadLocalMode {.cdecl, importc: "LLVMGetThreadLocalMode", dynlib: LLVMlib.}
# proc setThreadLocalMode*(globalVar: ValueRef; mode: ThreadLocalMode) {.cdecl, importc: "LLVMSetThreadLocalMode", dynlib: LLVMlib.}
# proc isExternallyInitialized*(globalVar: ValueRef): Bool {.cdecl, importc: "LLVMIsExternallyInitialized", dynlib: LLVMlib.}
# proc setExternallyInitialized*(globalVar: ValueRef; isExtInit: Bool) {.cdecl, importc: "LLVMSetExternallyInitialized", dynlib: LLVMlib.}



# ##  This group contains function that operate on global alias values.
# ##
# ##  @see llvm::GlobalAlias
# proc addAlias*(m: ModuleRef; ty: TypeRef; aliasee: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMAddAlias", dynlib: LLVMlib.}

# proc getNamedGlobalAlias*(m: ModuleRef; name: cstring;nameLen: csize_t): ValueRef {. cdecl, importc: "LLVMGetNamedGlobalAlias", dynlib: LLVMlib.}
#     ##  Obtain a GlobalAlias value from a Module by its name.
#     ##
#     ##  The returned value corresponds to a llvm::GlobalAlias value.
#     ##
#     ##  @see llvm::Module::getNamedAlias()

# proc getFirstGlobalAlias*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetFirstGlobalAlias", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the first GlobalAlias in a Module.
#     ##
#     ##  @see llvm::Module::alias_begin()

# proc getLastGlobalAlias*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetLastGlobalAlias", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the last GlobalAlias in a Module.
#     ##
#     ##  @see llvm::Module::alias_end()

# proc getNextGlobalAlias*(ga: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextGlobalAlias", dynlib: LLVMlib.}
#     ##  Advance a GlobalAlias iterator to the next GlobalAlias.
#     ##
#     ##  Returns NULL if the iterator was already at the end and there are no more
#     ##  global aliases.

# proc getPreviousGlobalAlias*(ga: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousGlobalAlias", dynlib: LLVMlib.}
#     ##  Decrement a GlobalAlias iterator to the previous GlobalAlias.
#     ##
#     ##  Returns NULL if the iterator was already at the beginning and there are
#     ##  no previous global aliases.

# proc aliasGetAliasee*(alias: ValueRef): ValueRef {.cdecl, importc: "LLVMAliasGetAliasee", dynlib: LLVMlib.}
#     ##  Retrieve the target value of an alias.

# proc aliasSetAliasee*(alias: ValueRef; aliasee: ValueRef) {.cdecl, importc: "LLVMAliasSetAliasee", dynlib: LLVMlib.}
#     ##  Set the target value of an alias.


# ##  Functions in this group operate on LLVMValueRef instances that
# ##  correspond to llvm::Function instances.
# ##
# ##  @see llvm::Function
# proc deleteFunction*(fn: ValueRef) {.cdecl, importc: "LLVMDeleteFunction", dynlib: LLVMlib.}
#     ##  Remove a function from its containing module and deletes it.
#     ##
#     ##  @see llvm::Function::eraseFromParent()

# proc hasPersonalityFn*(fn: ValueRef): Bool {.cdecl, importc: "LLVMHasPersonalityFn", dynlib: LLVMlib.}
#     ##  Check whether the given function has a personality function.
#     ##
#     ##  @see llvm::Function::hasPersonalityFn()

# proc getPersonalityFn*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPersonalityFn", dynlib: LLVMlib.}
#     ##  Obtain the personality function attached to the function.
#     ##
#     ##  @see llvm::Function::getPersonalityFn()

# proc setPersonalityFn*(fn: ValueRef; personalityFn: ValueRef) {.cdecl, importc: "LLVMSetPersonalityFn", dynlib: LLVMlib.}
#     ##  Set the personality function attached to the function.
#     ##
#     ##  @see llvm::Function::setPersonalityFn()

# proc lookupIntrinsicID*(name: cstring; nameLen: csize_t): cuint {.cdecl, importc: "LLVMLookupIntrinsicID", dynlib: LLVMlib.}
#     ##  Obtain the intrinsic ID number which matches the given function name.
#     ##
#     ##  @see llvm::Function::lookupIntrinsicID()

# proc getIntrinsicID*(fn: ValueRef): cuint {.cdecl, importc: "LLVMGetIntrinsicID", dynlib: LLVMlib.}
#     ##  Obtain the ID number from a function instance.
#     ##
#     ##  @see llvm::Function::getIntrinsicID()

# proc getIntrinsicDeclaration*(`mod`: ModuleRef; id: cuint; paramTypes: ptr TypeRef;paramCount: csize_t): ValueRef {.cdecl, importc: "LLVMGetIntrinsicDeclaration", dynlib: LLVMlib.}
#     ##  Create or insert the declaration of an intrinsic.  For overloaded intrinsics,
#     ##  parameter types must be provided to uniquely identify an overload.
#     ##
#     ##  @see llvm::Intrinsic::getDeclaration()

# proc intrinsicGetType*(ctx: ContextRef; id: cuint; paramTypes: ptr TypeRef;paramCount: csize_t): TypeRef {.cdecl, importc: "LLVMIntrinsicGetType", dynlib: LLVMlib.}
#     ##  Retrieves the type of an intrinsic.  For overloaded intrinsics, parameter
#     ##  types must be provided to uniquely identify an overload.
#     ##
#     ##  @see llvm::Intrinsic::getType()

# proc intrinsicGetName*(id: cuint; nameLength: ptr csize_t): cstring {.cdecl, importc: "LLVMIntrinsicGetName", dynlib: LLVMlib.}
#     ##  Retrieves the name of an intrinsic.
#     ##
#     ##  @see llvm::Intrinsic::getName()

# proc intrinsicCopyOverloadedName*(id: cuint; paramTypes: ptr TypeRef;paramCount: csize_t; nameLength: ptr csize_t): cstring {. cdecl, importc: "LLVMIntrinsicCopyOverloadedName", dynlib: LLVMlib.}
#     ##  Copies the name of an overloaded intrinsic identified by a given list of
#     ##  parameter types.
#     ##
#     ##  Unlike LLVMIntrinsicGetName, the caller is responsible for freeing the
#     ##  returned string.
#     ##
#     ##  @see llvm::Intrinsic::getName()

# proc intrinsicIsOverloaded*(id: cuint): Bool {.cdecl, importc: "LLVMIntrinsicIsOverloaded", dynlib: LLVMlib.}
#     ##  Obtain if the intrinsic identified by the given ID is overloaded.
#     ##
#     ##  @see llvm::Intrinsic::isOverloaded()

# proc getFunctionCallConv*(fn: ValueRef): cuint {.cdecl, importc: "LLVMGetFunctionCallConv", dynlib: LLVMlib.}
#     ##  Obtain the calling function of a function.
#     ##
#     ##  The returned value corresponds to the LLVMCallConv enumeration.
#     ##
#     ##  @see llvm::Function::getCallingConv()

# proc setFunctionCallConv*(fn: ValueRef; cc: cuint) {.cdecl, importc: "LLVMSetFunctionCallConv", dynlib: LLVMlib.}
#     ##  Set the calling convention of a function.
#     ##
#     ##  @see llvm::Function::setCallingConv()
#     ##
#     ##  @param Fn Function to operate on
#     ##  @param CC LLVMCallConv to set calling convention to

# proc getGC*(fn: ValueRef): cstring {.cdecl, importc: "LLVMGetGC", dynlib: LLVMlib.}
#     ##  Obtain the name of the garbage collector to use during code
#     ##  generation.
#     ##
#     ##  @see llvm::Function::getGC()

# proc setGC*(fn: ValueRef; name: cstring) {.cdecl, importc: "LLVMSetGC", dynlib: LLVMlib.}
#     ##  Define the garbage collector to use during code generation.
#     ##
#     ##  @see llvm::Function::setGC()

# proc addAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; a: AttributeRef) {.cdecl, importc: "LLVMAddAttributeAtIndex", dynlib: LLVMlib.}
#     ##  Add an attribute to a function.
#     ##
#     ##  @see llvm::Function::addAttribute()
# proc getAttributeCountAtIndex*(f: ValueRef; idx: AttributeIndex): cuint {.cdecl, importc: "LLVMGetAttributeCountAtIndex", dynlib: LLVMlib.}
# proc getAttributesAtIndex*(f: ValueRef; idx: AttributeIndex;attrs: ptr AttributeRef) {. cdecl, importc: "LLVMGetAttributesAtIndex", dynlib: LLVMlib.}
# proc getEnumAttributeAtIndex*(f: ValueRef; idx: AttributeIndex;kindID: cuint): AttributeRef {. cdecl, importc: "LLVMGetEnumAttributeAtIndex", dynlib: LLVMlib.}
# proc getStringAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; k: cstring;kLen: cuint): AttributeRef {.cdecl, importc: "LLVMGetStringAttributeAtIndex", dynlib: LLVMlib.}
# proc removeEnumAttributeAtIndex*(f: ValueRef; idx: AttributeIndex;kindID: cuint) {. cdecl, importc: "LLVMRemoveEnumAttributeAtIndex", dynlib: LLVMlib.}
# proc removeStringAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; k: cstring;kLen: cuint) {.cdecl, importc: "LLVMRemoveStringAttributeAtIndex", dynlib: LLVMlib.}

# proc addTargetDependentFunctionAttr*(fn: ValueRef; a: cstring; v: cstring) {.cdecl, importc: "LLVMAddTargetDependentFunctionAttr", dynlib: LLVMlib.}
#     ##  Add a target-dependent attribute to a function
#     ##  @see llvm::AttrBuilder::addAttribute()


# ##  Functions in this group relate to arguments/parameters on functions.
# ##
# ##  Functions in this group expect LLVMValueRef instances that correspond
# ##  to llvm::Function instances.
# proc countParams*(fn: ValueRef): cuint {.cdecl, importc: "LLVMCountParams", dynlib: LLVMlib.}
#     ##  Obtain the number of parameters in a function.
#     ##
#     ##  @see llvm::Function::arg_size()

# proc getParams*(fn: ValueRef; params: ptr ValueRef) {.cdecl, importc: "LLVMGetParams", dynlib: LLVMlib.}
#     ##  Obtain the parameters in a function.
#     ##
#     ##  The takes a pointer to a pre-allocated array of LLVMValueRef that is
#     ##  at least LLVMCountParams() long. This array will be filled with
#     ##  LLVMValueRef instances which correspond to the parameters the
#     ##  function receives. Each LLVMValueRef corresponds to a llvm::Argument
#     ##  instance.
#     ##
#     ##  @see llvm::Function::arg_begin()

# proc getParam*(fn: ValueRef; index: cuint): ValueRef {.cdecl, importc: "LLVMGetParam", dynlib: LLVMlib.}
#     ##  Obtain the parameter at the specified index.
#     ##
#     ##  Parameters are indexed from 0.
#     ##
#     ##  @see llvm::Function::arg_begin()
proc param*(fn: FunctionValue, index: int): Value =
    newValue[Value](getParam(fn.value, cuint index))

# proc getParamParent*(inst: ValueRef): ValueRef {.cdecl, importc: 
# "LLVMGetParamParent", dynlib: 
#     LLVMlib.}
#     ##  Obtain the function to which this argument belongs.
#     ##
#     ##  Unlike other functions in this group, this one takes an LLVMValueRef
#     ##  that corresponds to a llvm::Attribute.
#     ##
#     ##  The returned LLVMValueRef is the llvm::Function to which this
#     ##  argument belongs.

# proc getFirstParam*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetFirstParam", dynlib: LLVMlib.}
#     ##  Obtain the first parameter to a function.
#     ##
#     ##  @see llvm::Function::arg_begin()

# proc getLastParam*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetLastParam", dynlib: LLVMlib.}
#     ##  Obtain the last parameter to a function.
#     ##
#     ##  @see llvm::Function::arg_end()

# proc getNextParam*(arg: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextParam", dynlib: LLVMlib.}
#     ##  Obtain the next parameter to a function.
#     ##
#     ##  This takes an LLVMValueRef obtained from LLVMGetFirstParam() (which is
#     ##  actually a wrapped iterator) and obtains the next parameter from the
#     ##  underlying iterator.

# proc getPreviousParam*(arg: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousParam", dynlib: LLVMlib.}
#     ##  Obtain the previous parameter to a function.
#     ##
#     ##  This is the opposite of LLVMGetNextParam().

# proc setParamAlignment*(arg: ValueRef; align: cuint) {.cdecl, importc: "LLVMSetParamAlignment", dynlib: LLVMlib.}
#     ##  Set the alignment for a function parameter.
#     ##
#     ##  @see llvm::Argument::addAttr()
#     ##  @see llvm::AttrBuilder::addAlignmentAttr()


# ##  Functions in this group relate to indirect functions.
# ##
# ##  Functions in this group expect LLVMValueRef instances that correspond
# ##  to llvm::GlobalIFunc instances.
# proc addGlobalIFunc*(m: ModuleRef; name: cstring; nameLen: csize_t; ty: TypeRef;addrSpace: cuint; resolver: ValueRef): ValueRef {.cdecl, importc: "LLVMAddGlobalIFunc", dynlib: LLVMlib.}
#     ##  Add a global indirect function to a module under a specified name.
#     ##
#     ##  @see llvm::GlobalIFunc::create()

# proc getNamedGlobalIFunc*(m: ModuleRef; name: cstring;nameLen: csize_t): ValueRef {. cdecl, importc: "LLVMGetNamedGlobalIFunc", dynlib: LLVMlib.}
#     ##  Obtain a GlobalIFunc value from a Module by its name.
#     ##
#     ##  The returned value corresponds to a llvm::GlobalIFunc value.
#     ##
#     ##  @see llvm::Module::getNamedIFunc()

# proc getFirstGlobalIFunc*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetFirstGlobalIFunc", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the first GlobalIFunc in a Module.
#     ##
#     ##  @see llvm::Module::ifunc_begin()

# proc getLastGlobalIFunc*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetLastGlobalIFunc", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the last GlobalIFunc in a Module.
#     ##
#     ##  @see llvm::Module::ifunc_end()

# proc getNextGlobalIFunc*(iFunc: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextGlobalIFunc", dynlib: LLVMlib.}
#     ##  Advance a GlobalIFunc iterator to the next GlobalIFunc.
#     ##
#     ##  Returns NULL if the iterator was already at the end and there are no more
#     ##  global aliases.

# proc getPreviousGlobalIFunc*(iFunc: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousGlobalIFunc", dynlib: LLVMlib.}
#     ##  Decrement a GlobalIFunc iterator to the previous GlobalIFunc.
#     ##
#     ##  Returns NULL if the iterator was already at the beginning and there are
#     ##  no previous global aliases.

# proc getGlobalIFuncResolver*(iFunc: ValueRef): ValueRef {.cdecl, importc: "LLVMGetGlobalIFuncResolver", dynlib: LLVMlib.}
#     ##  Retrieves the resolver function associated with this indirect function, or
#     ##  NULL if it doesn't not exist.
#     ##
#     ##  @see llvm::GlobalIFunc::getResolver()

# proc setGlobalIFuncResolver*(iFunc: ValueRef; resolver: ValueRef) {.cdecl, importc: "LLVMSetGlobalIFuncResolver", dynlib: LLVMlib.}
#     ##  Sets the resolver function associated with this indirect function.
#     ##
#     ##  @see llvm::GlobalIFunc::setResolver()

# proc eraseGlobalIFunc*(iFunc: ValueRef) {.cdecl, importc: "LLVMEraseGlobalIFunc", dynlib: LLVMlib.}
#     ##  Remove a global indirect function from its parent module and delete it.
#     ##
#     ##  @see llvm::GlobalIFunc::eraseFromParent()

# proc removeGlobalIFunc*(iFunc: ValueRef) {.cdecl, importc: "LLVMRemoveGlobalIFunc", dynlib: LLVMlib.}
#     ##  Remove a global indirect function from its parent module.
#     ##
#     ##  This unlinks the global indirect function from its containing module but
#     ##  keeps it alive.
#     ##
#     ##  @see llvm::GlobalIFunc::removeFromParent()

# proc mdStringInContext2*(c: ContextRef; str: cstring;sLen: csize_t): MetadataRef {.cdecl, importc: "LLVMMDStringInContext2", dynlib: LLVMlib.}
#     ##  Create an MDString value from a given string value.
#     ##
#     ##  The MDString value does not take ownership of the given string, it remains
#     ##  the responsibility of the caller to free it.
#     ##
#     ##  @see llvm::MDString::get()

# proc mdNodeInContext2*(c: ContextRef; mDs: ptr MetadataRef;count: csize_t): MetadataRef {. cdecl, importc: "LLVMMDNodeInContext2", dynlib: LLVMlib.}
#     ##  Create an MDNode value with the given array of operands.
#     ##
#     ##  @see llvm::MDNode::get()

# proc metadataAsValue*(c: ContextRef; md: MetadataRef): ValueRef {.cdecl, importc: "LLVMMetadataAsValue", dynlib: LLVMlib.}
#     ##  Obtain a Metadata as a Value.

# proc valueAsMetadata*(val: ValueRef): MetadataRef {.cdecl, importc: "LLVMValueAsMetadata", dynlib: LLVMlib.}
#     ##  Obtain a Value as a Metadata.

# proc getMDString*(v: ValueRef; length: ptr cuint): cstring {.cdecl, importc: "LLVMGetMDString", dynlib: LLVMlib.}
#     ##  Obtain the underlying string from a MDString value.
#     ##
#     ##  @param V Instance to obtain string from.
#     ##  @param Length Memory address which will hold length of returned string.
#     ##  @return String data in MDString.

# proc getMDNodeNumOperands*(v: ValueRef): cuint {.cdecl, importc: "LLVMGetMDNodeNumOperands", dynlib: LLVMlib.}
#     ##  Obtain the number of operands from an MDNode value.
#     ##
#     ##  @param V MDNode to get number of operands from.
#     ##  @return Number of operands of the MDNode.

# proc getMdNodeOperands*(v: ValueRef; dest: ptr ValueRef) {.cdecl, importc: "LLVMGetMDNodeOperands", dynlib: LLVMlib.}
#     ##  Obtain the given MDNode's operands.
#     ##
#     ##  The passed LLVMValueRef pointer should point to enough memory to hold all of
#     ##  the operands of the given MDNode (see LLVMGetMDNodeNumOperands) as
#     ##  LLVMValueRefs. This memory will be populated with the LLVMValueRefs of the
#     ##  MDNode's operands.
#     ##
#     ##  @param V MDNode to get the operands from.
#     ##  @param Dest Destination array for operands.

# proc mdStringInContext*(c: ContextRef; str: cstring; sLen: cuint): ValueRef {.cdecl, importc: "LLVMMDStringInContext", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMMDStringInContext2 instead.

# proc mdString*(str: cstring; sLen: cuint): ValueRef {.cdecl, importc: "LLVMMDString", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMMDStringInContext2 instead.
# proc mdNodeInContext*(c: ContextRef; vals: ptr ValueRef;count: cuint): ValueRef {.cdecl, importc: "LLVMMDNodeInContext", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMMDNodeInContext2 instead.

# proc mdNode*(vals: ptr ValueRef; count: cuint): ValueRef {.cdecl, importc: "LLVMMDNode", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMMDNodeInContext2 instead.


# REGION: BaiscBlock

##  A basic block represents a single entry single exit section of code.
##  Basic blocks contain a list of instructions which form the body of
##  the block.
##
##  Basic blocks belong to functions. They have the type of label.
##
##  Basic blocks are themselves values. However, the C API models them as
##  LLVMBasicBlockRef.
# proc basicBlockAsValue*(bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMBasicBlockAsValue", dynlib: LLVMlib.}
#     ##  Convert a basic block instance to a value type.

# proc valueIsBasicBlock*(val: ValueRef): Bool {.cdecl, importc: "LLVMValueIsBasicBlock", dynlib: LLVMlib.}
#     ##  Determine whether an LLVMValueRef is itself a basic block.

# proc valueAsBasicBlock*(val: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMValueAsBasicBlock", dynlib: LLVMlib.}
#     ##  Convert an LLVMValueRef to an LLVMBasicBlockRef instance.

# proc getBasicBlockName*(bb: BasicBlockRef): cstring {.cdecl, importc: "LLVMGetBasicBlockName", dynlib: LLVMlib.}
#     ##  Obtain the string name of a basic block.

# proc getBasicBlockParent*(bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMGetBasicBlockParent", dynlib: LLVMlib.}
#     ##  Obtain the function to which a basic block belongs.
#     ##
#     ##  @see llvm::BasicBlock::getParent()

# proc getBasicBlockTerminator*(bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMGetBasicBlockTerminator", dynlib: LLVMlib.}
#     ##  Obtain the terminator instruction for a basic block.
#     ##
#     ##  If the basic block does not have a terminator (it is not well-formed
#     ##  if it doesn't), then NULL is returned.
#     ##
#     ##  The returned LLVMValueRef corresponds to an llvm::Instruction.
#     ##
#     ##  @see llvm::BasicBlock::getTerminator()

# proc countBasicBlocks*(fn: ValueRef): cuint {.cdecl, importc: "LLVMCountBasicBlocks", dynlib: LLVMlib.}
#     ##  Obtain the number of basic blocks in a function.
#     ##
#     ##  @param Fn Function value to operate on.

# proc getBasicBlocks*(fn: ValueRef; basicBlocks: ptr BasicBlockRef) {.cdecl, importc: "LLVMGetBasicBlocks", dynlib: LLVMlib.}
#     ##  Obtain all of the basic blocks in a function.
#     ##
#     ##  This operates on a function value. The BasicBlocks parameter is a
#     ##  pointer to a pre-allocated array of LLVMBasicBlockRef of at least
#     ##  LLVMCountBasicBlocks() in length. This array is populated with
#     ##  LLVMBasicBlockRef instances.

# proc getFirstBasicBlock*(fn: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetFirstBasicBlock", dynlib: LLVMlib.}
#     ##  Obtain the first basic block in a function.
#     ##
#     ##  The returned basic block can be used as an iterator. You will likely
#     ##  eventually call into LLVMGetNextBasicBlock() with it.
#     ##
#     ##  @see llvm::Function::begin()

# proc getLastBasicBlock*(fn: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetLastBasicBlock", dynlib: LLVMlib.}
#     ##  Obtain the last basic block in a function.
#     ##
#     ##  @see llvm::Function::end()

# proc getNextBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.cdecl, importc: "LLVMGetNextBasicBlock", dynlib: LLVMlib.}
#     ##  Advance a basic block iterator.

# proc getPreviousBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.cdecl, importc: "LLVMGetPreviousBasicBlock", dynlib: LLVMlib.}
#     ##  Go backwards in a basic block iterator.

# proc getEntryBasicBlock*(fn: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetEntryBasicBlock", dynlib: LLVMlib.}
#     ##  Obtain the basic block that corresponds to the entry point of a
#     ##  function.
#     ##
#     ##  @see llvm::Function::getEntryBlock()

# proc insertExistingBasicBlockAfterInsertBlock*(builder: BuilderRef;bb: BasicBlockRef) {.cdecl, importc: "LLVMInsertExistingBasicBlockAfterInsertBlock", dynlib: LLVMlib.}
#     ##  Insert the given basic block after the insertion point of the given builder.
#     ##
#     ##  The insertion point must be valid.
#     ##
#     ##  @see llvm::Function::BasicBlockListType::insertAfter()

# proc appendExistingBasicBlock*(fn: ValueRef; bb: BasicBlockRef) {.cdecl, importc: "LLVMAppendExistingBasicBlock", dynlib: LLVMlib.}
proc appendBasicBlock*(fn: FunctionValue, bb: BasicBlock) =
    ##  Append the given basic block to the basic block list of the given function.
    ##
    ##  Wrapping:
    ##  * `appendExistingBasicBlock(ValueRef, BasicBlockRef)<../llvm/Core.html#appendExistingBasicBlock,ValueRef,BasicBlockRef>`_
    fn.value.appendExistingBasicBlock(bb.bb)

proc newBasicBlock*(cxt: Context, name: string = ""): BasicBlock =
    ##  Create a new basic block without inserting it into a function.
    ##
    ##  Wrapping:
    ##  * `createBasicBlockInContext(ContextRef, cstring)<../llvm/Core.html#createBasicBlockInContext,ContextRef,cstring>`_
    newBB(cxt.context.createBasicBlockInContext(name))


proc appendBasicBlock*(fn: FunctionValue, name: string, cxt: Context = nil): BasicBlock =
    ##  Append a basic block to the end of a function using a specific context.
    ##  If `cxt` is **nil**, using the global context.
    ## 
    ##  Wrapping:
    ##  * `appendBasicBlock(ValueRef, cstring)<../llvm/Core.html#appendBasicBlock,ValueRef,cstring>`_
    assert fn.kind == FunctionValueKind
    newBB(fn.value.appendBasicBlock(name))

# proc insertBasicBlockInContext*(c: ContextRef; bb: BasicBlockRef;name: cstring): BasicBlockRef {. cdecl, importc: "LLVMInsertBasicBlockInContext", dynlib: LLVMlib.}
#     ##  Insert a basic block in a function before another basic block.
#     ##
#     ##  The function to add to is determined by the function of the
#     ##  passed basic block.
#     ##
#     ##  @see llvm::BasicBlock::Create()

# proc insertBasicBlock*(insertBeforeBB: BasicBlockRef;name: cstring): BasicBlockRef {. cdecl, importc: "LLVMInsertBasicBlock", dynlib: LLVMlib.}
#     ##  Insert a basic block in a function using the global context.
#     ##
#     ##  @see llvm::BasicBlock::Create()

# proc deleteBasicBlock*(bb: BasicBlockRef) {.cdecl, importc: "LLVMDeleteBasicBlock", dynlib: LLVMlib.}
# ##  Remove a basic block from a function and delete it.
# ##
# ##  This deletes the basic block from its containing function and deletes
# ##  the basic block itself.
# ##
# ##  @see llvm::BasicBlock::eraseFromParent()

# proc removeBasicBlockFromParent*(bb: BasicBlockRef) {.cdecl, importc: "LLVMRemoveBasicBlockFromParent", dynlib: LLVMlib.}
#     ##  Remove a basic block from a function.
#     ##
#     ##  This deletes the basic block from its containing function but keep
#     ##  the basic block alive.
#     ##
#     ##  @see llvm::BasicBlock::removeFromParent()

# proc moveBasicBlockBefore*(bb: BasicBlockRef; movePos: BasicBlockRef) {.cdecl, importc: "LLVMMoveBasicBlockBefore", dynlib: LLVMlib.}
#     ##  Move a basic block to before another one.
#     ##
#     ##  @see llvm::BasicBlock::moveBefore()

# proc moveBasicBlockAfter*(bb: BasicBlockRef; movePos: BasicBlockRef) {.cdecl, importc: "LLVMMoveBasicBlockAfter", dynlib: LLVMlib.}
#     ##  Move a basic block to after another one.
#     ##
#     ##  @see llvm::BasicBlock::moveAfter()

# proc getFirstInstruction*(bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMGetFirstInstruction", dynlib: LLVMlib.}
#     ##  Obtain the first instruction in a basic block.
#     ##
#     ##  The returned LLVMValueRef corresponds to a llvm::Instruction
#     ##  instance.

# proc getLastInstruction*(bb: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMGetLastInstruction", dynlib: LLVMlib.}
#     ##  Obtain the last instruction in a basic block.
#     ##
#     ##  The returned LLVMValueRef corresponds to an LLVM:Instruction.


# ##  Functions in this group relate to the inspection and manipulation of
# ##  individual instructions.
# ##
# ##  In the C++ API, an instruction is modeled by llvm::Instruction. This
# ##  class has a large number of descendents. llvm::Instruction is a
# ##  llvm::Value and in the C API, instructions are modeled by
# ##  LLVMValueRef.
# ##
# ##  This group also contains sub-groups which operate on specific
# ##  llvm::Instruction types, e.g. llvm::CallInst.
# proc hasMetadata*(val: ValueRef): cint {.cdecl, importc: "LLVMHasMetadata", dynlib: LLVMlib.}
#     ##  Determine whether an instruction has any metadata attached.

# proc getMetadata*(val: ValueRef; kindID: cuint): ValueRef {.cdecl, importc: "LLVMGetMetadata", dynlib: LLVMlib.}
#     ##  Return metadata associated with an instruction value.

# proc setMetadata*(val: ValueRef; kindID: cuint; node: ValueRef) {.cdecl, importc: "LLVMSetMetadata", dynlib: LLVMlib.}
#     ##  Set metadata associated with an instruction value.

# proc instructionGetAllMetadataOtherThanDebugLoc*(instr: ValueRef;numEntries: ptr csize_t): ptr ValueMetadataEntry {.cdecl, importc: "LLVMInstructionGetAllMetadataOtherThanDebugLoc", dynlib: LLVMlib.}
#     ##  Returns the metadata associated with an instruction value, but filters out
#     ##  all the debug locations.
#     ##
#     ##  @see llvm::Instruction::getAllMetadataOtherThanDebugLoc()

# proc getInstructionParent*(inst: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetInstructionParent", dynlib: LLVMlib.}
#     ##  Obtain the basic block to which an instruction belongs.
#     ##
#     ##  @see llvm::Instruction::getParent()

# proc getNextInstruction*(inst: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextInstruction", dynlib: LLVMlib.}
#     ##  Obtain the instruction that occurs after the one specified.
#     ##
#     ##  The next instruction will be from the same basic block.
#     ##
#     ##  If this is the last instruction in a basic block, NULL will be
#     ##  returned.

# proc getPreviousInstruction*(inst: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousInstruction", dynlib: LLVMlib.}
#     ##  Obtain the instruction that occurred before this one.
#     ##
#     ##  If the instruction is the first instruction in a basic block, NULL
#     ##  will be returned.

# proc instructionRemoveFromParent*(inst: ValueRef) {.cdecl, importc: "LLVMInstructionRemoveFromParent", dynlib: LLVMlib.}
#     ##  Remove and delete an instruction.
#     ##
#     ##  The instruction specified is removed from its containing building
#     ##  block but is kept alive.
#     ##
#     ##  @see llvm::Instruction::removeFromParent()

# proc instructionEraseFromParent*(inst: ValueRef) {.cdecl, importc: "LLVMInstructionEraseFromParent", dynlib: LLVMlib.}
#     ##  Remove and delete an instruction.
#     ##
#     ##  The instruction specified is removed from its containing building
#     ##  block and then deleted.
#     ##
#     ##  @see llvm::Instruction::eraseFromParent()

# proc getInstructionOpcode*(inst: ValueRef): Opcode {.cdecl, importc: "LLVMGetInstructionOpcode", dynlib: LLVMlib.}
#     ##  Obtain the code opcode for an individual instruction.
#     ##
#     ##  @see llvm::Instruction::getOpCode()

# proc getICmpPredicate*(inst: ValueRef): IntPredicate {.cdecl, importc: "LLVMGetICmpPredicate", dynlib: LLVMlib.}
#     ##  Obtain the predicate of an instruction.
#     ##
#     ##  This is only valid for instructions that correspond to llvm::ICmpInst
#     ##  or llvm::ConstantExpr whose opcode is llvm::Instruction::ICmp.
#     ##
#     ##  @see llvm::ICmpInst::getPredicate()

# proc getFCmpPredicate*(inst: ValueRef): RealPredicate {.cdecl, importc: "LLVMGetFCmpPredicate", dynlib: LLVMlib.}
#     ##  Obtain the float predicate of an instruction.
#     ##
#     ##  This is only valid for instructions that correspond to llvm::FCmpInst
#     ##  or llvm::ConstantExpr whose opcode is llvm::Instruction::FCmp.
#     ##
#     ##  @see llvm::FCmpInst::getPredicate()

# proc instructionClone*(inst: ValueRef): ValueRef {.cdecl, importc: "LLVMInstructionClone", dynlib: LLVMlib.}
#     ##  Create a copy of 'this' instruction that is identical in all ways
#     ##  except the following:
#     ##    * The instruction has no parent
#     ##    * The instruction has no name
#     ##
#     ##  @see llvm::Instruction::clone()

# proc isATerminatorInst*(inst: ValueRef): ValueRef {.cdecl, importc: "LLVMIsATerminatorInst", dynlib: LLVMlib.}
#     ##  Determine whether an instruction is a terminator. This routine is named to
#     ##  be compatible with historical functions that did this by querying the
#     ##  underlying C++ type.
#     ##
#     ##  @see llvm::Instruction::isTerminator()


# ##  Functions in this group apply to instructions that refer to call
# ##  sites and invocations. These correspond to C++ types in the
# ##  llvm::CallInst class tree.
# proc getNumArgOperands*(instr: ValueRef): cuint {.cdecl, importc: "LLVMGetNumArgOperands", dynlib: LLVMlib.}
#     ##  Obtain the argument count for a call instruction.
#     ##
#     ##  This expects an LLVMValueRef that corresponds to a llvm::CallInst,
#     ##  llvm::InvokeInst, or llvm:FuncletPadInst.
#     ##
#     ##  @see llvm::CallInst::getNumArgOperands()
#     ##  @see llvm::InvokeInst::getNumArgOperands()
#     ##  @see llvm::FuncletPadInst::getNumArgOperands()

# proc setInstructionCallConv*(instr: ValueRef; cc: cuint) {.cdecl, importc: "LLVMSetInstructionCallConv", dynlib: LLVMlib.}
#     ##  Set the calling convention for a call instruction.
#     ##
#     ##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
#     ##  llvm::InvokeInst.
#     ##
#     ##  @see llvm::CallInst::setCallingConv()
#     ##  @see llvm::InvokeInst::setCallingConv()

# proc getInstructionCallConv*(instr: ValueRef): cuint {.cdecl, importc: "LLVMGetInstructionCallConv", dynlib: LLVMlib.}
#     ##  Obtain the calling convention for a call instruction.
#     ##
#     ##  This is the opposite of LLVMSetInstructionCallConv(). Reads its
#     ##  usage.
#     ##
#     ##  @see LLVMSetInstructionCallConv()

# proc setInstrParamAlignment*(instr: ValueRef; index: cuint; align: cuint) {.cdecl, importc: "LLVMSetInstrParamAlignment", dynlib: LLVMlib.}
# proc addCallSiteAttribute*(c: ValueRef; idx: AttributeIndex; a: AttributeRef) {.cdecl, importc: "LLVMAddCallSiteAttribute", dynlib: LLVMlib.}
# proc getCallSiteAttributeCount*(c: ValueRef; idx: AttributeIndex): cuint {.cdecl, importc: "LLVMGetCallSiteAttributeCount", dynlib: LLVMlib.}
# proc getCallSiteAttributes*(c: ValueRef; idx: AttributeIndex;attrs: ptr AttributeRef) {. cdecl, importc: "LLVMGetCallSiteAttributes", dynlib: LLVMlib.}
# proc getCallSiteEnumAttribute*(c: ValueRef; idx: AttributeIndex;kindID: cuint): AttributeRef {. cdecl, importc: "LLVMGetCallSiteEnumAttribute", dynlib: LLVMlib.}
# proc getCallSiteStringAttribute*(c: ValueRef; idx: AttributeIndex; k: cstring;kLen: cuint): AttributeRef {.cdecl, importc: "LLVMGetCallSiteStringAttribute", dynlib: LLVMlib.}
# proc removeCallSiteEnumAttribute*(c: ValueRef; idx: AttributeIndex;kindID: cuint) {. cdecl, importc: "LLVMRemoveCallSiteEnumAttribute", dynlib: LLVMlib.}
# proc removeCallSiteStringAttribute*(c: ValueRef; idx: AttributeIndex; k: cstring;kLen: cuint) {.cdecl, importc: "LLVMRemoveCallSiteStringAttribute", dynlib: LLVMlib.}

# proc getCalledFunctionType*(c: ValueRef): TypeRef {.cdecl, importc: "LLVMGetCalledFunctionType", dynlib: LLVMlib.}
#     ##  Obtain the function type called by this instruction.
#     ##
#     ##  @see llvm::CallBase::getFunctionType()

# proc getCalledValue*(instr: ValueRef): ValueRef {.cdecl, importc: "LLVMGetCalledValue", dynlib: LLVMlib.}
#     ##  Obtain the pointer to the function invoked by this instruction.
#     ##
#     ##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
#     ##  llvm::InvokeInst.
#     ##
#     ##  @see llvm::CallInst::getCalledValue()
#     ##  @see llvm::InvokeInst::getCalledValue()

# proc isTailCall*(callInst: ValueRef): Bool {.cdecl, importc: "LLVMIsTailCall", dynlib: LLVMlib.}
#     ##  Obtain whether a call instruction is a tail call.
#     ##
#     ##  This only works on llvm::CallInst instructions.
#     ##
#     ##  @see llvm::CallInst::isTailCall()

# proc setTailCall*(callInst: ValueRef; isTailCall: Bool) {.cdecl, importc: "LLVMSetTailCall", dynlib: LLVMlib.}
#     ##  Set whether a call instruction is a tail call.
#     ##
#     ##  This only works on llvm::CallInst instructions.
#     ##
#     ##  @see llvm::CallInst::setTailCall()

# proc getNormalDest*(invokeInst: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetNormalDest", dynlib: LLVMlib.}
#     ##  Return the normal destination basic block.
#     ##
#     ##  This only works on llvm::InvokeInst instructions.
#     ##
#     ##  @see llvm::InvokeInst::getNormalDest()

# proc getUnwindDest*(invokeInst: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetUnwindDest", dynlib: LLVMlib.}
#     ##  Return the unwind destination basic block.
#     ##
#     ##  Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
#     ##  llvm::CatchSwitchInst instructions.
#     ##
#     ##  @see llvm::InvokeInst::getUnwindDest()
#     ##  @see llvm::CleanupReturnInst::getUnwindDest()
#     ##  @see llvm::CatchSwitchInst::getUnwindDest()

# proc setNormalDest*(invokeInst: ValueRef; b: BasicBlockRef) {.cdecl, importc: "LLVMSetNormalDest", dynlib: LLVMlib.}
#     ##  Set the normal destination basic block.
#     ##
#     ##  This only works on llvm::InvokeInst instructions.
#     ##
#     ##  @see llvm::InvokeInst::setNormalDest()

# proc setUnwindDest*(invokeInst: ValueRef; b: BasicBlockRef) {.cdecl, importc: "LLVMSetUnwindDest", dynlib: LLVMlib.}
#     ##  Set the unwind destination basic block.
#     ##
#     ##  Works on llvm::InvokeInst, llvm::CleanupReturnInst, and
#     ##  llvm::CatchSwitchInst instructions.
#     ##
#     ##  @see llvm::InvokeInst::setUnwindDest()
#     ##  @see llvm::CleanupReturnInst::setUnwindDest()
#     ##  @see llvm::CatchSwitchInst::setUnwindDest()


# ##  Functions in this group only apply to instructions for which
# ##  LLVMIsATerminatorInst returns true.
# proc getNumSuccessors*(term: ValueRef): cuint {.cdecl, importc: "LLVMGetNumSuccessors", dynlib: LLVMlib.}
#     ##  Return the number of successors that this terminator has.
#     ##
#     ##  @see llvm::Instruction::getNumSuccessors

# proc getSuccessor*(term: ValueRef; i: cuint): BasicBlockRef {.cdecl, importc: "LLVMGetSuccessor", dynlib: LLVMlib.}
#     ##  Return the specified successor.
#     ##
#     ##  @see llvm::Instruction::getSuccessor

# proc setSuccessor*(term: ValueRef; i: cuint; `block`: BasicBlockRef) {.cdecl, importc: "LLVMSetSuccessor", dynlib: LLVMlib.}
#     ##  Update the specified successor to point at the provided block.
#     ##
#     ##  @see llvm::Instruction::setSuccessor

# proc isConditional*(branch: ValueRef): Bool {.cdecl, importc: "LLVMIsConditional", dynlib: LLVMlib.}
#     ##  Return if a branch is conditional.
#     ##
#     ##  This only works on llvm::BranchInst instructions.
#     ##
#     ##  @see llvm::BranchInst::isConditional

# proc getCondition*(branch: ValueRef): ValueRef {.cdecl, importc: "LLVMGetCondition", dynlib: LLVMlib.}
#     ##  Return the condition of a branch instruction.
#     ##
#     ##  This only works on llvm::BranchInst instructions.
#     ##
#     ##  @see llvm::BranchInst::getCondition

# proc setCondition*(branch: ValueRef; cond: ValueRef) {.cdecl, importc: "LLVMSetCondition", dynlib: LLVMlib.}
#     ##  Set the condition of a branch instruction.
#     ##
#     ##  This only works on llvm::BranchInst instructions.
#     ##
#     ##  @see llvm::BranchInst::setCondition

# proc getSwitchDefaultDest*(switchInstr: ValueRef): BasicBlockRef {.cdecl, importc: "LLVMGetSwitchDefaultDest", dynlib: LLVMlib.}
#     ##  Obtain the default destination basic block of a switch instruction.
#     ##
#     ##  This only works on llvm::SwitchInst instructions.
#     ##
#     ##  @see llvm::SwitchInst::getDefaultDest()


# ##  Functions in this group only apply to instructions that map to
# ##  llvm::AllocaInst instances.
# proc getAllocatedType*(alloca: ValueRef): TypeRef {.cdecl, importc: "LLVMGetAllocatedType", dynlib: LLVMlib.}
#     ##  Obtain the type that is being allocated by the alloca instruction.

# ##  Functions in this group only apply to instructions that map to
# ##  llvm::GetElementPtrInst instances.
# proc isInBounds*(gep: ValueRef): Bool {.cdecl, importc: "LLVMIsInBounds", dynlib: LLVMlib.}
#     ##  Check whether the given GEP instruction is inbounds.

# proc setIsInBounds*(gep: ValueRef; inBounds: Bool) {.cdecl, importc: "LLVMSetIsInBounds", dynlib: LLVMlib.}
#     ##  Set the given GEP instruction to be inbounds or not.


# ##  Functions in this group only apply to instructions that map to
# ##  llvm::PHINode instances.
# proc addIncoming*(phiNode: ValueRef; incomingValues: ptr ValueRef;incomingBlocks: ptr BasicBlockRef; count: cuint) {.cdecl, importc: "LLVMAddIncoming", dynlib: LLVMlib.}
#     ##  Add an incoming value to the end of a PHI list.
proc addIncoming*(phiNode: Value; vb: openarray[(Value, BasicBlock)]) =
    ##  Add an incoming value to the end of a PHI list.
    var
        vals = vb.mapIt(it[0].value)
        bs = vb.mapIt(it[1].bb)
        vadr = if vals.len > 0: vals[0].addr else: nil
        badr = if bs.len > 0: bs[0].addr else: nil
    phiNode.value.addIncoming(vadr, badr, cuint vals.len)

# proc countIncoming*(phiNode: ValueRef): cuint {.cdecl, importc: "LLVMCountIncoming", dynlib: LLVMlib.}
#     ##  Obtain the number of incoming basic blocks to a PHI node.

# proc getIncomingValue*(phiNode: ValueRef; index: cuint): ValueRef {.cdecl, importc: "LLVMGetIncomingValue", dynlib: LLVMlib.}
#     ##  Obtain an incoming value to a PHI node as an LLVMValueRef.

# proc getIncomingBlock*(phiNode: ValueRef; index: cuint): BasicBlockRef {.cdecl, importc: "LLVMGetIncomingBlock", dynlib: LLVMlib.}
#     ##  Obtain an incoming value to a PHI node as an LLVMBasicBlockRef.


# ##  Functions in this group only apply to instructions that map to
# ##  llvm::ExtractValue and llvm::InsertValue instances.
# proc getNumIndices*(inst: ValueRef): cuint {.cdecl, importc: "LLVMGetNumIndices", dynlib: LLVMlib.}
#     ##  Obtain the number of indices.
#     ##  NB: This also works on GEP.


# proc getIndices*(inst: ValueRef): ptr cuint {.cdecl, importc: "LLVMGetIndices", dynlib: LLVMlib.}
#     ##  Obtain the indices as an array.


# REGION: Builder
proc newBuilder*(cxt: Context = nil): Builder =
    ##  An instruction builder represents a point within a basic block and is
    ##  the exclusive means of building instructions using the C interface.
    ## 
    ##  Wrapping:
    ##  * `createBuilderInContext(ContextRef)<../llvm/Core.html#createBuilderInContext,ContextRef>`_
    ##  * `createBuilder()<../llvm/Core.html#createBuilder>`_
    newBuilder(
        if cxt.isNil:
            createBuilder()
        else:
            createBuilderInContext(cxt.context)
    )

# proc positionBuilder*(builder: BuilderRef; `block`: BasicBlockRef;instr: ValueRef) {. cdecl, importc: "LLVMPositionBuilder", dynlib: LLVMlib.}
# proc positionBuilderBefore*(builder: BuilderRef; instr: ValueRef) {.cdecl, importc: "LLVMPositionBuilderBefore", dynlib: LLVMlib.}
proc atEndOf*(self: Builder, bb: BasicBlock) =
    ##  Positions at the end of the *BasicBlock*
    ## 
    ##  Wrapping:
    ##  * `positionBuilderAtEnd(BuilderRef, BasicBlockRef)<../llvm/Core.html#positionBuilderAtEnd,BuilderRef,BasicBlockRef>`_
    self.builder.positionBuilderAtEnd(bb.bb)

# proc getInsertBlock*(builder: BuilderRef): BasicBlockRef {.cdecl, importc: "LLVMGetInsertBlock", dynlib: LLVMlib.}
# proc clearInsertionPosition*(builder: BuilderRef) {.cdecl, importc: "LLVMClearInsertionPosition", dynlib: LLVMlib.}
# proc insertIntoBuilder*(builder: BuilderRef; instr: ValueRef) {.cdecl, importc: "LLVMInsertIntoBuilder", dynlib: LLVMlib.}
# proc insertIntoBuilderWithName*(builder: BuilderRef; instr: ValueRef;name: cstring) {. cdecl, importc: "LLVMInsertIntoBuilderWithName", dynlib: LLVMlib.}

# ##  Metadata
# proc getCurrentDebugLocation2*(builder: BuilderRef): MetadataRef {.cdecl, importc: "LLVMGetCurrentDebugLocation2", dynlib: LLVMlib.}
#     ##  Get location information used by debugging information.
#     ##
#     ##  @see llvm::IRBuilder::getCurrentDebugLocation()

# proc setCurrentDebugLocation2*(builder: BuilderRef; loc: MetadataRef) {.cdecl, importc: "LLVMSetCurrentDebugLocation2", dynlib: LLVMlib.}
#     ##  Set location information used by debugging information.
#     ##
#     ##  To clear the location metadata of the given instruction, pass NULL to \p Loc.
#     ##
#     ##  @see llvm::IRBuilder::SetCurrentDebugLocation()

# proc setInstDebugLocation*(builder: BuilderRef; inst: ValueRef) {.cdecl, importc: "LLVMSetInstDebugLocation", dynlib: LLVMlib.}
#     ##  Attempts to set the debug location for the given instruction using the
#     ##  current debug location for the given builder.  If the builder has no current
#     ##  debug location, this function is a no-op.
#     ##
#     ##  @see llvm::IRBuilder::SetInstDebugLocation()

# proc builderGetDefaultFPMathTag*(builder: BuilderRef): MetadataRef {.cdecl, importc: "LLVMBuilderGetDefaultFPMathTag", dynlib: LLVMlib.}
#     ##  Get the dafult floating-point math metadata for a given builder.
#     ##
#     ##  @see llvm::IRBuilder::getDefaultFPMathTag()

# proc builderSetDefaultFPMathTag*(builder: BuilderRef; fPMathTag: MetadataRef) {. cdecl, importc: "LLVMBuilderSetDefaultFPMathTag", dynlib: LLVMlib.}
#     ##  Set the default floating-point math metadata for the given builder.
#     ##
#     ##  To clear the metadata, pass NULL to \p FPMathTag.
#     ##
#     ##  @see llvm::IRBuilder::setDefaultFPMathTag()

# proc setCurrentDebugLocation*(builder: BuilderRef; L: ValueRef) {.cdecl, importc: "LLVMSetCurrentDebugLocation", dynlib: LLVMlib.}
#     ##  Deprecated: Passing the NULL location will crash.
#     ##  Use LLVMGetCurrentDebugLocation2 instead.

# proc getCurrentDebugLocation*(builder: BuilderRef): ValueRef {.cdecl, importc: "LLVMGetCurrentDebugLocation", dynlib: LLVMlib.}
#     ##  Deprecated: Returning the NULL location will crash.
#     ##  Use LLVMGetCurrentDebugLocation2 instead.

##  Terminators
proc retVoid*(self: Builder): Instruction {.discardable.} =
    ##  Wrapping:
    ##  * `buildRetVoid(BuilderRef)<../llvm/Core.html#buildRetVoid,BuilderRef>`_
    newValue[Instruction](self.builder.buildRetVoid())
proc ret*(self: Builder, val: Value): Instruction {.discardable.} =
    ##  Wrapping:
    ##  * `buildRet(BuilderRef, ValueRef)<../llvm/Core.html#buildRet,BuilderRef,ValueRef>`_
    newValue[Instruction](self.builder.buildRet(val.value))

# proc buildAggregateRet*(a1: BuilderRef; retVals: ptr ValueRef;n: cuint): ValueRef {. cdecl, importc: "LLVMBuildAggregateRet", dynlib: LLVMlib.}
# proc buildBr*(a1: BuilderRef; dest: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMBuildBr", dynlib: LLVMlib.}
proc br*(self: Builder, dest: BasicBlock): Instruction {.discardable.} =
    newValue[Instruction](self.builder.buildBr(dest.bb))
# proc buildCondBr*(a1: BuilderRef; `if`: ValueRef; then: BasicBlockRef;`else`: BasicBlockRef): ValueRef {.cdecl, importc: "LLVMBuildCondBr", dynlib: LLVMlib.}
proc condBr*(self: Builder; `if`: Value; then: BasicBlock;`else`: BasicBlock): Instruction =
    newValue[Instruction](self.builder.buildCondBr(`if`.value, then.bb, `else`.bb))
# proc buildSwitch*(a1: BuilderRef; v: ValueRef; `else`: BasicBlockRef;numCases: cuint): ValueRef {. cdecl, importc: "LLVMBuildSwitch", dynlib: LLVMlib.}
# proc buildIndirectBr*(b: BuilderRef; `addr`: ValueRef;numDests: cuint): ValueRef {. cdecl, importc: "LLVMBuildIndirectBr", dynlib: LLVMlib.}

# proc buildInvoke*(a1: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;then: BasicBlockRef; catch: BasicBlockRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildInvoke", dynlib: LLVMlib.}
#     ##  LLVMBuildInvoke is deprecated in favor of LLVMBuildInvoke2, in preparation
#     ##  for opaque pointer types.
# proc buildInvoke2*(a1: BuilderRef; ty: TypeRef; fn: ValueRef; args: ptr ValueRef;numArgs: cuint; then: BasicBlockRef; catch: BasicBlockRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildInvoke2", dynlib: LLVMlib.}
# proc buildUnreachable*(a1: BuilderRef): ValueRef {.cdecl, importc: "LLVMBuildUnreachable", dynlib: LLVMlib.}

# ##  Exception Handling
# proc buildResume*(b: BuilderRef; exn: ValueRef): ValueRef {.cdecl, importc: "LLVMBuildResume", dynlib: LLVMlib.}
# proc buildLandingPad*(b: BuilderRef; ty: TypeRef; persFn: ValueRef; numClauses: cuint;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildLandingPad", dynlib: LLVMlib.}
# proc buildCleanupRet*(b: BuilderRef; catchPad: ValueRef;bb: BasicBlockRef): ValueRef {. cdecl, importc: "LLVMBuildCleanupRet", dynlib: LLVMlib.}
# proc buildCatchRet*(b: BuilderRef; catchPad: ValueRef;bb: BasicBlockRef): ValueRef {. cdecl, importc: "LLVMBuildCatchRet", dynlib: LLVMlib.}
# proc buildCatchPad*(b: BuilderRef; parentPad: ValueRef; args: ptr ValueRef;numArgs: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildCatchPad", dynlib: LLVMlib.}
# proc buildCleanupPad*(b: BuilderRef; parentPad: ValueRef; args: ptr ValueRef;numArgs: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildCleanupPad", dynlib: LLVMlib.}
# proc buildCatchSwitch*(b: BuilderRef; parentPad: ValueRef; unwindBB: BasicBlockRef;numHandlers: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildCatchSwitch", dynlib: LLVMlib.}

# proc addCase*(switch: ValueRef; onVal: ValueRef; dest: BasicBlockRef) {.cdecl, importc: "LLVMAddCase", dynlib: LLVMlib.}
#     ##  Add a case to the switch instruction

# proc addDestination*(indirectBr: ValueRef; dest: BasicBlockRef) {.cdecl, importc: "LLVMAddDestination", dynlib: LLVMlib.}
#     ##  Add a destination to the indirectbr instruction

# proc getNumClauses*(landingPad: ValueRef): cuint {.cdecl, importc: "LLVMGetNumClauses", dynlib: LLVMlib.}
#     ##  Get the number of clauses on the landingpad instruction

# proc getClause*(landingPad: ValueRef; idx: cuint): ValueRef {.cdecl, importc: "LLVMGetClause", dynlib: LLVMlib.}
#     ##  Get the value of the clause at idnex Idx on the landingpad instruction

# proc addClause*(landingPad: ValueRef; clauseVal: ValueRef) {.cdecl, importc: "LLVMAddClause", dynlib: LLVMlib.}
#     ##  Add a catch or filter clause to the landingpad instruction

# proc isCleanup*(landingPad: ValueRef): Bool {.cdecl, importc: "LLVMIsCleanup", dynlib: LLVMlib.}
#     ##  Get the 'cleanup' flag in the landingpad instruction

# proc setCleanup*(landingPad: ValueRef; val: Bool) {.cdecl, importc: "LLVMSetCleanup", dynlib: LLVMlib.}
#     ##  Set the 'cleanup' flag in the landingpad instruction

# proc addHandler*(catchSwitch: ValueRef; dest: BasicBlockRef) {.cdecl, importc: "LLVMAddHandler", dynlib: LLVMlib.}
#     ##  Add a destination to the catchswitch instruction

# proc getNumHandlers*(catchSwitch: ValueRef): cuint {.cdecl, importc: "LLVMGetNumHandlers", dynlib: LLVMlib.}
#     ##  Get the number of handlers on the catchswitch instruction

# proc getHandlers*(catchSwitch: ValueRef; handlers: ptr BasicBlockRef) {.cdecl, importc: "LLVMGetHandlers", dynlib: LLVMlib.}
#     ##  Obtain the basic blocks acting as handlers for a catchswitch instruction.
#     ##
#     ##  The Handlers parameter should point to a pre-allocated array of
#     ##  LLVMBasicBlockRefs at least LLVMGetNumHandlers() large. On return, the
#     ##  first LLVMGetNumHandlers() entries in the array will be populated
#     ##  with LLVMBasicBlockRef instances.
#     ##
#     ##  @param CatchSwitch The catchswitch instruction to operate on.
#     ##  @param Handlers Memory address of an array to be filled with basic blocks.

# ##  Funclets
# proc getArgOperand*(funclet: ValueRef; i: cuint): ValueRef {.cdecl, importc: "LLVMGetArgOperand", dynlib: LLVMlib.}
#     ##  Get the number of funcletpad arguments.

# proc setArgOperand*(funclet: ValueRef; i: cuint; value: ValueRef) {.cdecl, importc: "LLVMSetArgOperand", dynlib: LLVMlib.}
#     ##  Set a funcletpad argument at the given index.

# proc getParentCatchSwitch*(catchPad: ValueRef): ValueRef {.cdecl, importc: "LLVMGetParentCatchSwitch", dynlib: LLVMlib.}
#     ##  Get the parent catchswitch instruction of a catchpad instruction.
#     ##
#     ##  This only works on llvm::CatchPadInst instructions.
#     ##
#     ##  @see llvm::CatchPadInst::getCatchSwitch()

# proc setParentCatchSwitch*(catchPad: ValueRef; catchSwitch: ValueRef) {.cdecl, importc: "LLVMSetParentCatchSwitch", dynlib: LLVMlib.}
#     ##  Set the parent catchswitch instruction of a catchpad instruction.
#     ##
#     ##  This only works on llvm::CatchPadInst instructions.
#     ##
#     ##  @see llvm::CatchPadInst::setCatchSwitch()

# ##  Arithmetic
# proc buildAdd*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildAdd", dynlib: LLVMlib.}
# proc buildNSWAdd*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNSWAdd", dynlib: LLVMlib.}
# proc buildNUWAdd*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNUWAdd", dynlib: LLVMlib.}
# proc buildFAdd*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFAdd", dynlib: LLVMlib.}
# proc buildSub*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSub", dynlib: LLVMlib.}
# proc buildNSWSub*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNSWSub", dynlib: LLVMlib.}
# proc buildNUWSub*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNUWSub", dynlib: LLVMlib.}
# proc buildFSub*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFSub", dynlib: LLVMlib.}
# proc buildMul*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildMul", dynlib: LLVMlib.}
# proc buildNSWMul*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNSWMul", dynlib: LLVMlib.}
# proc buildNUWMul*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildNUWMul", dynlib: LLVMlib.}
# proc buildFMul*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFMul", dynlib: LLVMlib.}
# proc buildUDiv*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildUDiv", dynlib: LLVMlib.}
# proc buildExactUDiv*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildExactUDiv", dynlib: LLVMlib.}
# proc buildSDiv*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSDiv", dynlib: LLVMlib.}
# proc buildExactSDiv*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildExactSDiv", dynlib: LLVMlib.}
# proc buildFDiv*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFDiv", dynlib: LLVMlib.}
# proc buildURem*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildURem", dynlib: LLVMlib.}
# proc buildSRem*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSRem", dynlib: LLVMlib.}
# proc buildFRem*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFRem", dynlib: LLVMlib.}
# proc buildShl*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildShl", dynlib: LLVMlib.}
# proc buildLShr*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildLShr", dynlib: LLVMlib.}
# proc buildAShr*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildAShr", dynlib: LLVMlib.}
# proc buildAnd*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildAnd", dynlib: LLVMlib.}
# proc buildOr*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildOr", dynlib: LLVMlib.}
# proc buildXor*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildXor", dynlib: LLVMlib.}
# proc buildBinOp*(b: BuilderRef; op: Opcode; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildBinOp", dynlib: LLVMlib.}
# proc buildNeg*(a1: BuilderRef; v: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildNeg", dynlib: LLVMlib.}
# proc buildNSWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildNSWNeg", dynlib: LLVMlib.}
# proc buildNUWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildNUWNeg", dynlib: LLVMlib.}
# proc buildFNeg*(a1: BuilderRef; v: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildFNeg", dynlib: LLVMlib.}
# proc buildNot*(a1: BuilderRef; v: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildNot", dynlib: LLVMlib.}

# ##  Memory
# proc buildMalloc*(a1: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildMalloc", dynlib: LLVMlib.}
# proc buildArrayMalloc*(a1: BuilderRef; ty: TypeRef; val: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildArrayMalloc", dynlib: LLVMlib.}

# proc buildMemSet*(b: BuilderRef; `ptr`: ValueRef; val: ValueRef; len: ValueRef;align: cuint): ValueRef {.cdecl, importc: "LLVMBuildMemSet", dynlib: LLVMlib.}
#     ##  Creates and inserts a memset to the specified pointer and the
#     ##  specified value.
#     ##
#     ##  @see llvm::IRRBuilder::CreateMemSet()

# proc buildMemCpy*(b: BuilderRef; dst: ValueRef; dstAlign: cuint; src: ValueRef;srcAlign: cuint; size: ValueRef): ValueRef {.cdecl, importc: "LLVMBuildMemCpy", dynlib: LLVMlib.}
#     ##  Creates and inserts a memcpy between the specified pointers.
#     ##
#     ##  @see llvm::IRRBuilder::CreateMemCpy()

# proc buildMemMove*(b: BuilderRef; dst: ValueRef; dstAlign: cuint; src: ValueRef;srcAlign: cuint; size: ValueRef): ValueRef {.cdecl, importc: "LLVMBuildMemMove", dynlib: LLVMlib.}
#     ##  Creates and inserts a memmove between the specified pointers.
#     ##
#     ##  @see llvm::IRRBuilder::CreateMemMove()


proc alloca*(self: Builder, typ: Type, name: string = ""): Instruction =
    # FIXME: unificate with bulidArrayAlloca.
    ##  Wrapping:
    ##  * `buildAlloca(BuilderRef, TypeRef, cstring)<../llvm/Core.html#buildAlloca,BuilderRef,TypeRef,cstring>`_
    newValue[Instruction](self.builder.buildAlloca(typ.typ, name))
# proc buildArrayAlloca*(a1: BuilderRef; ty: TypeRef; val: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildArrayAlloca", dynlib: LLVMlib.}


# proc buildFree*(a1: BuilderRef; pointerVal: ValueRef): ValueRef {.cdecl, importc: "LLVMBuildFree", dynlib: LLVMlib.}
# proc buildLoad*(a1: BuilderRef; pointerVal: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildLoad", dynlib: LLVMlib.}
#     ##  LLVMBuildLoad is deprecated in favor of LLVMBuildLoad2, in preparation for
#     ##  opaque pointer types.

proc load*(self: Builder, typ: Type, ptrVal: Value, name: string = ""): Instruction =
    ##  Wrapping:
    ##  * `buildLoad2(BuilderRef, TypeRef, ValueRef, cstring)<../llvm/Core.html#buildLoad2,BuilderRef,TypeRef,ValueRef,cstring>`_
    newValue[Instruction](self.builder.buildLoad2(typ.typ, ptrVal.value, name))

proc store*(self: Builder, val: Value, `ptr`: Value, name: string = ""): Instruction =
    ##  Wrapping:
    ##  * `buildStore(BuilderRef, ValueRef, ValueRef)<../llvm/Core.html#buildStore,BuilderRef,ValueRef,ValueRef>`_
    newValue[Instruction](self.builder.buildStore(val.value, `ptr`.value))

# proc buildGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;numIndices: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildGEP", dynlib: LLVMlib.}
#     ##  LLVMBuildGEP, LLVMBuildInBoundsGEP, and LLVMBuildStructGEP are deprecated in
#     ##  favor of LLVMBuild*GEP2, in preparation for opaque pointer types.

# proc buildInBoundsGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;numIndices: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildInBoundsGEP", dynlib: LLVMlib.}
#     ##  LLVMBuildGEP, LLVMBuildInBoundsGEP, and LLVMBuildStructGEP are deprecated in
#     ##  favor of LLVMBuild*GEP2, in preparation for opaque pointer types.
# proc buildStructGEP*(b: BuilderRef; pointer: ValueRef; idx: cuint;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildStructGEP", dynlib: LLVMlib.}
#     ##  LLVMBuildGEP, LLVMBuildInBoundsGEP, and LLVMBuildStructGEP are deprecated in
#     ##  favor of LLVMBuild*GEP2, in preparation for opaque pointer types.
# proc buildGEP2*(b: BuilderRef; ty: TypeRef; pointer: ValueRef; indices: ptr ValueRef;numIndices: cuint; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildGEP2", dynlib: LLVMlib.}
# proc buildInBoundsGEP2*(b: BuilderRef; ty: TypeRef; pointer: ValueRef;indices: ptr ValueRef; numIndices: cuint;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildInBoundsGEP2", dynlib: LLVMlib.}

# proc buildStructGEP2*(b: BuilderRef; ty: TypeRef; pointer: ValueRef; idx: cuint;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildStructGEP2", dynlib: LLVMlib.}
# proc buildGlobalString*(b: BuilderRef; str: cstring; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildGlobalString", dynlib: LLVMlib.}
# proc buildGlobalStringPtr*(b: BuilderRef; str: cstring;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildGlobalStringPtr", dynlib: LLVMlib.}
# proc getVolatile*(memoryAccessInst: ValueRef): Bool {.cdecl, importc: "LLVMGetVolatile", dynlib: LLVMlib.}
# proc setVolatile*(memoryAccessInst: ValueRef; isVolatile: Bool) {.cdecl, importc: "LLVMSetVolatile", dynlib: LLVMlib.}
# proc getWeak*(cmpXchgInst: ValueRef): Bool {.cdecl, importc: "LLVMGetWeak", dynlib: LLVMlib.}
# proc setWeak*(cmpXchgInst: ValueRef; isWeak: Bool) {.cdecl, importc: "LLVMSetWeak", dynlib: LLVMlib.}
# proc getOrdering*(memoryAccessInst: ValueRef): AtomicOrdering {.cdecl, importc: "LLVMGetOrdering", dynlib: LLVMlib.}
# proc setOrdering*(memoryAccessInst: ValueRef; ordering: AtomicOrdering) {.cdecl, importc: "LLVMSetOrdering", dynlib: LLVMlib.}
# proc getAtomicRMWBinOp*(atomicRMWInst: ValueRef): AtomicRMWBinOp {.cdecl, importc: "LLVMGetAtomicRMWBinOp", dynlib: LLVMlib.}
# proc setAtomicRMWBinOp*(atomicRMWInst: ValueRef; binOp: AtomicRMWBinOp) {.cdecl, importc: "LLVMSetAtomicRMWBinOp", dynlib: LLVMlib.}

# ##  Casts
# proc buildTrunc*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildTrunc", dynlib: LLVMlib.}

proc zext*(self: Builder, val: Value, destTy: IntegerType, name: string = ""): Instruction =
    ##  Zero-extend integer value to integer type *destTy*.
    ## 
    ##  Wrapping:
    ##  * `buildZExt(BuilderRef, ValueRef, TypeRef, cstring)<../llvm/Core.html#buildZExt,BuilderRef,ValueRef,TypeRef,cstring>`_
    newValue[Instruction](self.builder.buildZExt(val.value, destTy.typ, name))

# proc buildSExt*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSExt", dynlib: LLVMlib.}
# proc buildFPToUI*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFPToUI", dynlib: LLVMlib.}
# proc buildFPToSI*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFPToSI", dynlib: LLVMlib.}
# proc buildUIToFP*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildUIToFP", dynlib: LLVMlib.}
# proc buildSIToFP*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSIToFP", dynlib: LLVMlib.}
# proc buildFPTrunc*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFPTrunc", dynlib: LLVMlib.}
# proc buildFPExt*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFPExt", dynlib: LLVMlib.}
# proc buildPtrToInt*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildPtrToInt", dynlib: LLVMlib.}
# proc buildIntToPtr*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildIntToPtr", dynlib: LLVMlib.}
# proc buildBitCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildBitCast", dynlib: LLVMlib.}
proc bitcast*(self: Builder, val: Value, destTy: Type, name: string = ""): Instruction =
    ##  Zero-extend integer value to integer type *destTy*.
    ## 
    ##  Wrapping:
    ##  * `buildBitCast(BuilderRef, ValueRef, TypeRef, cstring)<../llvm/Core.html#buildBitCast,BuilderRef,ValueRef,TypeRef,cstring>`_
    newValue[Instruction](buildBitCast(self.builder, val.value, destTy.typ, name))
# proc buildAddrSpaceCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildAddrSpaceCast", dynlib: LLVMlib.}
# proc buildZExtOrBitCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildZExtOrBitCast", dynlib: LLVMlib.}
# proc buildSExtOrBitCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildSExtOrBitCast", dynlib: LLVMlib.}
# proc buildTruncOrBitCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildTruncOrBitCast", dynlib: LLVMlib.}
# proc buildCast*(b: BuilderRef; op: Opcode; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildCast", dynlib: LLVMlib.}
# proc buildPointerCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildPointerCast", dynlib: LLVMlib.}
# proc buildIntCast2*(a1: BuilderRef; val: ValueRef; destTy: TypeRef; isSigned: Bool;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildIntCast2", dynlib: LLVMlib.}
# proc buildFPCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildFPCast", dynlib: LLVMlib.}

# proc buildIntCast*(a1: BuilderRef; val: ValueRef; destTy: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildIntCast", dynlib: LLVMlib.}
#     ## * Deprecated: This cast is always signed. Use LLVMBuildIntCast2 instead.
#     ## Signed cast!

# ##  Comparisons
# proc buildICmp*(a1: BuilderRef; op: IntPredicate; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildICmp", dynlib: LLVMlib.}
proc isTrue*(self: Builder, val: Value, name: string = ""): Instruction =
    newValue[Instruction](self.builder.buildICmp(IntNE, val.value, int1Type().constInt(0, false), name))
# proc buildFCmp*(a1: BuilderRef; op: RealPredicate; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildFCmp", dynlib: LLVMlib.}

# proc buildPhi*(a1: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildPhi", dynlib: LLVMlib.}
#     ##  Miscellaneous instructions
proc phi*(self: Builder; ty: Type; name: string): Instruction =
    newValue[Instruction](self.builder.buildPhi(ty.typ, name))


# proc buildCall*(a1: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildCall", dynlib: LLVMlib.}
#     ##  LLVMBuildCall is deprecated in favor of LLVMBuildCall2, in preparation for
#     ##  opaque pointer types.

proc call*(self: Builder, fn: Value, args: openArray[Value], name: string = ""): Value =
    ##  Wrapping:
    ##  * `buildCall(BuilderRef, ValueRef, ptr ValueRef, cstring)<../llvm/Core.html#buildCall,BuilderRef,ValueRef,ptr.ValueRef,cstring>`_
    var
        s = args.map(proc(a: Value): ValueRef = a.value)
        adr = if s.len > 0: s[0].addr else: nil
    newValue[Instruction](self.builder.buildCall(fn.value, adr, cuint s.len, name))

proc call2*(self: Builder, rtype: Type, fn: Value, args: openArray[Value], name: string = ""): Value =
    ##  Wrapping:
    ##  * `buildCall2(BuilderRef, TypeRef, ValueRef, ptr ValueRef, cstring)<../llvm/Core.html#buildCall2,BuilderRef,TypeRef,ValueRef,ptr.ValueRef,cstring>`_
    var
        s = args.map(proc(a: Value): ValueRef = a.value)
        adr = if s.len > 0: s[0].addr else: nil
    newValue[Instruction](self.builder.buildCall2(rtype.typ, fn.value, adr, cuint s.len, name))

# proc buildSelect*(a1: BuilderRef; `if`: ValueRef; then: ValueRef; `else`: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildSelect", dynlib: LLVMlib.}
# proc buildVAArg*(a1: BuilderRef; list: ValueRef; ty: TypeRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildVAArg", dynlib: LLVMlib.}
# proc buildExtractElement*(a1: BuilderRef; vecVal: ValueRef; index: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildExtractElement", dynlib: LLVMlib.}
# proc buildInsertElement*(a1: BuilderRef; vecVal: ValueRef; eltVal: ValueRef;index: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildInsertElement", dynlib: LLVMlib.}
# proc buildShuffleVector*(a1: BuilderRef; v1: ValueRef; v2: ValueRef; mask: ValueRef;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildShuffleVector", dynlib: LLVMlib.}
# proc buildExtractValue*(a1: BuilderRef; aggVal: ValueRef; index: cuint;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildExtractValue", dynlib: LLVMlib.}
proc extractvalue*(self: Builder, aggVal: Value, index: int, name: string = ""): Instruction =
    ##  Wrapping:
    ##  * `buildExtractValue(BuilderRef, ValueRef, cuint, cstring)<../llvm/Core.html#buildExtractValue,BuilderRef,ValueRef,cuint,cstring>`_
    newValue[Instruction](self.builder.buildExtractValue(aggVal.value, cuint index, name))
proc insertvalue*(self: Builder, aggVal: Value, eltVal: Value, index: int, name: string = ""): Instruction =
    ##  Wrapping:
    ##  * `buildInsertValue(BuilderRef, ValueRef, ValueRef, cuint, cstring)<../llvm/Core.html#buildInsertValue,BuilderRef,ValueRef,ValueRef,cuint,cstring>`_
    newValue[Instruction](self.builder.buildInsertValue(aggVal.value, eltVal.value, cuint index, name))
# proc buildFreeze*(a1: BuilderRef; val: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildFreeze", dynlib: LLVMlib.}
# proc buildIsNull*(a1: BuilderRef; val: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildIsNull", dynlib: LLVMlib.}
# proc buildIsNotNull*(a1: BuilderRef; val: ValueRef; name: cstring): ValueRef {.cdecl, importc: "LLVMBuildIsNotNull", dynlib: LLVMlib.}
# proc buildPtrDiff*(a1: BuilderRef; lhs: ValueRef; rhs: ValueRef;name: cstring): ValueRef {. cdecl, importc: "LLVMBuildPtrDiff", dynlib: LLVMlib.}
# proc buildFence*(b: BuilderRef; ordering: AtomicOrdering; singleThread: Bool;name: cstring): ValueRef {.cdecl, importc: "LLVMBuildFence", dynlib: LLVMlib.}
# proc buildAtomicRMW*(b: BuilderRef; op: AtomicRMWBinOp; `ptr`: ValueRef; val: ValueRef;ordering: AtomicOrdering; singleThread: Bool): ValueRef {.cdecl, importc: "LLVMBuildAtomicRMW", dynlib: LLVMlib.}
# proc buildAtomicCmpXchg*(b: BuilderRef; `ptr`: ValueRef; cmp: ValueRef; new: ValueRef;successOrdering: AtomicOrdering;failureOrdering: AtomicOrdering;singleThread: Bool): ValueRef {. cdecl, importc: "LLVMBuildAtomicCmpXchg", dynlib: LLVMlib.}
# proc isAtomicSingleThread*(atomicInst: ValueRef): Bool {.cdecl, importc: "LLVMIsAtomicSingleThread", dynlib: LLVMlib.}
# proc setAtomicSingleThread*(atomicInst: ValueRef; singleThread: Bool) {.cdecl, importc: "LLVMSetAtomicSingleThread", dynlib: LLVMlib.}
# proc getCmpXchgSuccessOrdering*(cmpXchgInst: ValueRef): AtomicOrdering {.cdecl, importc: "LLVMGetCmpXchgSuccessOrdering", dynlib: LLVMlib.}
# proc setCmpXchgSuccessOrdering*(cmpXchgInst: ValueRef;ordering: AtomicOrdering) {. cdecl, importc: "LLVMSetCmpXchgSuccessOrdering", dynlib: LLVMlib.}
# proc getCmpXchgFailureOrdering*(cmpXchgInst: ValueRef): AtomicOrdering {.cdecl, importc: "LLVMGetCmpXchgFailureOrdering", dynlib: LLVMlib.}
# proc setCmpXchgFailureOrdering*(cmpXchgInst: ValueRef;ordering: AtomicOrdering) {. cdecl, importc: "LLVMSetCmpXchgFailureOrdering", dynlib: LLVMlib.}
# proc createModuleProviderForExistingModule*(m: ModuleRef): ModuleProviderRef {.cdecl, importc: "LLVMCreateModuleProviderForExistingModule", dynlib: LLVMlib.}
#     ##  Changes the type of M so it can be passed to FunctionPassManagers and the
#     ##  JIT.  They take ModuleProviders for historical reasons.

# proc disposeModuleProvider*(m: ModuleProviderRef) {.cdecl, importc: "LLVMDisposeModuleProvider", dynlib: LLVMlib.}
#     ##  Destroys the module M.

# proc createMemoryBufferWithContentsOfFile*(path: cstring;outMemBuf: ptr MemoryBufferRef; outMessage: cstringArray): Bool {.cdecl, importc: "LLVMCreateMemoryBufferWithContentsOfFile", dynlib: LLVMlib.}
# proc createMemoryBufferWithSTDIN*(outMemBuf: ptr MemoryBufferRef;outMessage: cstringArray): Bool {.cdecl, importc: "LLVMCreateMemoryBufferWithSTDIN", dynlib: LLVMlib.}
# proc createMemoryBufferWithMemoryRange*(inputData: cstring; inputDataLength: csize_t;bufferName: cstring;requiresNullTerminator: Bool): MemoryBufferRef {. cdecl, importc: "LLVMCreateMemoryBufferWithMemoryRange", dynlib: LLVMlib.}
proc createMemoryBufferWithMemoryRange*(inputdata: string, bufferName: string): MemoryBufferRef =
    let a = cstring inputdata
    createMemoryBufferWithMemoryRange(a, csize_t a.len, bufferName, false)
# proc createMemoryBufferWithMemoryRangeCopy*(inputData: cstring;inputDataLength: csize_t; bufferName: cstring): MemoryBufferRef {.cdecl, importc: "LLVMCreateMemoryBufferWithMemoryRangeCopy", dynlib: LLVMlib.}
# proc getBufferStart*(memBuf: MemoryBufferRef): cstring {.cdecl, importc: "LLVMGetBufferStart", dynlib: LLVMlib.}
# proc getBufferSize*(memBuf: MemoryBufferRef): csize_t {.cdecl, importc: "LLVMGetBufferSize", dynlib: LLVMlib.}
# proc disposeMemoryBuffer*(memBuf: MemoryBufferRef) {.cdecl, importc: "LLVMDisposeMemoryBuffer", dynlib: LLVMlib.}
# proc getGlobalPassRegistry*(): PassRegistryRef {.cdecl, importc: "LLVMGetGlobalPassRegistry", dynlib: LLVMlib.}
#     ## * Return the global pass registry, for use with initialization functions.
#     ##     @see llvm::PassRegistry::getPassRegistry


# proc createPassManager*(): PassManagerRef {.cdecl, importc: "LLVMCreatePassManager", dynlib: LLVMlib.}
#     ## * Constructs a new whole-module pass pipeline. This type of pipeline is
#     ##     suitable for link-time optimization and whole-module transformations.
#     ##     @see llvm::PassManager::PassManager


# proc createFunctionPassManagerForModule*(m: ModuleRef): PassManagerRef {.cdecl, importc: "LLVMCreateFunctionPassManagerForModule", dynlib: LLVMlib.}
#     ## * Constructs a new function-by-function pass pipeline over the module
#     ##     provider. It does not take ownership of the module provider. This type of
#     ##     pipeline is suitable for code generation and JIT compilation tasks.
#     ##     @see llvm::FunctionPassManager::FunctionPassManager

# proc createFunctionPassManager*(mp: ModuleProviderRef): PassManagerRef {.cdecl, importc: "LLVMCreateFunctionPassManager", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMCreateFunctionPassManagerForModule instead.

# proc runPassManager*(pm: PassManagerRef; m: ModuleRef): Bool {.cdecl, importc: "LLVMRunPassManager", dynlib: LLVMlib.}
#     ## * Initializes, executes on the provided module, and finalizes all of the
#     ##     passes scheduled in the pass manager. Returns 1 if any of the passes
#     ##     modified the module, 0 otherwise.
#     ##     @see llvm::PassManager::run(Module&)

# proc initializeFunctionPassManager*(fpm: PassManagerRef): Bool {.cdecl, importc: "LLVMInitializeFunctionPassManager", dynlib: LLVMlib.}
#     ## * Initializes all of the function passes scheduled in the function pass
#     ##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
#     ##     @see llvm::FunctionPassManager::doInitialization

# proc runFunctionPassManager*(fpm: PassManagerRef; f: ValueRef): Bool {.cdecl, importc: "LLVMRunFunctionPassManager", dynlib: LLVMlib.}
#     ## * Executes all of the function passes scheduled in the function pass manager
#     ##     on the provided function. Returns 1 if any of the passes modified the
#     ##     function, false otherwise.
#     ##     @see llvm::FunctionPassManager::run(Function&)

# proc finalizeFunctionPassManager*(fpm: PassManagerRef): Bool {.cdecl, importc: "LLVMFinalizeFunctionPassManager", dynlib: LLVMlib.}
#     ## * Finalizes all of the function passes scheduled in the function pass
#     ##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
#     ##     @see llvm::FunctionPassManager::doFinalization

# proc disposePassManager*(pm: PassManagerRef) {.cdecl, importc: "LLVMDisposePassManager", dynlib: LLVMlib.}
#     ## * Frees the memory of a pass pipeline. For function pipelines, does not free
#     ##     the module provider.
#     ##     @see llvm::PassManagerBase::~PassManagerBase.


# ##  Handle the structures needed to make LLVM safe for multithreading.

# proc startMultithreaded*(): Bool {.cdecl, importc: "LLVMStartMultithreaded", dynlib: LLVMlib.}
#     ## * Deprecated: Multi-threading can only be enabled/disabled with the compile
#     ##     time define LLVM_ENABLE_THREADS.  This function always returns
#     ##     LLVMIsMultithreaded().

# proc stopMultithreaded*() {.cdecl, importc: "LLVMStopMultithreaded", dynlib: LLVMlib.}
#     ## * Deprecated: Multi-threading can only be enabled/disabled with the compile
#     ##     time define LLVM_ENABLE_THREADS.

# proc isMultithreaded*(): Bool {.cdecl, importc: "LLVMIsMultithreaded", dynlib: LLVMlib.}
#     ## * Check whether LLVM is executing in thread-safe mode or not.
#     ##     @see llvm::llvm_is_multithreaded

