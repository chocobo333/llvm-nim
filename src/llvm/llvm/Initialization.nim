
##  This header declares the C interface to LLVM initialization routines,
##  which must be called before you can use the functionality provided by
##  the corresponding LLVM library.

##  This module contains routines used to initialize the LLVM system.

import prelude/platforms

import Types


proc initializeCore*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeCore", dynlib: LLVMlib.}
proc initializeTransformUtils*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeTransformUtils", dynlib: LLVMlib.}
proc initializeScalarOpts*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeScalarOpts", dynlib: LLVMlib.}
proc initializeObjCARCOpts*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeObjCARCOpts", dynlib: LLVMlib.}
proc initializeVectorization*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeVectorization", dynlib: LLVMlib.}
proc initializeInstCombine*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeInstCombine", dynlib: LLVMlib.}
proc initializeAggressiveInstCombiner*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeAggressiveInstCombiner", dynlib: LLVMlib.}
proc initializeIPO*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeIPO", dynlib: LLVMlib.}
proc initializeInstrumentation*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeInstrumentation", dynlib: LLVMlib.}
proc initializeAnalysis*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeAnalysis", dynlib: LLVMlib.}
proc initializeIPA*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeIPA", dynlib: LLVMlib.}
proc initializeCodeGen*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeCodeGen", dynlib: LLVMlib.}
proc initializeTarget*(r: PassRegistryRef) {.cdecl, importc: "LLVMInitializeTarget", dynlib: LLVMlib.}
