
##  This file defines the C interface to the module/file/archive linker.

import prelude/platforms

import Types


type
    LinkerMode* {.size: sizeof(cint).} = enum
        ##  This enum is provided for backwards-compatibility only. It has no effect.
        LinkerDestroySource = 0, ##  This is the default behavior.
        LinkerPreserveSourceRemoved = 1

proc linkModules2*(dest: ModuleRef; src: ModuleRef): Bool {.cdecl, importc: "LLVMLinkModules2", dynlib: LLVMlib.}
    ##  Links the source module into the destination module. The source module is
    ##  destroyed.
    ##  The return value is true if an error occurred, false otherwise.
    ##  Use the diagnostic handler to get any diagnostic message.
