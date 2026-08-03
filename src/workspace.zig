const std = @import("std");
const Build = std.Build;
const Step = Build.Step;

const plugins_mod = @import("plugins.zig");
const deps_mod = @import("dependencies.zig");
const project_mod = @import("project.zig");

pub const WorkspaceOptions = struct {
    members: []const MemberConfig = &.{},
};

pub const MemberConfig = struct {
    name: []const u8,
    path: []const u8,
    kind: MemberKind = .executable,
    root: ?[]const u8 = null,
    system_libs: plugins_mod.SystemLibSet = &.{},
    local_deps: []const []const u8 = &.{},
    install: bool = false,
    tests: bool = false,
    run: bool = false,

    pub fn exe(name: []const u8, path: []const u8) MemberConfig {
        return .{ .name = name, .path = path, .kind = .executable };
    }

    pub fn lib(name: []const u8, path: []const u8) MemberConfig {
        return .{ .name = name, .path = path, .kind = .library };
    }

    pub fn with(self: MemberConfig, overrides: struct {
        root: ?[]const u8 = null,
        system_libs: plugins_mod.SystemLibSet = &.{},
        local_deps: []const []const u8 = &.{},
        install: bool = false,
        tests: bool = false,
        run: bool = false,
    }) MemberConfig {
        var result = self;
        if (overrides.root) |r| result.root = r;
        if (overrides.system_libs.len > 0) result.system_libs = overrides.system_libs;
        if (overrides.local_deps.len > 0) result.local_deps = overrides.local_deps;
        if (overrides.install) result.install = true;
        if (overrides.tests) result.tests = true;
        if (overrides.run) result.run = true;
        return result;
    }
};

pub const MemberKind = enum {
    executable,
    library,
};

pub const Workspace = struct {
    b: *Build,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    members: std.ArrayList(*Member),
    built: std.StringHashMap(*Step.Compile),

    pub const Member = struct {
        name: []const u8,
        path: []const u8,
        kind: MemberKind,
        root: ?[]const u8,
        system_libs: plugins_mod.SystemLibSet,
        local_deps: []const []const u8,
        install: bool,
        tests: bool,
        run: bool,
        compile: ?*Step.Compile = null,
    };

    pub fn build(ws: *Workspace, name: []const u8, overrides: ProjectOverrides) *Step.Compile {
        const b = ws.b;
        const member = ws.findMember(name) orelse
            @panic(b.fmt("workspace member '{s}' not found", .{name}));

        const target = overrides.target orelse ws.target;
        const optimize = overrides.optimize orelse ws.optimize;

        const root_file = overrides.root orelse member.root orelse switch (member.kind) {
            .library => b.fmt("{s}/src/root.zig", .{member.path}),
            .executable => b.fmt("{s}/src/main.zig", .{member.path}),
        };

        const root_module = b.createModule(.{
            .root_source_file = b.path(root_file),
            .target = target,
            .optimize = optimize,
        });

        const compile = switch (member.kind) {
            .executable => b.addExecutable(.{
                .name = member.name,
                .root_module = root_module,
            }),
            .library => b.addLibrary(.{
                .name = member.name,
                .root_module = root_module,
            }),
        };

        plugins_mod.applySystemLibs(b, compile, member.system_libs);

        for (member.local_deps) |local_dep_name| {
            if (ws.built.get(local_dep_name)) |local_compile| {
                compile.root_module.addImport(local_dep_name, local_compile.root_module);
            } else {
                @panic(b.fmt("local dependency '{s}' has not been built yet. Build it first.", .{local_dep_name}));
            }
        }

        if (member.install) {
            b.installArtifact(compile);
        }

        if (member.tests) {
            const test_module = b.createModule(.{
                .root_source_file = b.path(root_file),
                .target = target,
                .optimize = optimize,
            });
            const test_exe = b.addTest(.{ .root_module = test_module });
            const run_test = b.addRunArtifact(test_exe);
            const test_step = b.step(
                b.fmt("{s}:test", .{member.name}),
                b.fmt("Run tests for {s}", .{member.name}),
            );
            test_step.dependOn(&run_test.step);
        }

        if (member.run) {
            const run_cmd = b.addRunArtifact(compile);
            run_cmd.step.dependOn(b.getInstallStep());
            if (b.args) |args| run_cmd.addArgs(args);
            const run_step = b.step(
                b.fmt("{s}:run", .{member.name}),
                b.fmt("Run {s}", .{member.name}),
            );
            run_step.dependOn(&run_cmd.step);
        }

        member.compile = compile;
        ws.built.put(name, compile) catch @panic("OOM");
        return compile;
    }

    fn findMember(ws: *Workspace, name: []const u8) ?*Member {
        for (ws.members.items) |member| {
            if (std.mem.eql(u8, member.name, name)) return member;
        }
        return null;
    }
};

pub fn workspace(b: *Build, options: WorkspaceOptions) Workspace {
    var ws = Workspace{
        .b = b,
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
        .members = .empty,
        .built = std.StringHashMap(*Step.Compile).init(b.allocator),
    };

    for (options.members) |mc| {
        const member = b.allocator.create(Workspace.Member) catch @panic("OOM");
        member.* = .{
            .name = mc.name,
            .path = mc.path,
            .kind = mc.kind,
            .root = mc.root,
            .system_libs = mc.system_libs,
            .local_deps = mc.local_deps,
            .install = mc.install,
            .tests = mc.tests,
            .run = mc.run,
        };
        ws.members.append(b.allocator, member) catch @panic("OOM");
    }

    return ws;
}

pub const ProjectOverrides = struct {
    root: ?[]const u8 = null,
    target: ?Build.ResolvedTarget = null,
    optimize: ?std.builtin.OptimizeMode = null,
};

test "workspace" {
    _ = workspace;
    _ = Workspace;
    _ = ProjectOverrides;
}
