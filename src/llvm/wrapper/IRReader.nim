
import ../raw

import types
import analysis

import os
import options


proc parseIR*(self: Context, filename: string): Option[Module] =
    var
        mbuf: MemoryBufferRef
        outM: cstringArray = allocCStringArray(@[])
    if createMemoryBufferWithContentsOfFile(filename, mbuf.addr, outM):
        stderr.writeLine "failed in parseIR: ", outM[0]
        return none(Module)
    if not filename.isAbsolute:
        stderr.writeLine "filed in parseIR: `filename` is not absolute."
        return none(Module)
    var
        module: ModuleRef
    if self.context.parseIRInContext(mbuf, module.addr, outM):
        stderr.writeLine "failed in parseIR: ", outM[0]
        return none(Module)
    result = some newModule(module)
    
    if result.get.verify():
        return none(Module)