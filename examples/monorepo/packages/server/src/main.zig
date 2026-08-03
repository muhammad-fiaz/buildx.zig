const std = @import("std");
const core = @import("core");

pub fn main() void {
    std.debug.print("Server app - Core value: {d}\n", .{core.coreFunction()});
}
