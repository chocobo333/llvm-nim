import ../raw

import types


proc link*(self: Module, other: Module): Module =
    if self.module.linkModules2(other.module):
        # FIXME: err message
        discard
    self