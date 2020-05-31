
type
    OpaqueMemoryBuffer* = object

    OpaqueAttributeRef* {.pure, final.} = object
    OpaqueContext* {.pure, final.} = object
    OpaqueModule* {.pure, final.} = object
    OpaqueType* {.pure, final.} = object
    OpaqueValue* {.pure, final.} = object
    OpaqueBasicBlock* {.pure, final.} = object
    OpaqueBuilder* {.pure, final.} = object
    OpaqueModuleProvider* {.pure, final.} = object
    OpaquePassManager* {.pure, final.} = object
    OpaquePassRegistry* {.pure, final.} = object
    OpaqueUse* {.pure, final.} = object
    OpaqueDiagnosticInfo* {.pure, final.} = object
    OpaqueTargetMachine* {.pure, final.} = object
    OpaquePassManagerBuilder* {.pure, final.} = object
    OpaqueMetaData* {.pure, final.} = object
    OpaqueDIBuilder* {.pure, final.} = object
    OpaqueJITEventListener* {.pure, final.} = object
    OpaqueNamedMDNode* {.pure, final.} = object
    OpaqueValueMetadataEntry* {.pure, final.} = object
    OpaqueModuleFlagEntry* {.pure, final.} = object
    OpaqueBinary* {.pure, final.} = object

    OpaqueLTOModule* {.pure, final.} = object
    OpaqueLTOCodeGenerator* {.pure, final.} = object
    OpaqueThinLTOCodeGenerator* {.pure, final.} = object

    OpaqueTargetData* {.pure, final.} = object
    OpaqueTargetLibraryInfotData* {.pure, final.} = object

    Comdat* {.pure, final.} = object

    target* {.pure, final.} = object

    uint8T* = uint8
    # uint16T = uint16
    uint32T* = uint32
    uint64T* = uint64
    int64T* = int64

    OpaqueError* {.pure, final.} = object

    OpaqueGenericValue* {.pure, final.} = object
    OpaqueExecutionEngine* {.pure, final.} = object
    OpaqueMCJITMemoryManager* {.pure, final.} = object

    uintptrT* = ptr uint32T

    OffT* = int64T
    OpaqueLTOInput* {.pure, final.} = object

    OpaqueSectionIterator* {.pure, final.} = object
    OpaqueSymbolIterator* {.pure, final.} = object
    OpaqueRelocationIterator* {.pure, final.} = object
    OpaqueObjectFile* {.pure, final.} = object

    orcOpaqueJITStack* {.pure, final.} = object

    remarkOpaqueString* {.pure, final.} = object
    remarkOpaqueDebugLoc* {.pure, final.} = object
    remarkOpaqueArg* {.pure, final.} = object
    remarkOpaqueEntry* {.pure, final.} = object
    remarkOpaqueParser* {.pure, final.} = object