const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "argsapp",
        .root = "src/main.zig",
        .install = true,
        .run = true,
    });
}
