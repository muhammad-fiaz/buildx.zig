---
title: "Library with Tests"
description: "buildx.zig library example with kind=library and a built-in test step."
head:
  - - meta
    - name: keywords
      content: "library example, buildx.zig example, test step, zig build test"
---

# Library with Tests

A library project with a test suite.

## build.zig

```zig
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
```

## src/root.zig

```zig
pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "add" {
    try std.testing.expectEqual(@as(i32, 5), add(2, 3));
}
```

## Build & Test

```bash
zig build test
```

Output:

```
All tests passed.
```

## Key Points

- `kind = .library` creates a library instead of executable
- `tests = true` adds a `test` step that compiles and runs tests
- The test step uses the same source file by default
