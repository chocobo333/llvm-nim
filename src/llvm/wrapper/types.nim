
##  This exposes some types about LLVM.


import ../raw


type
    ContextObj* = object
        context*: ContextRef

    ModuleObj* = object
        ##  Modules represent the top-level structure in an LLVM program. An LLVM
        ##  module is effectively a translation unit or a collection of
        ##  translation units merged together.
        module*: ModuleRef
        context*: ref ContextObj

    TypeObj* = object of RootObj
        ##  Each value in the LLVM IR has a type, an LLVMTypeRef.
        ## 
        ##  Types represent the type of a value.
        ##
        ##  Types are associated with a context instance. The context internally
        ##  deduplicates types so there is only 1 instance of a specific type
        ##  alive at a time. In other words, a unique type is shared among all
        ##  consumers within a context.
        ##
        ##  A Type in the C API corresponds to llvm::Type.
        ##
        ##  Types have the following hierarchy:
        ##
        ##  types:
        ##      integer type
        ## 
        ##      real type
        ## 
        ##      function type
        ## 
        ##      sequence types:
        ##          array type
        ## 
        ##          pointer type
        ## 
        ##          vector type
        ##      void type
        ## 
        ##      label type
        ## 
        ##      opaque type
        typ*: TypeRef
        kind*: TypeKind

    ValueObj* = object of RootObj
        ##  Represents an individual value in LLVM IR.
        ## 
        ##  The bulk of LLVM's object model consists of values, which comprise a very
        ##  rich type hierarchy.
        ##
        ##  LLVMValueRef essentially represents llvm::Value. There is a rich
        ##  hierarchy of classes within this type. Depending on the instance
        ##  obtained, not all APIs are available.
        ##
        ##  Callers can determine the type of an LLVMValueRef by calling the
        ##  LLVMIsA* family of functions (e.g. LLVMIsAArgument()). These
        ##  functions are defined by a macro, so it isn't obvious which are
        ##  available by looking at the Doxygen source code. Instead, look at the
        ##  source definition of LLVM_FOR_EACH_VALUE_SUBCLASS and note the list
        ##  of value names given. These value names also correspond to classes in
        ##  the llvm::Value hierarchy.
        ## 
        ##  Functions in this section work on all LLVMValueRef instances,
        ##  regardless of their sub-type. They correspond to functions available
        ##  on llvm::Value.
        value*: ValueRef
        kind*: ValueKind

    BasicBlockObj* = object
        ##  A basic block represents a single entry single exit section of code.
        ##  Basic blocks contain a list of instructions which form the body of
        ##  the block.
        ##
        ##  Basic blocks belong to functions. They have the type of label.
        ##
        ##  Basic blocks are themselves values. However, the C API models them as
        ##  LLVMBasicBlockRef.
        bb*: BasicBlockRef
    BuilderObj* = object
        builder*: BuilderRef

# REGION: TypeDefs

