## ===-- llvm-c/Object.h - Object Lib C Iface --------------------*- C++ -*-===
##
##  Part of the LLVM Project, under the Apache License v2.0 with LLVM
##  Exceptions.
##  See https://llvm.org/LICENSE.txt for license information.
##  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
##
## ===----------------------------------------------------------------------===
##
##  This header declares the C interface to libLLVMObject.a, which
##  implements object file reading and writing.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
##
## ===----------------------------------------------------------------------===

import prelude/[
    opaques,
    platforms
]

import Types


type
    ##  Opaque type wrappers
    SectionIteratorRef* = ptr OpaqueSectionIterator
    SymbolIteratorRef* = ptr OpaqueSymbolIterator
    RelocationIteratorRef* = ptr OpaqueRelocationIterator
    BinaryType* {.size: sizeof(cint).} = enum
        BinaryTypeArchive               ## *< Archive file.
        BinaryTypeMachOUniversalBinary  ## *< Mach-O Universal Binary file.
        BinaryTypeCOFFImportFile        ## *< COFF Import file.
        BinaryTypeIR                    ## *< LLVM IR.
        BinaryTypeWinRes                ## *< Windows resource (.res) file.
        BinaryTypeCOFF                  ## *< COFF Object file.
        BinaryTypeELF32L                ## *< ELF 32-bit, little endian.
        BinaryTypeELF32B                ## *< ELF 32-bit, big endian.
        BinaryTypeELF64L                ## *< ELF 64-bit, little endian.
        BinaryTypeELF64B                ## *< ELF 64-bit, big endian.
        BinaryTypeMachO32L              ## *< MachO 32-bit, little endian.
        BinaryTypeMachO32B              ## *< MachO 32-bit, big endian.
        BinaryTypeMachO64L              ## *< MachO 64-bit, little endian.
        BinaryTypeMachO64B              ## *< MachO 64-bit, big endian.
        BinaryTypeWasm                  ## *< Web Assembly.


## *
##

proc createBinary*(memBuf: MemoryBufferRef; context: ContextRef;errorMessage: cstringArray): BinaryRef {.cdecl, importc: "LLVMCreateBinary", dynlib: LLVMlib.}
    ##  Create a binary file from the given memory buffer.
    ##
    ##  The exact type of the binary file will be inferred automatically, and the
    ##  appropriate implementation selected.  The context may be NULL except if
    ##  the resulting file is an LLVM IR file.
    ##
    ##  The memory buffer is not consumed by this function.  It is the responsibilty
    ##  of the caller to free it with \c LLVMDisposeMemoryBuffer.
    ##
    ##  If NULL is returned, the \p ErrorMessage parameter is populated with the
    ##  error's description.  It is then the caller's responsibility to free this
    ##  message by calling \c LLVMDisposeMessage.
    ##
    ##  @see llvm::object::createBinary
## *
##

proc disposeBinary*(br: BinaryRef) {.cdecl, importc: "LLVMDisposeBinary", dynlib: LLVMlib.}
    ##  Dispose of a binary file.
    ##
    ##  The binary file does not own its backing buffer.  It is the responsibilty
    ##  of the caller to free it with \c LLVMDisposeMemoryBuffer.
## *
##

proc binaryCopyMemoryBuffer*(br: BinaryRef): MemoryBufferRef {.cdecl, importc: "LLVMBinaryCopyMemoryBuffer", dynlib: LLVMlib.}
    ##  Retrieves a copy of the memory buffer associated with this object file.
    ##
    ##  The returned buffer is merely a shallow copy and does not own the actual
    ##  backing buffer of the binary. Nevertheless, it is the responsibility of the
    ##  caller to free it with \c LLVMDisposeMemoryBuffer.
    ##
    ##  @see llvm::object::getMemoryBufferRef
## *
##

proc binaryGetType*(br: BinaryRef): BinaryType {.cdecl, importc: "LLVMBinaryGetType", dynlib: LLVMlib.}
    ##  Retrieve the specific type of a binary.
    ##
    ##  @see llvm::object::Binary::getType
