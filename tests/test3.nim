
import unittest

import llvm

import os
import strformat

test "":
    var
        Int64 = intType(64)
        module = newModule("main")
        cxt = module.context
        fnty = functionType(Int64, @[])
        main = module.addFunction("main", fnty)
        bb = main.appendBasicBlock("entry", cxt)
        builder = newBuilder(cxt)
    builder.atEndOf bb
    builder.ret(constInt(Int64, 3))

    module.verify()

    const
        testdir = "tests"
        filename = testdir / "tmp.ll"
        cmd = fmt"lli {filename}"
    block:
        let
            f = open(filename, fmWrite)
        defer:
            f.close()
        f.write($module)
    check execShellCmd(cmd) == 3
    discard execShellCmd(fmt"rm {filename}")