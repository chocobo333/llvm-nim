
# Supposed to be run on mac.
LLVM_INC="/usr/local/opt/llvm/include"

CC='gcc'
CCFLAGS="`llvm-config --cflags --libs --ldflags all --system-libs` -lLLVM"
C2NIM='c2nim'
C2NIMFLAGS='--nep1 --skipinclude --cdecl --prefix:LLVM --dynlib:LLVMlib'
NIMPRETTY='nimpretty'


DIRS=`find $LLVM_INC/llvm-c -type d -mindepth 1 | sed "s|$LLVM_INC/llvm-c/||g"`
FILES=`find $LLVM_INC/llvm-c -type f -mindepth 1 | sed "s|$LLVM_INC/llvm-c/||g"`

LLVMNIM='llvm'
PREP='prep'

mkdir -p $LLVMNIM/$PREP
cd $LLVMNIM

# makes needed directory in advance
for d in $DIRS; do
    mkdir -p $d
    mkdir -p $PREP/$d
done

for f in $FILES; do
    PREOUT="$PREP/${f%.h}.h"
    OUT="${f%.h}.nim"

    # precompile after removal #include directive
    cp -f $LLVM_INC/llvm-c/$f $PREOUT
    sed -i "" "/^#include/d" $PREOUT
    $CC -E -C -P -o $PREOUT $PREOUT
    # and then remove some problems.
    # sed -i "" "/^#/d" $PREOUT
    sed -i "" "/^$/d" $PREOUT
    sed -i "" "/LLVM_C_EXTERN_C_BEGIN/d" $PREOUT
    sed -i "" "/LLVM_C_EXTERN_C_END/d" $PREOUT

    # c2nim
    $C2NIM $C2NIMFLAGS $PREOUT -o:$OUT

    # amends nim file
    # rename structs
    sed -i "" "s/ptr opaque/ptr Opaque/" $OUT
    sed -i "" "s/ptr comdat/ptr Comdat/" $OUT
    sed -i "" "s/opaqueModuleFlagEntry/OpaqueModuleFlagEntry/" $OUT
    sed -i "" "s/opaqueValueMetadataEntry/OpaqueValueMetadataEntry/" $OUT

    # proglem with keword
    # sed -i "" "s/sizeOf/sizeOfX/" $OUT
    # sed -i "" "s/typeOf/typeOfX/" $OUT
    $NIMPRETTY --indent:4 $OUT

done