
import unittest

import llvm

test "":
    var
        Int64 = intType(64)
        module = newModule("main")
        fnty = functionType(Int64, @[])
        main = module.addFunction("main", fnty)

    module.verify()
    echo module