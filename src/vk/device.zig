const c = @import("c.zig").vk;
const Device = @import("../device.zig").Device;

pub const VulkanGPUOption = struct {};

pub const VulkanGPU = struct {
    pdev: c.VkPhysicalDevice,

    pub fn new(instance: c.VkInstance, option: VulkanGPUOption) !@This() {
        _ = instance;
        _ = option;
    }

    pub fn createDevice(self: *@This()) !Device {
        _ = self;
    }
};
