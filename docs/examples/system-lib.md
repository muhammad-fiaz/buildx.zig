---
title: "System Libraries"
description: "Link C system libraries with include and remove-link churn using the buildx.zig link field."
head:
  - - meta
    - name: keywords
      content: "system lib example, zig link system library, buildx.zig example"
---

# System Libraries

Link C system libraries.

## build.zig

```zig
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
```

## src/main.zig

```zig
const std = @import("std");

extern "c" fn sin(f64) f64;

pub fn main() void {
    const x = sin(1.0);
    std.debug.print("sin(1.0) = {d}\n", .{x});
}
```

## Build & Run

```bash
zig build
zig-out/bin/syslibapp
```

Output:

```
sin(1.0) = 0.8414709848078965
```

## What Happens

- `needs_libc = true` links libc automatically
- The `sin` function comes from libm, linked via libc
