
import unittest

import llvm

test "wrap":
    var
        llInt = intType(113)
        module = newModule("main")

    require module.identifier == "main"
    require module.sourceFileName == "main"
    module.identifier = "aaaa"
    module.sourceFileName = "bbbb"

    var
        fnty = functionType(voidType(), @[Type llInt])
        fn = module.addFunction("test", fnty)
        entry = fn.appendBasicBlock("entry")
        builder = newBuilder()

    builder.atEndOf(entry)
    builder.retVoid()

    check not module.verify()
    
    # module.dump()
    # module.printToFile("test2.ll")
    check $module == """; ModuleID = 'aaaa'
source_filename = "bbbb"

define void @test(i113 %0) {
entry:
  ret void
}
"""

    check $llInt == "i113"
    check $llInt.typeof == "IntegerType"
