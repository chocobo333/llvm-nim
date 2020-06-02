# ===-- llvm-c/Support.h - Support C Interface --------------------*- C -*-===*\
# |*                                                                            *|
# |* Part of the LLVM Project, under the Apache License v2.0 with LLVM          *|
# |* Exceptions.                                                                *|
# |* See https://llvm.org/LICENSE.txt for license information.                  *|
# |* SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception                    *|
# |*                                                                            *|
# |*===----------------------------------------------------------------------===*|
# |*                                                                            *|
# |* This file defines the C interface to the LLVM support library.             *|
# |*                                                                            *|
# \*===----------------------------------------------------------------------===

import prelude/platforms

import Types


proc loadLibraryPermanently*(filename: cstring): Bool {.cdecl, importc: "LLVMLoadLibraryPermanently", dynlib: LLVMlib.}
    ##  This function permanently loads the dynamic library at the given path.
    ##  It is safe to call this function multiple times for the same library.
    ##
    ##  @see sys::DynamicLibrary::LoadLibraryPermanently()

proc parseCommandLineOptions*(argc: cint; argv: cstringArray;overview: cstring) {. cdecl, importc: "LLVMParseCommandLineOptions", dynlib: LLVMlib.}
    ##  This function parses the given arguments using the LLVM command line parser.
    ##  Note that the only stable thing about this function is its signature; you
    ##  cannot rely on any particular set of command line arguments being interpreted
    ##  the same way across LLVM versions.
    ##
    ##  @see llvm::cl::ParseCommandLineOptions()

proc searchForAddressOfSymbol*(symbolName: cstring): pointer {.cdecl, importc: "LLVMSearchForAddressOfSymbol", dynlib: LLVMlib.}
    ##  This function will search through all previously loaded dynamic
    ##  libraries for the symbol \p symbolName. If it is found, the address of
    ##  that symbol is returned. If not, null is returned.
    ##
    ##  @see sys::DynamicLibrary::SearchForAddressOfSymbol()

proc addSymbol*(symbolName: cstring; symbolValue: pointer) {.cdecl, importc: "LLVMAddSymbol", dynlib: LLVMlib.}
    ##  This functions permanently adds the symbol \p symbolName with the
    ##  value \p symbolValue.  These symbols are searched before any
    ##  libraries.
    ##
    ##  @see sys::DynamicLibrary::AddSymbol()
