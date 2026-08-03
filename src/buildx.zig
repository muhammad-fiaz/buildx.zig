const std = @import("std");
const Build = std.Build;

pub const target = @import("target.zig");
pub const plugins = @import("plugins.zig");
pub const options_mod = @import("options.zig");
pub const dependencies = @import("dependencies.zig");
pub const project_mod = @import("project.zig");
pub const workspace_mod = @import("workspace.zig");

pub const SystemLibConfig = plugins.SystemLibConfig;
pub const SystemLibSet = plugins.SystemLibSet;
pub const LinkConfig = plugins.LinkConfig;
pub const TargetList = target.TargetList;
pub const ProjectOptions = project_mod.ProjectOptions;
pub const CrossConfig = ProjectOptions.CrossConfig;
pub const WorkspaceOptions = workspace_mod.WorkspaceOptions;
pub const MemberConfig = workspace_mod.MemberConfig;
pub const MemberKind = workspace_mod.MemberKind;
pub const Workspace = workspace_mod.Workspace;

pub const project = project_mod.project;
pub const crossCompile = project_mod.crossCompile;
pub const workspace = workspace_mod.workspace;

pub const targets = struct {
    pub const all = target.all;
    pub const desktop = target.desktop;
    pub const linux = target.linux;
    pub const windows = target.windows;
    pub const macos = target.macos;
    pub const arm = target.arm;
    pub const riscv = target.riscv;
    pub const freestanding = target.freestanding;
    pub const wasm = target.wasm;
    pub const allArchitectures = target.allArchitectures;
};

pub fn option(b: *Build, comptime T: type, name: []const u8, description: []const u8) ?T {
    return options_mod.option(b, T, name, description);
}

pub fn optionWithDefault(b: *Build, comptime T: type, name: []const u8, description: []const u8, default: T) T {
    return options_mod.optionWithDefault(b, T, name, description, default);
}

pub fn boolOption(b: *Build, name: []const u8, description: []const u8, default: bool) bool {
    return options_mod.boolOption(b, name, description, default);
}

pub fn stringOption(b: *Build, name: []const u8, description: []const u8, default: []const u8) []const u8 {
    return options_mod.stringOption(b, name, description, default);
}

test {
    _ = target;
    _ = plugins;
    _ = options_mod;
    _ = dependencies;
    _ = project_mod;
    _ = workspace_mod;
}
