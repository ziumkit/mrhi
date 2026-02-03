const instance = @import("instance.zig");

pub const InstanceImplVtable = struct {};

pub const InstanceImpl = struct {
    inner: *const anyopaque,
    vt: InstanceImplVtable,
};
