
import ../raw

import
    types,
    type

type
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
        ## 
        ##  Functions in this section work on all LLVMValueRef instances,
        ##  regardless of their sub-type. They correspond to functions available
        ##  on llvm::Value.

export ValueKind


proc typ*(self: Value): Type =
    ##  Obtain the type of a value.
    ## 
    ##  Wrapping:
    ##  * `typeOfX(ValueRef)<../llvm/Core.html#typeOfX,ValueRef>`_
    newType(self.value.typeOfX())

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
# proc constInt*(intTy: TypeRef; n: culonglong; signExtend: Bool): ValueRef {.cdecl, importc: "LLVMConstInt", dynlib: LLVMlib.}
#     ##  Obtain a constant value for an integer type.
#     ##
#     ##  The returned value corresponds to a llvm::ConstantInt.
#     ##
#     ##  @see llvm::ConstantInt::get()
#     ##
#     ##  @param IntTy Integer type to obtain value of.
#     ##  @param N The value the returned instance should refer to.
#     ##  @param SignExtend Whether to sign extend the produced value.

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

# proc getElementAsConstant*(c: ValueRef; idx: cuint): ValueRef {.cdecl, importc: "LLVMGetElementAsConstant", dynlib: LLVMlib.}
#     ##  Get an element at specified index as a constant.
#     ##
#     ##  @see ConstantDataSequential::getElementAsConstant()

# proc constVector*(scalarConstantVals: ptr ValueRef; size: cuint): ValueRef {.cdecl, importc: "LLVMConstVector", dynlib: LLVMlib.}
#     ##  Create a ConstantVector from values.
#     ##
#     ##  @see llvm::ConstantVector::get()
