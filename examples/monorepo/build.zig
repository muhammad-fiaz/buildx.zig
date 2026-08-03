const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    var ws = buildx.workspace(b, .{
        .members = &.{
            buildx.MemberConfig.lib("core", "packages/core").with(.{ .tests = true }),
            buildx.MemberConfig.exe("cli", "packages/cli").with(.{ .local_deps = &.{"core"}, .install = true, .run = true }),
            buildx.MemberConfig.exe("server", "packages/server").with(.{ .local_deps = &.{"core"}, .install = true, .tests = true }),
        },
    });

    _ = ws.build("core", .{});
    _ = ws.build("cli", .{});
    _ = ws.build("server", .{});
}
