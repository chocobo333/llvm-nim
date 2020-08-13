
##  This file defines the C interface to the IR Reader.

import prelude/platforms

import Types


proc parseIRInContext*(contextRef: ContextRef; memBuf: MemoryBufferRef;outM: ptr ModuleRef; outMessage: cstringArray): Bool {.cdecl, importc: "LLVMParseIRInContext", dynlib: LLVMlib.}
    ##  Read LLVM IR from a memory buffer and convert it into an in-memory Module
    ##  object. Returns 0 on success.
    ##  Optionally returns a human-readable description of any errors that
    ##  occurred during parsing IR. OutMessage must be disposed with
    ##  LLVMDisposeMessage.
    ##
    ##  @see llvm::ParseIR()
