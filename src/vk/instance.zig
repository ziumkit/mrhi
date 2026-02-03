const c = @import("c.zig").vk;
const backend = @import("../backend.zig");

pub const MVkInstance = struct {
    vt: backend.InstanceImplVtable,
    instance: c.VkInstance,
};

pub fn createMVkInstance() MVkInstance {
    return .{
        .vt = .{},
        .instance = undefined,
    };
}

test {
    const std = @import("std");
    _ = std.testing.refAllDecls(@This());
    _ = createMVkInstance();
}
