const std = @import("std");
const Build = std.Build;
const Step = Build.Step;
const Module = Build.Module;

pub const SystemLibConfig = struct {
    name: []const u8,
    needs_libc: bool = false,
    needs_libcpp: bool = false,
};

pub const SystemLibSet = []const SystemLibConfig;

pub const LinkConfig = struct {
    include_paths: []const []const u8 = &.{},
    lib_paths: []const []const u8 = &.{},
    system_libs: SystemLibSet = &.{},
    frameworks: []const []const u8 = &.{},
    rpaths: []const []const u8 = &.{},
    c_macros: []const CMacro = &.{},
    assembly_files: []const []const u8 = &.{},
    object_files: []const []const u8 = &.{},
    link_libc: bool = false,
    link_libcpp: bool = false,
};

pub const CMacro = struct {
    name: []const u8,
    value: []const u8 = "1",
};

pub fn applyLinkConfig(b: *Build, compile: *Step.Compile, cfg: LinkConfig) void {
    for (cfg.include_paths) |p| {
        compile.root_module.addIncludePath(b.path(p));
    }
    for (cfg.lib_paths) |p| {
        compile.root_module.addLibraryPath(b.path(p));
    }
    for (cfg.system_libs) |lib| {
        compile.root_module.linkSystemLibrary(lib.name, .{});
        if (lib.needs_libc) compile.root_module.link_libc = true;
        if (lib.needs_libcpp) compile.root_module.link_libcpp = true;
    }
    for (cfg.frameworks) |fw| {
        compile.root_module.linkFramework(fw, .{});
    }
    for (cfg.rpaths) |rp| {
        compile.root_module.addRPath(b.path(rp));
    }
    for (cfg.c_macros) |m| {
        compile.root_module.addCMacro(m.name, m.value);
    }
    for (cfg.assembly_files) |f| {
        compile.root_module.addAssemblyFile(b.path(f));
    }
    for (cfg.object_files) |f| {
        compile.root_module.addObjectFile(b.path(f));
    }
    if (cfg.link_libc) compile.root_module.link_libc = true;
    if (cfg.link_libcpp) compile.root_module.link_libcpp = true;
}

pub fn applySystemLibs(b: *Build, compile: *Step.Compile, libs: SystemLibSet) void {
    applyLinkConfig(b, compile, .{ .system_libs = libs });
}

pub fn applySystemLib(b: *Build, compile: *Step.Compile, config: SystemLibConfig) void {
    applySystemLibs(b, compile, &.{config});
}

test "SystemLibConfig defaults" {
    const config = SystemLibConfig{ .name = "test" };
    try std.testing.expectEqualStrings("test", config.name);
    try std.testing.expectEqual(false, config.needs_libc);
    try std.testing.expectEqual(false, config.needs_libcpp);
}

test "LinkConfig defaults" {
    const cfg = LinkConfig{};
    try std.testing.expectEqual(@as(usize, 0), cfg.include_paths.len);
    try std.testing.expectEqual(@as(usize, 0), cfg.lib_paths.len);
    try std.testing.expectEqual(@as(usize, 0), cfg.system_libs.len);
    try std.testing.expectEqual(@as(usize, 0), cfg.frameworks.len);
    try std.testing.expectEqual(@as(usize, 0), cfg.rpaths.len);
    try std.testing.expectEqual(@as(usize, 0), cfg.c_macros.len);
    try std.testing.expectEqual(false, cfg.link_libc);
    try std.testing.expectEqual(false, cfg.link_libcpp);
}
