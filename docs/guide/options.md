# Custom Options

Define build-time options with `buildx.boolOption()`, `buildx.stringOption()`, and `buildx.option()`.

## Boolean Options

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    const enable_feature = buildx.boolOption(b, "enable-feature", "Enable optional feature", false);

    std.debug.print("Feature enabled: {}\n", .{enable_feature});

    _ = buildx.project(b, .{
        .name = "myapp",
        .root = "src/main.zig",
        .install = true,
    });
}
```

Usage:

```bash
zig build                          # Feature disabled (default)
zig build -Denable-feature=true    # Feature enabled
```

## String Options

```zig
const version = buildx.stringOption(b, "app-version", "Application version", "1.0.0");
std.debug.print("Version: {s}\n", .{version});
```

```bash
zig build                           # Uses "1.0.0"
zig build -Dapp-version=2.0.0       # Uses "2.0.0"
```

## Typed Options

```zig
// Generic typed option (returns optional)
const port = buildx.option(b, u16, "port", "Server port");
const actual_port = port orelse 8080;

// With default
const count = buildx.optionWithDefault(b, u32, "count", "Item count", 10);
```

## Option Functions

| Function | Signature | Description |
|----------|-----------|-------------|
| `boolOption` | `(b, name, desc, default) bool` | Boolean with default |
| `stringOption` | `(b, name, desc, default) []const u8` | String with default |
| `option` | `(b, T, name, desc) ?T` | Generic, returns optional |
| `optionWithDefault` | `(b, T, name, desc, default) T` | Generic with default |

## Using Options in Source Code

Options are build-time only. Pass them via build-time constants:

```zig
// build.zig
const enable_debug = buildx.boolOption(b, "debug-output", "Enable debug output", false);
// You'd need to pass this to source via a generated file or module option
```
