const std = @import("std");
const buildx = @import("src/buildx.zig");

pub const project = buildx.project;
pub const workspace = buildx.workspace;
pub const crossCompile = buildx.crossCompile;
pub const targets = buildx.targets;
pub const option = buildx.option;
pub const optionWithDefault = buildx.optionWithDefault;
pub const boolOption = buildx.boolOption;
pub const stringOption = buildx.stringOption;
pub const SystemLibConfig = buildx.SystemLibConfig;
pub const SystemLibSet = buildx.SystemLibSet;
pub const ProjectOptions = buildx.ProjectOptions;
pub const CrossConfig = buildx.CrossConfig;
pub const WorkspaceOptions = buildx.WorkspaceOptions;
pub const MemberConfig = buildx.MemberConfig;
pub const MemberKind = buildx.MemberKind;
pub const Workspace = buildx.Workspace;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("buildx", .{
        .root_source_file = b.path("src/buildx.zig"),
        .target = target,
    });

    const lib_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/buildx.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_lib_tests = b.addRunArtifact(lib_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_lib_tests.step);
}
