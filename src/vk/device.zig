const c = @import("c.zig").vk;
const Device = @import("../device.zig").Device;

pub const MVkGPUOption = struct {};

pub const MVkGPU = struct {
    pdev: c.VkPhysicalDevice,

    pub fn new(instance: c.VkInstance, option: MVkGPUOption) !@This() {
        _ = instance;
        _ = option;
    }

    pub fn createDevice(self: *@This()) !Device {
        _ = self;
    }
};
