const std = @import("std");
const Build = std.Build;
const Step = Build.Step;

const plugins_mod = @import("plugins.zig");
const deps_mod = @import("dependencies.zig");

pub const ProjectOptions = struct {
    name: []const u8,
    root: []const u8,
    target: ?Build.ResolvedTarget = null,
    optimize: ?std.lang.Optimize = null,
    dependencies: deps_mod.DependencyList = &.{},
    install: bool = false,
    tests: bool = false,
    run: bool = false,
    docs: bool = false,
    test_root: ?[]const u8 = null,
    kind: Kind = .executable,
    linkage: ?std.lang.LinkMode = null,
    version: ?std.SemanticVersion = null,
    use_llvm: ?bool = null,
    use_lld: ?bool = null,
    cross: ?CrossConfig = null,
    link: plugins_mod.LinkConfig = .{},

    pub const Kind = enum {
        executable,
        library,
    };

    pub const CrossConfig = struct {
        targets: []const std.Target.Query = &.{},
        step_name: []const u8 = "cross",
        step_desc: []const u8 = "Cross compile for all targets",
    };
};

pub fn project(b: *Build, options: ProjectOptions) *Step.Compile {
    const target = options.target orelse getCachedTarget(b);
    const optimize = options.optimize orelse getCachedOptimize(b);

    const root_module = b.createModule(.{
        .root_source_file = b.path(options.root),
        .target = target,
        .optimize = optimize,
    });

    const compile = switch (options.kind) {
        .executable => b.addExecutable(.{
            .name = options.name,
            .root_module = root_module,
            .version = options.version,
            .linkage = options.linkage,
            .use_llvm = options.use_llvm,
            .use_lld = options.use_lld,
        }),
        .library => b.addLibrary(.{
            .name = options.name,
            .root_module = root_module,
            .version = options.version,
            .linkage = options.linkage orelse .static,
            .use_llvm = options.use_llvm,
            .use_lld = options.use_lld,
        }),
    };

    plugins_mod.applyLinkConfig(b, compile, options.link);
    deps_mod.wireDependencies(b, compile, target, optimize, options.dependencies);

    if (options.install) {
        b.installArtifact(compile);
    }

    if (options.tests) {
        const test_root = options.test_root orelse options.root;
        const test_module = b.createModule(.{
            .root_source_file = b.path(test_root),
            .target = target,
            .optimize = optimize,
        });
        const test_exe = b.addTest(.{ .root_module = test_module });
        const run_test = b.addRunArtifact(test_exe);
        const test_step = b.step("test", "Run tests");
        test_step.dependOn(&run_test.step);
    }

    if (options.run) {
        const run_cmd = b.addRunArtifact(compile);
        run_cmd.step.dependOn(b.getInstallStep());
        run_cmd.addPassthruArgs();
        const run_step = b.step("run", "Run the app");
        run_step.dependOn(&run_cmd.step);
    }

    if (options.docs) {
        const docs_module = b.createModule(.{
            .root_source_file = b.path(options.root),
            .target = target,
            .optimize = optimize,
        });
        const docs_exe = b.addExecutable(.{
            .name = b.fmt("{s}-docs", .{options.name}),
            .root_module = docs_module,
        });
        _ = docs_exe.getEmittedDocs();
        const docs_step = b.step("docs", "Generate documentation");
        docs_step.dependOn(b.getInstallStep());
    }

    if (options.cross) |cross_cfg| {
        crossCompile(b, compile, cross_cfg);
    }

    return compile;
}

pub fn crossCompile(b: *Build, compile: *Step.Compile, cfg: ProjectOptions.CrossConfig) void {
    const app_name = compile.name;
    const root_file = compile.root_module.root_source_file orelse
        @panic("compile step must have a root source file");
    const optimize = compile.root_module.optimize orelse .debug;

    const cross_step = b.step(cfg.step_name, cfg.step_desc);

    for (cfg.targets) |query| {
        const resolved = b.resolveTargetQuery(query);
        const cross_module = b.createModule(.{
            .root_source_file = root_file,
            .target = resolved,
            .optimize = optimize,
        });
        const cross_exe = b.addExecutable(.{
            .name = b.fmt("{s}-{s}", .{ app_name, @tagName(query.cpu_arch orelse .x86_64) }),
            .root_module = cross_module,
        });
        const install = b.addInstallArtifact(cross_exe, .{});
        cross_step.dependOn(&install.step);
    }
}

var cached_target: ?Build.ResolvedTarget = null;
var cached_optimize: ?std.lang.Optimize = null;

fn getCachedTarget(b: *Build) Build.ResolvedTarget {
    if (cached_target) |t| return t;
    cached_target = b.standardTargetOptions(.{});
    return cached_target.?;
}

fn getCachedOptimize(b: *Build) std.lang.Optimize {
    if (cached_optimize) |o| return o;
    cached_optimize = b.standardOptimizeOption(.{});
    return cached_optimize.?;
}

test "project options defaults" {
    const opts = ProjectOptions{
        .name = "test",
        .root = "src/main.zig",
    };
    try std.testing.expectEqualStrings("test", opts.name);
    try std.testing.expectEqualStrings("src/main.zig", opts.root);
    try std.testing.expect(opts.target == null);
    try std.testing.expect(opts.optimize == null);
    try std.testing.expectEqual(@as(usize, 0), opts.dependencies.len);
    try std.testing.expectEqual(false, opts.install);
    try std.testing.expectEqual(false, opts.tests);
    try std.testing.expectEqual(false, opts.run);
    try std.testing.expectEqual(false, opts.docs);
    try std.testing.expect(opts.cross == null);
}