type
    Context* = ref ContextObj
        ##  The top-level container for all LLVM global data. See the LLVMContext class.
        ## 
        ##  See also:
        ##  * `newContext()<#newContext>`_
        ##  * `globalContext()<#globalContext>`_

    Module* = ref ModuleObj
        ##  Modules represent the top-level structure in an LLVM program. An LLVM
        ##  module is effectively a translation unit or a collection of
        ##  translation units merged together.
        ## 
        ##  See also:
        ##  * `newModule(string, Context) <#newModule,string,Context>`_
        ##  * `newModule(Module) <#newModule,Module>`_

    Type* = ref TypeObj
        ##  Each value in the LLVM IR has a type, an LLVMTypeRef.
        ## 
        ##  Types represent the type of a value.
        ##
        ##  Types are associated with a context instance. The context internally
        ##  deduplicates types so there is only 1 instance of a specific type
        ##  alive at a time. In other words, a unique type is shared among all
        ##  consumers within a context.
        ##
        ##  A Type in the C API corresponds to llvm::Type.
        ##
        ##  Types have the following hierarchy:
        ##
        ##  types:
        ##      integer type
        ## 
        ##      real type
        ## 
        ##      function type
        ## 
        ##      sequence types:
        ##          array type
        ## 
        ##          pointer type
        ## 
        ##          vector type
        ##      void type
        ## 
        ##      label type
        ## 
        ##      opaque type
    VoidType* = ref object of TypeObj
    HalfType* = ref object of TypeObj
    FloatType* = ref object of TypeObj
    DoubleType* = ref object of TypeObj
    X86FP80Type* = ref object of TypeObj
    FP128Type* = ref object of TypeObj
    PPC_FP128Type* = ref object of TypeObj
    LabelType* = ref object of TypeObj
    IntegerType* = ref object of TypeObj
    FunctionType* = ref object of TypeObj
    StructType* = ref object of TypeObj
    ArrayType* = ref object of TypeObj
    PointerType* = ref object of TypeObj
    VectorType* = ref object of TypeObj
    MetadataType* = ref object of TypeObj
    X86MMXType* = ref object of TypeObj
    TokenType* = ref object of TypeObj

    Value* = ref ValueObj
        ##  Represents an individual value in LLVM IR.
        ## 
        ##  The bulk of LLVM's object model consists of values, which comprise a very
        ##  rich type hierarchy.
        ##
        ##  LLVMValueRef essentially represents llvm::Value. There is a rich
        ##  hierarchy of classes within this type. Depending on the instance
        ##  obtained, not all APIs are available.
        ##
        ##  Callers can determine the type of an LLVMValueRef by calling the
        ##  LLVMIsA* family of functions (e.g. LLVMIsAArgument()). These
        ##  functions are defined by a macro, so it isn't obvious which are
        ##  available by looking at the Doxygen source code. Instead, look at the
        ##  source definition of LLVM_FOR_EACH_VALUE_SUBCLASS and note the list
        ##  of value names given. These value names also correspond to classes in
        ##  the llvm::Value hierarchy.
    # ArgumentValueKind
    # BasicBlockValueKind
    # MemoryUseValueKind
    # MemoryDefValueKind
    # MemoryPhiValueKind
    FunctionValue* = ref object of ValueObj
    # GlobalAliasValueKind
    # GlobalIFuncValueKind
    GlobalVariable* = ref object of ValueObj
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
    Instruction* = ref object of ValueObj
    
    BasicBlock* = ref BasicBlockObj
        ##  A basic block represents a single entry single exit section of code.
        ##  Basic blocks contain a list of instructions which form the body of
        ##  the block.
        ##
        ##  Basic blocks belong to functions. They have the type of label.
        ##
        ##  Basic blocks are themselves values. However, the C API models them as
        ##  LLVMBasicBlockRef.
    Builder* = ref BuilderObj

proc finalizer(self: Context) =
    ##  Finalizer a `Context` instance.
    ## 
    ##  This should be called for every call to `newContext`() or memory
    ##  will be leaked.
    ##  but, will be automatically called by runtime gc.
    if self.context.isNil:
        return
    self.context.contextDispose()

proc finalizer(self: Module) =
    ##  Finalize a `Module` instance.
    ## 
    ##  This should be called for every call to `newModule`() or memory
    ##  will be leaked.
    ##  but, will be automatically called by runtime gc.
    if self.module.isNil:
        return
    self.module.disposeModule()

proc finalizer(self: Builder) =
    ##  Finalize a `Builder` instance.
    ## 
    ##  This should be called for every call to `newModule`() or memory
    ##  will be leaked.
    ##  but, will be automatically called by runtime gc.
    if self.builder.isNil:
        return
    self.builder.disposeBuilder()

proc newContext*(cxt: ContextRef): Context =
    new[ContextObj](result, finalizer)
    result.context = cxt
    
proc newModule*(module: ModuleRef): Module =
    ## Helper
    new(result, finalizer)
    result.module = module
    result.context = newContext(module.getModuleContext())

type
    Ty = concept T
        T of Type
    Val = concept T
        T of Value

proc newType*[T: Ty](typ: TypeRef): T =
    ## Helper
    new(result)
    result.typ = typ
    result.kind = typ.getTypeKind()

proc newValue*[T: Val](value: ValueRef): T =
    ## Helper
    new(result)
    result.value = value
    result.kind = value.getValueKind()

proc newBB*(bb: BasicBlockRef): BasicBlock =
    ## Helper
    new(result)
    result.bb = bb

proc newBuilder*(builder: BuilderRef): Builder =
    new(result, finalizer)
    result.builder = builder


converter toLLVMBool*(self: bool): Bool =
    if self:
        1
    else:
        0

converter toNimBool*(self: Bool): bool =
    if self == 0:
        false
    else:
        true