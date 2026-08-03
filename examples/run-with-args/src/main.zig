const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello from run-with-args example!\n", .{});
    std.debug.print("Pass arguments with: zig build run -- arg1 arg2\n", .{});
}
