const std = @import("std");

pub const VALUE: i32 = 42;

pub fn coreFunction() i32 {
    return VALUE;
}

test "core function" {
    try std.testing.expectEqual(@as(i32, 42), coreFunction());
}
