# Workspaces

buildx.zig supports monorepo projects with local dependencies between packages.

## Setup

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    var ws = buildx.workspace(b, .{
        .members = &.{
            buildx.MemberConfig.lib("core", "packages/core").with(.{ .tests = true }),
            buildx.MemberConfig.exe("cli", "packages/cli").with(.{ .local_deps = &.{"core"}, .install = true, .run = true }),
            buildx.MemberConfig.exe("server", "packages/server").with(.{ .local_deps = &.{"core"}, .install = true, .tests = true }),
        },
    });

    _ = ws.build("core", .{});
    _ = ws.build("cli", .{});
    _ = ws.build("server", .{});
}
```

::: warning
Build order matters. Build dependencies before dependants. If `cli` depends on `core`, build `core` first.
:::

## Convenience Constructors

| Constructor | Description |
|-------------|-------------|
| `MemberConfig.exe(name, path)` | Create an executable member |
| `MemberConfig.lib(name, path)` | Create a library member |
| `.with(overrides)` | Chain additional options (install, tests, run, local_deps, etc.) |

## MemberConfig Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `name` | `[]const u8` | required | Package name |
| `path` | `[]const u8` | required | Relative path to package directory |
| `kind` | `MemberKind` | `.executable` | `.executable` or `.library` |
| `root` | `?[]const u8` | `null` | Override root file (defaults to `{path}/src/main.zig` for exe, `{path}/src/root.zig` for lib) |
| `system_libs` | `SystemLibSet` | `&.{}` | System libraries to link |
| `local_deps` | `[]const []const u8` | `&.{}` | Local workspace dependencies |
| `install` | `bool` | `false` | Add install step |
| `tests` | `bool` | `false` | Add test step |
| `run` | `bool` | `false` | Add run step |

## Build Steps

Each member gets namespaced steps:

- `zig build core:test` - Run core tests
- `zig build cli:run` - Run CLI app
- `zig build server:run` - Run server
- `zig build install` - Install all artifacts

## ProjectOverrides

Override target/optimize per member:

```zig
_ = ws.build("cli", .{
    .target = b.resolveTargetQuery(.{ .cpu_arch = .aarch64, .os_tag = .linux }),
    .optimize = .ReleaseSafe,
});
```
