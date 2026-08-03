# Run with Args

Executable with a run step.

## build.zig

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "argsapp",
        .root = "src/main.zig",
        .install = true,
        .run = true,
    });
}
```

## src/main.zig

```zig
const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello from run-with-args example!\n", .{});
    std.debug.print("Pass arguments with: zig build run -- arg1 arg2\n", .{});
}
```

## Usage

```bash
zig build run
```

Output:

```
Hello from run-with-args example!
Pass arguments with: zig build run -- arg1 arg2
```

## Key Points

- `run = true` creates a `run` step
- `zig build run` compiles and runs the executable
- Pass arguments: `zig build run -- --flag value`
