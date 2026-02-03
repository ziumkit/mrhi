const InstanceImpl = @import("backend.zig");
const vk = @import("vk/instance.zig");
const config = @import("config");

pub const BackendCandidate = enum {
    vk,
    d3d11,
    metal,
};

pub const InstanceInitHint = struct {
    backends: []BackendCandidate,
};

pub const InstanceError = error{
    no_adequate_backend,
};

pub const Instance = struct {
    implement: InstanceImpl,

    pub fn new(hint: InstanceInitHint) InstanceError!@This() {
        for (hint.backends) |b| switch (b) {
            .vk => {
                if (comptime config.enable_vk) {
                    const vk_instance = vk.createMVkInstance();
                    const implement = InstanceImpl{
                        .vt = vk_instance.vt,
                        .inner = vk_instance,
                    };
                    return .{
                        .implement = implement,
                    };
                }
            },
        };

        return InstanceError.no_adequate_backend;
    }
};

test {
    const std = @import("std");
    _ = std.testing.refAllDecls(@This());
    _ = vk;
}
