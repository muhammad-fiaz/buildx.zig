const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "math",
        .root = "src/root.zig",
        .kind = .library,
        .tests = true,
    });
}
