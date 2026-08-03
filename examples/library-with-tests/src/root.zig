const std = @import("std");

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn multiply(a: i32, b: i32) i32 {
    return a * b;
}

test "add" {
    try std.testing.expectEqual(@as(i32, 5), add(2, 3));
    try std.testing.expectEqual(@as(i32, 0), add(0, 0));
}

test "multiply" {
    try std.testing.expectEqual(@as(i32, 6), multiply(2, 3));
    try std.testing.expectEqual(@as(i32, 0), multiply(0, 5));
}
