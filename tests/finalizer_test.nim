import os

type MyRef = ref object of RootObj
  value: int

proc finalizer(myref: MyRef) =
  echo "finalizer was called"

var myref: MyRef
echo "Use new with finalizer to allocate"
new(myref, finalizer)
myref.value = 100
assert(myref.value == 100)
echo "initialization done"
sleep(1000)
echo "nullify the reference"
myref = nil
assert(myref == nil)
echo "sleep for a bit"
sleep(1000)
echo "Done"