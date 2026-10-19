---
title: "Cross Compilation"
description: "Cross-compile an executable for the full desktop target matrix with one build.zig file."
head:
  - - meta
    - name: keywords
      content: "cross compile example, buildx.zig example, desktop targets, zig build cross"
---

# Cross Compilation

Build for all platforms with one config.

## build.zig

```zig
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
```

## src/main.zig

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Cross-compiled app\n", .{});
}
```

## Build

```bash
zig build cross
```

## Output

```
zig-out/bin/crossapp-x86_64-windows.exe
zig-out/bin/crossapp-x86_64-linux
zig-out/bin/crossapp-aarch64-linux
zig-out/bin/crossapp-aarch64-macos
```

## Variations

### All platforms

```zig
.cross = .{
    .targets = buildx.targets.all(),
},
```

### Linux only

```zig
.cross = .{
    .targets = buildx.targets.linux(),
},
```

### Custom targets

```zig
.cross = .{
    .targets = &.{
        .{ .cpu_arch = .x86_64, .os_tag = .linux },
        .{ .cpu_arch = .aarch64, .os_tag = .linux },
    },
    .step_name = "linux-cross",
    .step_desc = "Build for Linux",
},
```
