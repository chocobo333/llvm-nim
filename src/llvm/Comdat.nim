## ===-- llvm-c/Comdat.h - Module Comdat C Interface -------------*- C++ -*-===*\
## |*                                                                            *|
## |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
## |* Exceptions.                                                                *|
## |* See https://llvm.org/LICENSE.txt for license information.                  *|
## |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This file defines the C interface to COMDAT.                               *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

import prelude/platforms

import Types


type
    ComdatSelectionKind* {.size: sizeof(cint).} = enum
        AnyComdatSelectionKind              ## /< The linker may choose any COMDAT.
        ExactMatchComdatSelectionKind       ## /< The data referenced by the COMDAT must
                                            ## /< be the same.
        LargestComdatSelectionKind          ## /< The linker will choose the largest
                                            ## /< COMDAT.
        NoDuplicatesComdatSelectionKind     ## /< No other Module may specify this
                                            ## /< COMDAT.
        SameSizeComdatSelectionKind         ## /< The data referenced by the COMDAT must be
                                            ## /< the same size.



proc getOrInsertComdat*(m: ModuleRef; name: cstring): ComdatRef {.cdecl, importc: "LLVMGetOrInsertComdat", dynlib: LLVMlib.}
    ##  Return the Comdat in the module with the specified name. It is created
    ##  if it didn't already exist.
    ##
    ##  @see llvm::Module::getOrInsertComdat()

proc getComdat*(v: ValueRef): ComdatRef {.cdecl, importc: "LLVMGetComdat", dynlib: LLVMlib.}
    ##  Get the Comdat assigned to the given global object.
    ##
    ##  @see llvm::GlobalObject::getComdat()

proc setComdat*(v: ValueRef; c: ComdatRef) {.cdecl, importc: "LLVMSetComdat", dynlib: LLVMlib.}
    ##  Assign the Comdat to the given global object.
    ##
    ##  @see llvm::GlobalObject::setComdat()

proc getComdatSelectionKind*(c: ComdatRef): ComdatSelectionKind {.cdecl, importc: "LLVMGetComdatSelectionKind", dynlib: LLVMlib.}
    ##  Get the conflict resolution selection kind for the Comdat.
    ##
    ##  @see llvm::Comdat::getSelectionKind()


proc setComdatSelectionKind*(c: ComdatRef; kind: ComdatSelectionKind) {.cdecl, importc: "LLVMSetComdatSelectionKind", dynlib: LLVMlib.}
    ##  Set the conflict resolution selection kind for the Comdat.
    ##
    ##  @see llvm::Comdat::setSelectionKind()
