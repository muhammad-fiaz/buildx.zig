const std = @import("std");
const Build = std.Build;
const Step = Build.Step;

pub const DependencyList = []const []const u8;

pub fn wireDependencies(
    b: *Build,
    compile: *Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    dependencies: DependencyList,
) void {
    for (dependencies) |dep_name| {
        wireSingleDependency(b, compile, target, optimize, dep_name);
    }
}

fn wireSingleDependency(
    b: *Build,
    compile: *Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    dep_name: []const u8,
) void {
    const dep = b.dependency(dep_name, .{
        .target = target,
        .optimize = optimize,
    });

    const module = dep.module(dep_name);
    compile.root_module.addImport(dep_name, module);
}

pub fn wireDependencyAs(
    b: *Build,
    compile: *Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    dep_name: []const u8,
    import_name: []const u8,
) void {
    const dep = b.dependency(dep_name, .{
        .target = target,
        .optimize = optimize,
    });

    const module = dep.module(dep_name);
    compile.root_module.addImport(import_name, module);
}

pub fn wireDependenciesWithArgs(
    b: *Build,
    compile: *Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    dependencies: DependencyList,
    args: anytype,
) void {
    for (dependencies) |dep_name| {
        wireSingleDependencyWithArgs(b, compile, target, optimize, dep_name, args);
    }
}

fn wireSingleDependencyWithArgs(
    b: *Build,
    compile: *Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    dep_name: []const u8,
    args: anytype,
) void {
    const dep = b.dependency(dep_name, .{
        .target = target,
        .optimize = optimize,
    });

    _ = args;
    const module = dep.module(dep_name);
    compile.root_module.addImport(dep_name, module);
}

test "dependency list type" {
    const deps: DependencyList = &.{ "foo", "bar" };
    try std.testing.expectEqual(@as(usize, 2), deps.len);
}
