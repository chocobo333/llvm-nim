
import ../raw


##  A basic block represents a single entry single exit section of code.
##  Basic blocks contain a list of instructions which form the body of
##  the block.
##
##  Basic blocks belong to functions. They have the type of label.
##
##  Basic blocks are themselves values. However, the C API models them as
##  LLVMBasicBlockRef.
##
##  @see llvm::BasicBlock


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
#     ##  Append the given basic block to the basic block list of the given function.
#     ##
#     ##  @see llvm::Function::BasicBlockListType::push_back()

# proc createBasicBlockInContext*(c: ContextRef; name: cstring): BasicBlockRef {.cdecl, importc: "LLVMCreateBasicBlockInContext", dynlib: LLVMlib.}
#     ##  Create a new basic block without inserting it into a function.
#     ##
#     ##  @see llvm::BasicBlock::Create()

# proc appendBasicBlockInContext*(c: ContextRef; fn: ValueRef;name: cstring): BasicBlockRef {. cdecl, importc: "LLVMAppendBasicBlockInContext", dynlib: LLVMlib.}
#     ##  Append a basic block to the end of a function.
#     ##
#     ##  @see llvm::BasicBlock::Create()

# proc appendBasicBlock*(fn: ValueRef; name: cstring): BasicBlockRef {.cdecl, importc: "LLVMAppendBasicBlock", dynlib: LLVMlib.}
#     ##  Append a basic block to the end of a function using the global
#     ##  context.
#     ##
#     ##  @see llvm::BasicBlock::Create()

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