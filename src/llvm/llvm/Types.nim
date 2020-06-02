# ===-- llvm-c/Support.h - C Interface Types declarations ---------*- C -*-===*\
# |*                                                                            *|
# |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
# |* Exceptions.                                                                *|
# |* See https://llvm.org/LICENSE.txt for license information.                  *|
# |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
# |*                                                                            *|
# |*===----------------------------------------------------------------------===*|
# |*                                                                            *|
# |* This file defines types used by the C interface to LLVM.                   *|
# |*                                                                            *|
# \*===----------------------------------------------------------------------===

##  Opaque types.
##  LLVM uses a polymorphic type hierarchy which C cannot represent, therefore
##  parameters must be passed as base types. Despite the declared types, most
##  of the functions provided operate only on branches of the type hierarchy.
##  The declared parameter names are descriptive and specify which type is
##  required. Additionally, each type hierarchy is documented along with the
##  functions that operate upon it. For more detail, refer to LLVM's C++ code.
##  If in doubt, refer to Core.cpp, which performs parameter downcasts in the
##  form unwrap<RequiredType>(Param).

import prelude/opaques


type
    Bool* = cint
        ## Represents c bool(int).

    MemoryBufferRef* = ptr OpaqueMemoryBuffer
        ##  Used to pass regions of memory through LLVM interfaces.
        ##
        ##  @see llvm::MemoryBuffer

    ContextRef* = ptr OpaqueContext
        ##  The top-level container for all LLVM global data. See the LLVMContext class.

    ModuleRef* = ptr OpaqueModule
        ##  The top-level container for all other LLVM Intermediate Representation (IR)
        ##  objects.
        ##
        ##  @see llvm::Module

type

    TypeRef* = ptr OpaqueType
        ##  Each value in the LLVM IR has a type, an LLVMTypeRef.
        ##
        ##  @see llvm::Type

    ValueRef* = ptr OpaqueValue
        ##  Represents an individual value in LLVM IR.
        ##
        ##  This models llvm::Value.

    BasicBlockRef* = ptr OpaqueBasicBlock
        ##  Represents a basic block of instructions in LLVM IR.
        ##
        ##  This models llvm::BasicBlock.
        ##  A basic block represents a single entry single exit section of code.
        ## 
        ##  Basic blocks contain a list of instructions which form the body of
        ##  the block.
        ##
        ##  Basic blocks belong to functions. They have the type of label.
        ##
        ##  Basic blocks are themselves values. However, the C API models them as
        ##  LLVMBasicBlockRef.
        ##
        ##  @see llvm::BasicBlock

    MetadataRef* = ptr OpaqueMetadata
        ##  Represents an LLVM Metadata.
        ##
        ##  This models llvm::Metadata.

    NamedMDNodeRef* = ptr OpaqueNamedMDNode
        ##  Represents an LLVM Named Metadata Node.
        ##
        ##  This models llvm::NamedMDNode.

    ValueMetadataEntry* = OpaqueValueMetadataEntry
        ##  Represents an entry in a Global Object's metadata attachments.
        ##
        ##  This models std::pair<unsigned, MDNode ptr>

    BuilderRef* = ptr OpaqueBuilder
        ##  Represents an LLVM basic block builder.
        ##
        ##  This models llvm::IRBuilder.

    DIBuilderRef* = ptr OpaqueDIBuilder
        ##  Represents an LLVM debug info builder.
        ##
        ##  This models llvm::DIBuilder.

    ModuleProviderRef* = ptr OpaqueModuleProvider
        ##  Interface used to provide a module to JIT or interpreter.
        ##  This is now just a synonym for llvm::Module, but we have to keep using the
        ##  different type to keep binary compatibility.

    PassManagerRef* = ptr OpaquePassManager
        ## * @see llvm::PassManagerBase

    PassRegistryRef* = ptr OpaquePassRegistry
        ## * @see llvm::PassRegistry

    UseRef* = ptr OpaqueUse
        ##  Used to get the users and usees of a Value.
        ##
        ##  @see llvm::Use

    AttributeRef* = ptr OpaqueAttributeRef
        ##  Used to represent an attributes.
        ##
        ##  @see llvm::Attribute
    DiagnosticInfoRef* = ptr OpaqueDiagnosticInfo
        ##  @see llvm::DiagnosticInfo

    ComdatRef* = ptr Comdat
        ##  @see llvm::Comdat

    ModuleFlagEntry* = OpaqueModuleFlagEntry
        ##  @see llvm::Module::ModuleFlagEntry

    JITEventListenerRef* = ptr OpaqueJITEventListener
        ##  @see llvm::JITEventListener

    BinaryRef* = ptr OpaqueBinary
        ##  @see llvm::object::Binary
