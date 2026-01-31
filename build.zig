const std = @import("std");
const builtin = @import("builtin");

fn featVkShouldEnable() bool {
    return switch (builtin.os.tag) {
        .linux => true,
        else => false,
    };
}

fn featMetalShouldEnable() bool {
    return switch (builtin.os.tag) {
        .macos => true,
        else => false,
    };
}

fn featD3D11ShouldEnable() bool {
    return switch (builtin.os.tag) {
        .windows => true,
        else => false,
    };
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Build options
    const options = b.addOptions();
    options.addOption(bool, "enable_vk", featVkShouldEnable());
    options.addOption(bool, "enable_metal", featMetalShouldEnable());
    options.addOption(bool, "enable_d3d11", featD3D11ShouldEnable());
    options.addOption(bool, "enable_gles3", false);

    // Main module
    const mod = b.addModule("mrhi", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    mod.addOptions("config", options);

    const libmrhi = b.addLibrary(.{
        .name = "mrhi",
        .linkage = .static,
        .root_module = mod,
    });

    b.installArtifact(libmrhi);

    const exe = b.addExecutable(.{
        .name = "demo",
        .root_module = b.createModule(.{
            .root_source_file = b.path("demo.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const mod_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_mod_tests = b.addRunArtifact(mod_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
}
