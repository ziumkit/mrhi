pub const Device = @import("device.zig").Device;
pub const backend = @import("backend.zig");
pub const instance = @import("instance.zig");
pub const vk = @import("vk/root.zig");

test {
    const std = @import("std");
    _ = std.testing.refAllDecls(@This());
}
