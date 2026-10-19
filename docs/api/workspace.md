---
title: "workspace()"
description: "API reference for buildx.workspace(): WorkspaceOptions, MemberConfig, and local package dependencies for monorepos."
head:
  - - meta
    - name: keywords
      content: "workspace(), WorkspaceOptions, MemberConfig, buildx.zig api, monorepo"
---

# workspace()

Create a workspace (monorepo) build system.

## Signature

```zig
pub fn workspace(b: *std.Build, options: WorkspaceOptions) Workspace
```

## WorkspaceOptions

```zig
pub const WorkspaceOptions = struct {
    members: []const MemberConfig = &.{},
};
```

## MemberConfig

```zig
pub const MemberConfig = struct {
    name: []const u8,
    path: []const u8,
    kind: MemberKind = .executable,
    root: ?[]const u8 = null,
    system_libs: SystemLibSet = &.{},
    local_deps: []const []const u8 = &.{},
    install: bool = false,
    tests: bool = false,
    run: bool = false,
};
```

## Workspace.build()

Build a member by name. Must build dependencies first.

```zig
pub fn build(ws: *Workspace, name: []const u8, overrides: ProjectOverrides) *Step.Compile
```

### ProjectOverrides

```zig
pub const ProjectOverrides = struct {
    root: ?[]const u8 = null,
    target: ?Build.ResolvedTarget = null,
    optimize: ?std.lang.Optimize = null,
};
```

## Example

```zig
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
    },
});

_ = ws.build("core", .{});
_ = ws.build("cli", .{});
```

## Generated Steps

Each member gets:

- `{name}:test` - Run tests for the member
- `{name}:run` - Run the executable
- `install` - Install all installed artifacts
