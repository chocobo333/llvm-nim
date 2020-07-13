
import ../raw

import
    types,
    context

import sequtils


type
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

proc isSized(self: Type): bool =
    ##  Whether the type has a known size.
    ##
    ##  Things that don't have a size are abstract types, labels, and void.a
    ##  Wrapping:
    ##  * `typeIsSized(TypeRef)<../llvm/Core.html#typeIsSized,TypeRef>`_
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


# ##  Obtain an integer type from the global context with a specified bit
# ##  width.
# proc int1Type*(): TypeRef {.cdecl, importc: "LLVMInt1Type", dynlib: LLVMlib.}
# proc int8Type*(): TypeRef {.cdecl, importc: "LLVMInt8Type", dynlib: LLVMlib.}
# proc int16Type*(): TypeRef {.cdecl, importc: "LLVMInt16Type", dynlib: LLVMlib.}
# proc int32Type*(): TypeRef {.cdecl, importc: "LLVMInt32Type", dynlib: LLVMlib.}
# proc int64Type*(): TypeRef {.cdecl, importc: "LLVMInt64Type", dynlib: LLVMlib.}
# proc int128Type*(): TypeRef {.cdecl, importc: "LLVMInt128Type", dynlib: LLVMlib.}
# proc intType*(numBits: cuint): TypeRef {.cdecl, importc: "LLVMIntType", dynlib: LLVMlib.}
# proc getIntTypeWidth*(integerTy: TypeRef): cuint {.cdecl, importc: "LLVMGetIntTypeWidth", dynlib: LLVMlib.}


# proc halfTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMHalfTypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 16-bit floating point type from a context.

# proc floatTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMFloatTypeInContext", dynlib: LLVMlib.}
#     ##  Obtain a 32-bit floating point type from a context.

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

proc functionType*(retTy: Type, paramTypes: openArray[Type], isVarArg: bool = false): Type =
    ##  Obtain a function type consisting of a specified signature.
    ##
    ##  The function is defined as a tuple of a return Type, a list of
    ##  parameter types, and whether the function is variadic.
    ## 
    ##  Wrapping:
    ##  * `functionType(TypeRef, ptr TypeRef, cuint, Bool)<../llvm/Core.html#functionType,TypeRef,ptr.TypeRef,cuint,Bool>`_
    runnableExamples:
        var
            fnty = functionType(voidType(), @[intType(64), intType(32)])

        assert $fnty == "void (i64, i32)"
    runnableExamples:
        var
            fnty = functionType(intType(32), @[])

        assert $fnty == "i32 ()"
    var
        s = paramTypes.map(proc(a: Type): TypeRef = a.typ)
        adr = if s.len > 0: s[0].addr else: nil
    newType(functionType(retTy.typ, adr, cuint s.len, isVarArg))

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
# proc structTypeInContext*(c: ContextRef; elementTypes: ptr TypeRef;elementCount: cuint; packed: Bool): TypeRef {.cdecl, importc: "LLVMStructTypeInContext", dynlib: LLVMlib.}
#     ##  Create a new structure type in a context.
#     ##
#     ##  A structure is specified by a list of inner elements/types and
#     ##  whether these can be packed together.
#     ##
#     ##  @see llvm::StructType::create()

# proc structType*(elementTypes: ptr TypeRef; elementCount: cuint;packed: Bool): TypeRef {. cdecl, importc: "LLVMStructType", dynlib: LLVMlib.}
#     ##  Create a new structure type in the global context.
#     ##
#     ##  @see llvm::StructType::create()

# proc structCreateNamed*(c: ContextRef; name: cstring): TypeRef {.cdecl, importc: "LLVMStructCreateNamed", dynlib: LLVMlib.}
# ##  Create an empty structure in a context having a specified name.
# ##
# ##  @see llvm::StructType::create()

# proc getStructName*(ty: TypeRef): cstring {.cdecl, importc: "LLVMGetStructName", dynlib: LLVMlib.}
#     ##  Obtain the name of a structure.
#     ##
#     ##  @see llvm::StructType::getName()

# proc structSetBody*(structTy: TypeRef; elementTypes: ptr TypeRef; elementCount: cuint;packed: Bool) {.cdecl, importc: "LLVMStructSetBody", dynlib: LLVMlib.}
#     ##  Set the contents of a structure type.
#     ##
#     ##  @see llvm::StructType::setBody()

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

# proc voidTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMVoidTypeInContext", dynlib: LLVMlib.}
#     ##  Create a void type in a context.

# proc labelTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMLabelTypeInContext", dynlib: LLVMlib.}
#     ##  Create a label type in a context.

# proc x86MMXTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMX86MMXTypeInContext", dynlib: LLVMlib.}
#     ##  Create a X86 MMX type in a context.

# proc tokenTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMTokenTypeInContext", dynlib: LLVMlib.}
#     ##  Create a token type in a context.

# proc metadataTypeInContext*(c: ContextRef): TypeRef {.cdecl, importc: "LLVMMetadataTypeInContext", dynlib: LLVMlib.}
#     ##  Create a metadata type in a context.

# ##  These are similar to the above functions except they operate on the
# ##  global context.

proc voidType*(): Type =
    ##  Create a void type in the global context.
    ## 
    ##  Wrapping:
    ##  * `voidType()<../llvm/Core.html#voidType>`_
    runnableExamples:
        var
            llVoid = voidType()

        assert $llVoid == "void"
    newType(raw.voidType())

# proc labelType*(): TypeRef {.cdecl, importc: "LLVMLabelType", dynlib: LLVMlib.}
# proc x86MMXType*(): TypeRef {.cdecl, importc: "LLVMX86MMXType", dynlib: LLVMlib.}

proc intType*(nbits: uint): Type =
    ##  Obtain an integer type from the global context with a specified bit
    ##  width.
    ## 
    ##  Wrapping:
    ##  * `intType(cuint)<../llvm/Core.html#intType,cuint>`_
    runnableExamples:
        var
            llInt = intType(113)

        assert $llInt == "i113"
    newType(intType(cuint nbits))