##
##

proc machOUniversalBinaryCopyObjectForArch*(br: BinaryRef; arch: cstring;archLen: csize_t; errorMessage: cstringArray): BinaryRef {.cdecl, importc: "LLVMMachOUniversalBinaryCopyObjectForArch", dynlib: LLVMlib.}
    ##  For a Mach-O universal binary file, retrieves the object file corresponding
    ##  to the given architecture if it is present as a slice.
    ##
    ##  If NULL is returned, the \p ErrorMessage parameter is populated with the
    ##  error's description.  It is then the caller's responsibility to free this
    ##  message by calling \c LLVMDisposeMessage.
    ##
    ##  It is the responsiblity of the caller to free the returned object file by
    ##  calling \c LLVMDisposeBinary.
## *
##

proc objectFileCopySectionIterator*(br: BinaryRef): SectionIteratorRef {.cdecl, importc: "LLVMObjectFileCopySectionIterator", dynlib: LLVMlib.}
    ##  Retrieve a copy of the section iterator for this object file.
    ##
    ##  If there are no sections, the result is NULL.
    ##
    ##  The returned iterator is merely a shallow copy. Nevertheless, it is
    ##  the responsibility of the caller to free it with
    ##  \c LLVMDisposeSectionIterator.
    ##
    ##  @see llvm::object::sections()
## *
##

proc objectFileIsSectionIteratorAtEnd*(br: BinaryRef;si: SectionIteratorRef): Bool {. cdecl, importc: "LLVMObjectFileIsSectionIteratorAtEnd", dynlib: LLVMlib.}
    ##  Returns whether the given section iterator is at the end.
    ##
    ##  @see llvm::object::section_end

proc objectFileCopySymbolIterator*(br: BinaryRef): SymbolIteratorRef {.cdecl, importc: "LLVMObjectFileCopySymbolIterator", dynlib: LLVMlib.}
    ##  Retrieve a copy of the symbol iterator for this object file.
    ##
    ##  If there are no symbols, the result is NULL.
    ##
    ##  The returned iterator is merely a shallow copy. Nevertheless, it is
    ##  the responsibility of the caller to free it with
    ##  \c LLVMDisposeSymbolIterator.
    ##
    ##  @see llvm::object::symbols()

proc objectFileIsSymbolIteratorAtEnd*(br: BinaryRef;si: SymbolIteratorRef): Bool {. cdecl, importc: "LLVMObjectFileIsSymbolIteratorAtEnd", dynlib: LLVMlib.}
    ##  Returns whether the given symbol iterator is at the end.
    ##
    ##  @see llvm::object::symbol_end

proc disposeSectionIterator*(si: SectionIteratorRef) {.cdecl, importc: "LLVMDisposeSectionIterator", dynlib: LLVMlib.}
proc moveToNextSection*(si: SectionIteratorRef) {.cdecl, importc: "LLVMMoveToNextSection", dynlib: LLVMlib.}
proc moveToContainingSection*(sect: SectionIteratorRef;sym: SymbolIteratorRef) {. cdecl, importc: "LLVMMoveToContainingSection", dynlib: LLVMlib.}

##  ObjectFile Symbol iterators
proc disposeSymbolIterator*(si: SymbolIteratorRef) {.cdecl, importc: "LLVMDisposeSymbolIterator", dynlib: LLVMlib.}
proc moveToNextSymbol*(si: SymbolIteratorRef) {.cdecl, importc: "LLVMMoveToNextSymbol", dynlib: LLVMlib.}

##  SectionRef accessors
proc getSectionName*(si: SectionIteratorRef): cstring {.cdecl, importc: "LLVMGetSectionName", dynlib: LLVMlib.}
proc getSectionSize*(si: SectionIteratorRef): uint64T {.cdecl, importc: "LLVMGetSectionSize", dynlib: LLVMlib.}
proc getSectionContents*(si: SectionIteratorRef): cstring {.cdecl, importc: "LLVMGetSectionContents", dynlib: LLVMlib.}
proc getSectionAddress*(si: SectionIteratorRef): uint64T {.cdecl, importc: "LLVMGetSectionAddress", dynlib: LLVMlib.}
proc getSectionContainsSymbol*(si: SectionIteratorRef;sym: SymbolIteratorRef): Bool {. cdecl, importc: "LLVMGetSectionContainsSymbol", dynlib: LLVMlib.}

