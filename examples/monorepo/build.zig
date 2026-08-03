const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    var ws = buildx.workspace(b, .{
        .members = &.{
            buildx.MemberConfig{
                .name = "core",
                .path = "packages/core",
                .kind = .library,
                .root = "packages/core/src/root.zig",
                .tests = true,
            },
            buildx.MemberConfig{
                .name = "cli",
                .path = "packages/cli",
                .kind = .executable,
                .local_deps = &.{"core"},
                .install = true,
                .run = true,
            },
            buildx.MemberConfig{
                .name = "server",
                .path = "packages/server",
                .kind = .executable,
                .local_deps = &.{"core"},
                .install = true,
                .tests = true,
            },
        },
    });

    _ = ws.build("core", .{});
    _ = ws.build("cli", .{});
    _ = ws.build("server", .{});
}
