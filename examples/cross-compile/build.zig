const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "crossapp",
        .root = "src/main.zig",
        .cross = .{
            .targets = buildx.targets.desktop(),
        },
    });
}
