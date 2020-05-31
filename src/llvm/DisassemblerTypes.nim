## ===-- llvm-c/DisassemblerTypedefs.h -----------------------------*- C -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===
## *
##  An Opaque reference to a disassembler context.
##

type
    DisasmContextRef* = pointer

## *
##  The type for the operand information call back function.  This is called to
##  get the symbolic information for an operand of an instruction.  Typically
##  this is from the relocation information, symbol table, etc.  That block of
##  information is saved when the disassembler context is created and passed to
##  the call back in the DisInfo parameter.  The instruction containing operand
##  is at the PC parameter.  For some instruction sets, there can be more than
##  one operand with symbolic information.  To determine the symbolic operand
##  information for each operand, the bytes for the specific operand in the
##  instruction are specified by the Offset parameter and its byte widith is the
##  size parameter.  For instructions sets with fixed widths and one symbolic
##  operand per instruction, the Offset parameter will be zero and Size parameter
##  will be the instruction width.  The information is returned in TagBuf and is
##  Triple specific with its specific information defined by the value of
##  TagType for that Triple.  If symbolic information is returned the function
##  returns 1, otherwise it returns 0.
##

type
    OpInfoCallback* = proc (disInfo: pointer; pc: uint64T; offset: uint64T; size: uint64T;tagType: cint; tagBuf: pointer): cint {.cdecl.}

## *
##  The initial support in LLVM MC for the most general form of a relocatable
##  expression is "AddSymbol - SubtractSymbol + Offset".  For some Darwin targets
##  this full form is encoded in the relocation information so that AddSymbol and
##  SubtractSymbol can be link edited independent of each other.  Many other
##  platforms only allow a relocatable expression of the form AddSymbol + Offset
##  to be encoded.
##
##  The LLVMOpInfoCallback() for the TagType value of 1 uses the struct
##  LLVMOpInfo1.  The value of the relocatable expression for the operand,
##  including any PC adjustment, is passed in to the call back in the Value
##  field.  The symbolic information about the operand is returned using all
##  the fields of the structure with the Offset of the relocatable expression
##  returned in the Value field.  It is possible that some symbols in the
##  relocatable expression were assembly temporary symbols, for example
##  "Ldata - LpicBase + constant", and only the Values of the symbols without
##  symbol names are present in the relocation information.  The VariantKind
##  type is one of the Target specific #defines below and is used to print
##  operands like "_foo@GOT", ":lower16:_foo", etc.
##

type
    OpInfoSymbol1* {.bycopy.} = object
        present*: uint64T ##  1 if this symbol is present
        name*: cstring    ##  symbol name if not NULL
        value*: uint64T   ##  symbol value if name is NULL

    OpInfo1* {.bycopy.} = object
        addSymbol*: OpInfoSymbol1
        subtractSymbol*: OpInfoSymbol1
        value*: uint64T
        variantKind*: uint64T


## *
##  The operand VariantKinds for symbolic disassembly.
##
## *
##  The ARM target VariantKinds.
##
## *
##  The ARM64 target VariantKinds.
##
## *
##  The type for the symbol lookup function.  This may be called by the
##  disassembler for things like adding a comment for a PC plus a constant
##  offset load instruction to use a symbol name instead of a load address value.
##  It is passed the block information is saved when the disassembler context is
##  created and the ReferenceValue to look up as a symbol.  If no symbol is found
##  for the ReferenceValue NULL is returned.  The ReferenceType of the
##  instruction is passed indirectly as is the PC of the instruction in
##  ReferencePC.  If the output reference can be determined its type is returned
##  indirectly in ReferenceType along with ReferenceName if any, or that is set
##  to NULL.
##

type
    SymbolLookupCallback* = proc (disInfo: pointer; referenceValue: uint64T;referenceType: ptr uint64T; referencePC: uint64T;referenceName: cstringArray): cstring {.cdecl.}

## *
##  The reference types on input and output.
##
##  No input reference type or no output reference type.
##  The input reference is from a branch instruction.
##  The input reference is from a PC relative load instruction.
##  The input reference is from an ARM64::ADRP instruction.
##  The input reference is from an ARM64::ADDXri instruction.
##  The input reference is from an ARM64::LDRXui instruction.
##  The input reference is from an ARM64::LDRXl instruction.
##  The input reference is from an ARM64::ADR instruction.
##  The output reference is to as symbol stub.
##  The output reference is to a symbol address in a literal pool.
##  The output reference is to a cstring address in a literal pool.
##  The output reference is to a Objective-C CoreFoundation string.
##  The output reference is to a Objective-C message.
##  The output reference is to a Objective-C message ref.
##  The output reference is to a Objective-C selector ref.
##  The output reference is to a Objective-C class ref.
##  The output reference is to a C++ symbol name.
