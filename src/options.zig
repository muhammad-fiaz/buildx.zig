const std = @import("std");
const Build = std.Build;

pub fn option(b: *Build, comptime T: type, name: []const u8, description: []const u8) ?T {
    return b.option(T, name, description);
}

pub fn optionWithDefault(b: *Build, comptime T: type, name: []const u8, description: []const u8, default: T) T {
    return b.option(T, name, description) orelse default;
}

pub fn boolOption(b: *Build, name: []const u8, description: []const u8, default: bool) bool {
    return b.option(bool, name, description) orelse default;
}

pub fn stringOption(b: *Build, name: []const u8, description: []const u8, default: []const u8) []const u8 {
    return b.option([]const u8, name, description) orelse default;
}

pub fn enumOption(b: *Build, comptime T: type, name: []const u8, description: []const u8) ?T {
    return b.option(T, name, description);
}

pub fn intOption(b: *Build, comptime T: type, name: []const u8, description: []const u8) ?T {
    return b.option(T, name, description);
}

pub fn floatOption(b: *Build, comptime T: type, name: []const u8, description: []const u8) ?T {
    return b.option(T, name, description);
}

pub fn pathOption(b: *Build, name: []const u8, description: []const u8) ?Build.LazyPath {
    return b.option(Build.LazyPath, name, description);
}

test "option functions exist" {
    _ = option;
    _ = optionWithDefault;
    _ = boolOption;
    _ = stringOption;
    _ = enumOption;
    _ = intOption;
    _ = floatOption;
    _ = pathOption;
}
