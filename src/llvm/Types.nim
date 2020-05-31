## ===-- llvm-c/Support.h - C Interface Types declarations ---------*- C -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This file defines types used by the C interface to LLVM.                   *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===
## *
##  @defgroup LLVMCSupportTypes Types and Enumerations
##
##  @{
##

type
  Bool* = cint

##  Opaque types.
## *
##  LLVM uses a polymorphic type hierarchy which C cannot represent, therefore
##  parameters must be passed as base types. Despite the declared types, most
##  of the functions provided operate only on branches of the type hierarchy.
##  The declared parameter names are descriptive and specify which type is
##  required. Additionally, each type hierarchy is documented along with the
##  functions that operate upon it. For more detail, refer to LLVM's C++ code.
##  If in doubt, refer to Core.cpp, which performs parameter downcasts in the
##  form unwrap<RequiredType>(Param).
##
## *
##  Used to pass regions of memory through LLVM interfaces.
##
##  @see llvm::MemoryBuffer
##

type
  MemoryBufferRef* = ptr opaqueMemoryBuffer

## *
##  The top-level container for all LLVM global data. See the LLVMContext class.
##

type
  ContextRef* = ptr opaqueContext

## *
##  The top-level container for all other LLVM Intermediate Representation (IR)
##  objects.
##
##  @see llvm::Module
##

type
  ModuleRef* = ptr opaqueModule

## *
##  Each value in the LLVM IR has a type, an LLVMTypeRef.
##
##  @see llvm::Type
##

type
  TypeRef* = ptr opaqueType

## *
##  Represents an individual value in LLVM IR.
##
##  This models llvm::Value.
##

type
  ValueRef* = ptr opaqueValue

## *
##  Represents a basic block of instructions in LLVM IR.
##
##  This models llvm::BasicBlock.
##

type
  BasicBlockRef* = ptr opaqueBasicBlock

## *
##  Represents an LLVM Metadata.
##
##  This models llvm::Metadata.
##

type
  MetadataRef* = ptr opaqueMetadata

## *
##  Represents an LLVM Named Metadata Node.
##
##  This models llvm::NamedMDNode.
##

type
  NamedMDNodeRef* = ptr opaqueNamedMDNode

## *
##  Represents an entry in a Global Object's metadata attachments.
##
##  This models std::pair<unsigned, MDNode *>
##

type
  ValueMetadataEntry* = opaqueValueMetadataEntry

## *
##  Represents an LLVM basic block builder.
##
##  This models llvm::IRBuilder.
##

type
  BuilderRef* = ptr opaqueBuilder

## *
##  Represents an LLVM debug info builder.
##
##  This models llvm::DIBuilder.
##

type
  DIBuilderRef* = ptr opaqueDIBuilder

## *
##  Interface used to provide a module to JIT or interpreter.
##  This is now just a synonym for llvm::Module, but we have to keep using the
##  different type to keep binary compatibility.
##

type
  ModuleProviderRef* = ptr opaqueModuleProvider

## * @see llvm::PassManagerBase

type
  PassManagerRef* = ptr opaquePassManager

## * @see llvm::PassRegistry

type
  PassRegistryRef* = ptr opaquePassRegistry

## *
##  Used to get the users and usees of a Value.
##
##  @see llvm::Use

type
  UseRef* = ptr opaqueUse

## *
##  Used to represent an attributes.
##
##  @see llvm::Attribute
##

type
  AttributeRef* = ptr opaqueAttributeRef

## *
##  @see llvm::DiagnosticInfo
##

type
  DiagnosticInfoRef* = ptr opaqueDiagnosticInfo

## *
##  @see llvm::Comdat
##

type
  ComdatRef* = ptr comdat

## *
##  @see llvm::Module::ModuleFlagEntry
##

type
  ModuleFlagEntry* = opaqueModuleFlagEntry

## *
##  @see llvm::JITEventListener
##

type
  JITEventListenerRef* = ptr opaqueJITEventListener

## *
##  @see llvm::object::Binary
##

type
  BinaryRef* = ptr opaqueBinary

## *
##  @}
##
