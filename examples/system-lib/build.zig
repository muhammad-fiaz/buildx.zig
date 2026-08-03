const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "syslibapp",
        .root = "src/main.zig",
        .link = .{
            .system_libs = &.{
                .{ .name = "m", .needs_libc = true },
            },
        },
        .install = true,
    });
}
