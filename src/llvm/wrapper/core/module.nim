
##  This provides wrapped method about `LLVMModuleRef`.

import ../raw

import
    types,
    context,
    type,
    value


type
    Module* = ref ModuleObj
        ##  Modules represent the top-level structure in an LLVM program. An LLVM
        ##  module is effectively a translation unit or a collection of
        ##  translation units merged together.
        ## 
        ##  See also:
        ##  * `newModule(string, Context) <#newModule,string,Context>`_
        ##  * `newModule(Module) <#newModule,Module>`_

proc finalizer(self: Module) =
    ##  Finalize a `Module` instance.
    ## 
    ##  This should be called for every call to `newModule`() or memory
    ##  will be leaked.
    ##  but, will be automatically called by runtime gc.
    if self.module.isNil:
        return
    self.module.disposeModule()

proc newModule*(name: string, cxt: Context = nil): Module =
    ##  Create a new, empty module in a specific context.
    ##
    ##  If `cxt` is **nil**, created module consists in the global cnotext.
    ##
    ##  This is equivalent to calling ``newModule(name, getGlobalContext())``
    ##
    ##  Wrapping:
    ##  * `moduleCreateWithName(cstring)<../llvm/Core.html#moduleCreateWithName,cstring>`_
    ##  * `moduleCreateWithNameInContext(cstring, ContextRef)<../llvm/Core.html#moduleCreateWithNameInContext,cstring,ContextRef>`_
    new[ModuleObj](result, finalizer)
    result.module = if cxt.isNil:
        moduleCreateWithName(name)
    else:
        moduleCreateWithNameInContext(name, cxt.context)

proc clone*(self: Module): Module =
    ##  Return an exact copy of the specified module.
    ##  
    ##  See also:
    ##  * `newModule(string, Context)<#newModule,string,Context>`_
    ##  
    ##  Wrapping:
    ##  * `cloneModule(ModuleRef)<../llvm/Core.html#cloneModule,ModuleRef>`_
    new[ModuleObj](result, finalizer)
    result.module = cloneModule(self.module)

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

# proc getModuleContext*(m: ModuleRef): ContextRef {.cdecl, importc: "LLVMGetModuleContext", dynlib: LLVMlib.}
#     ##  Obtain the context to which this module is associated.
#     ##
#     ##  @see Module::getContext()

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

proc addFunction*(self: Module, name: string, fnty: Type): Value =
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

    newValue(self.module.addFunction(name, fnty.typ))

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

# proc getLastFunction*(m: ModuleRef): ValueRef {.cdecl, importc: "LLVMGetLastFunction", dynlib: LLVMlib.}
#     ##  Obtain an iterator to the last Function in a Module.
#     ##
#     ##  @see llvm::Module::end()

# proc getNextFunction*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetNextFunction", dynlib: LLVMlib.}
#     ##  Advance a Function iterator to the next Function.
#     ##
#     ##  Returns NULL if the iterator was already at the end and there are no more
#     ##  functions.

# proc getPreviousFunction*(fn: ValueRef): ValueRef {.cdecl, importc: "LLVMGetPreviousFunction", dynlib: LLVMlib.}
#     ##  Decrement a Function iterator to the previous Function.
#     ##
#     ##  Returns NULL if the iterator was already at the beginning and there are
#     ##  no previous functions.

# proc setModuleInlineAsm*(m: ModuleRef; `asm`: cstring) {.cdecl, importc: "LLVMSetModuleInlineAsm", dynlib: LLVMlib.}
#     ## * Deprecated: Use LLVMSetModuleInlineAsm2 instead.
