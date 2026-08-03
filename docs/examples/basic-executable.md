# Basic Executable

The simplest possible buildx.zig project.

## build.zig

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "hello",
        .root = "src/main.zig",
        .install = true,
    });
}
```

## src/main.zig

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello from buildx.zig!\n", .{});
}
```

## Build & Run

```bash
zig build
zig-out/bin/hello
```

Output:

```
Hello from buildx.zig!
```

## What Happens

- `install = true` creates an install step
- `zig build` compiles and installs to `zig-out/bin/hello`
- No run step - you execute the binary directly