##  Section Relocation iterators
proc getRelocations*(section: SectionIteratorRef): RelocationIteratorRef {.cdecl, importc: "LLVMGetRelocations", dynlib: LLVMlib.}
proc disposeRelocationIterator*(ri: RelocationIteratorRef) {.cdecl, importc: "LLVMDisposeRelocationIterator", dynlib: LLVMlib.}
proc isRelocationIteratorAtEnd*(section: SectionIteratorRef;ri: RelocationIteratorRef): Bool {.cdecl, importc: "LLVMIsRelocationIteratorAtEnd", dynlib: LLVMlib.}
proc moveToNextRelocation*(ri: RelocationIteratorRef) {.cdecl, importc: "LLVMMoveToNextRelocation", dynlib: LLVMlib.}

##  SymbolRef accessors
proc getSymbolName*(si: SymbolIteratorRef): cstring {.cdecl, importc: "LLVMGetSymbolName", dynlib: LLVMlib.}
proc getSymbolAddress*(si: SymbolIteratorRef): uint64T {.cdecl, importc: "LLVMGetSymbolAddress", dynlib: LLVMlib.}
proc getSymbolSize*(si: SymbolIteratorRef): uint64T {.cdecl, importc: "LLVMGetSymbolSize", dynlib: LLVMlib.}

##  RelocationRef accessors
proc getRelocationOffset*(ri: RelocationIteratorRef): uint64T {.cdecl, importc: "LLVMGetRelocationOffset", dynlib: LLVMlib.}
proc getRelocationSymbol*(ri: RelocationIteratorRef): SymbolIteratorRef {.cdecl, importc: "LLVMGetRelocationSymbol", dynlib: LLVMlib.}
proc getRelocationType*(ri: RelocationIteratorRef): uint64T {.cdecl, importc: "LLVMGetRelocationType", dynlib: LLVMlib.}

proc getRelocationTypeName*(ri: RelocationIteratorRef): cstring {.cdecl, importc: "LLVMGetRelocationTypeName", dynlib: LLVMlib.}
    ##  NOTE: Caller takes ownership of returned string of the two
    ##  following functions.
proc getRelocationValueString*(ri: RelocationIteratorRef): cstring {.cdecl, importc: "LLVMGetRelocationValueString", dynlib: LLVMlib.}


type
    ObjectFileRef* = ptr OpaqueObjectFile
        ## * Deprecated: Use LLVMBinaryRef instead.


proc createObjectFile*(memBuf: MemoryBufferRef): ObjectFileRef {.cdecl, importc: "LLVMCreateObjectFile", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMCreateBinary instead.

proc disposeObjectFile*(objectFile: ObjectFileRef) {.cdecl, importc: "LLVMDisposeObjectFile", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMDisposeBinary instead.

proc getSections*(objectFile: ObjectFileRef): SectionIteratorRef {.cdecl, importc: "LLVMGetSections", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMObjectFileCopySectionIterator instead.

proc isSectionIteratorAtEnd*(objectFile: ObjectFileRef;si: SectionIteratorRef): Bool {. cdecl, importc: "LLVMIsSectionIteratorAtEnd", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMObjectFileIsSectionIteratorAtEnd instead.

proc getSymbols*(objectFile: ObjectFileRef): SymbolIteratorRef {.cdecl, importc: "LLVMGetSymbols", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMObjectFileCopySymbolIterator instead.

proc isSymbolIteratorAtEnd*(objectFile: ObjectFileRef;si: SymbolIteratorRef): Bool {. cdecl, importc: "LLVMIsSymbolIteratorAtEnd", dynlib: LLVMlib.}
    ## * Deprecated: Use LLVMObjectFileIsSymbolIteratorAtEnd instead.
