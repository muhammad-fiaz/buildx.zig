# Quick Start

buildx.zig wraps `std.Build` with a single `project()` function. One call sets up compilation, installation, testing, and running.

> [!IMPORTANT]
> buildx.zig is **not a replacement** for `std.Build`. It is an enhancement that simplifies your `build.zig` with a high-level API while giving you full access to `std.Build` when you need explicit customization.

## Installation

Add buildx.zig as a dependency in your `build.zig.zon`:

```zig
.{
    .name = .myapp,
    .version = "0.1.0",
    .fingerprint = 0x...,
    .dependencies = .{
        .buildx = .{
            .path = "/path/to/buildx.zig",
        },
    },
    .paths = .{
        "build.zig",
        "build.zig.zon",
        "src",
    },
}
```

## Minimal build.zig

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

This gives you:

- `zig build` - compile the executable
- `zig build install` - install to `zig-out/bin/`

> [!TIP]
> The `project()` function returns `*std.Build.Step.Compile`. You can use it for further customization with `std.Build` APIs.

## Build Options

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `name` | `[]const u8` | required | Output artifact name |
| `root` | `[]const u8` | required | Root source file path |
| `kind` | `Kind` | `.executable` | `.executable` or `.library` |
| `install` | `bool` | `false` | Add install step |
| `run` | `bool` | `false` | Add run step |
| `tests` | `bool` | `false` | Add test step |
| `target` | `?ResolvedTarget` | `null` | Override target (defaults to `-Dtarget`) |
| `optimize` | `?OptimizeMode` | `null` | Override optimize (defaults to `-Doptimize`) |
| `link` | `LinkConfig` | `.{}` | Linking configuration |
| `version` | `?SemanticVersion` | `null` | Semantic version for the artifact |
| `linkage` | `?LinkMode` | `.static` | Library only: `.static` or `.dynamic` |

## Library with Tests

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

This gives you `zig build test`.

## Run Step

```zig
_ = buildx.project(b, .{
    .name = "app",
    .root = "src/main.zig",
    .install = true,
    .run = true,
});
```

Run with `zig build run`. Pass arguments: `zig build run -- --flag value`.

## Cross Compilation

```zig
_ = buildx.project(b, .{
    .name = "app",
    .root = "src/main.zig",
    .cross = .{
        .targets = buildx.targets.desktop(),
    },
});
```

Run with `zig build cross`. See [Cross Compilation](/guide/cross-compile) for all target presets.

## System Libraries and Linking

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .include_paths = &.{"vendor/include"},
        .lib_paths = &.{"vendor/lib"},
        .system_libs = &.{
            .{ .name = "ssl", .needs_libc = true },
        },
        .frameworks = &.{"CoreFoundation"},
        .link_libc = true,
    },
    .install = true,
});
```

> [!NOTE]
> Frameworks are macOS system libraries like `CoreFoundation`, `Security`, `IOKit`. They are linked via `-framework` flag. Use `.frameworks` only when targeting macOS.

## Next Steps

- [Cross Compilation](/guide/cross-compile) - Build for multiple platforms
- [Workspaces](/guide/workspace) - Monorepo support
- [System Libraries](/guide/system-libs) - Link C libraries
- [Custom Options](/guide/options) - Build-time configuration
