---
title: "Monorepo"
description: "Multi-package buildx.zig workspace example with local dependencies between packages."
head:
  - - meta
    - name: keywords
      content: "monorepo example, workspace example, buildx.zig example, local dependencies"
---

# Monorepo

Multi-package workspace with local dependencies.

## Directory Structure

```
monorepo/
  build.zig
  build.zig.zon
  packages/
    core/
      src/root.zig
    cli/
      src/main.zig
    server/
      src/main.zig
```

## build.zig

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    var ws = buildx.workspace(b, .{
        .members = &.{
            buildx.MemberConfig{
                .name = "core",
                .path = "packages/core",
                .kind = .library,
                .root = "packages/core/src/root.zig",
                .tests = true,
            },
            buildx.MemberConfig{
                .name = "cli",
                .path = "packages/cli",
                .kind = .executable,
                .local_deps = &.{"core"},
                .install = true,
                .run = true,
            },
            buildx.MemberConfig{
                .name = "server",
                .path = "packages/server",
                .kind = .executable,
                .local_deps = &.{"core"},
                .install = true,
                .tests = true,
            },
        },
    });

    _ = ws.build("core", .{});
    _ = ws.build("cli", .{});
    _ = ws.build("server", .{});
}
```

## packages/core/src/root.zig

```zig
pub const VALUE: i32 = 42;

pub fn coreFunction() i32 {
    return VALUE;
}
```

## packages/cli/src/main.zig

```zig
const std = @import("std");
const core = @import("core");

pub fn main() void {
    std.debug.print("CLI app - Core value: {d}\n", .{core.coreFunction()});
}
```

## Build Steps

```bash
zig build              # Build all installable members
zig build core:test    # Run core tests
zig build cli:run      # Run CLI
zig build server:test  # Run server tests
```

## Key Points

- Build order matters: build `core` before `cli` and `server`
- `local_deps` links the compiled module from another member
- Each member gets `{name}:test` and `{name}:run` steps
