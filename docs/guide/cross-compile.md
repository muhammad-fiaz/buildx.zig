---
title: "Cross Compilation"
description: "Cross-compile Zig projects for all platforms with the buildx.zig cross configuration and target presets."
head:
  - - meta
    - name: keywords
      content: "zig cross compilation, buildx.zig cross, target presets, aarch64, x86_64, wasm, freestanding"
---

# Cross Compilation

buildx.zig supports cross-compilation via the `cross` field in `ProjectOptions`.

## Basic Usage

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "myapp",
        .root = "src/main.zig",
        .cross = .{
            .targets = buildx.targets.all(),
        },
    });
}
```

Run with `zig build cross`.

## Target Presets

| Preset | Targets | Description |
|--------|---------|-------------|
| `targets.all()` | 216 | All OS + all architectures |
| `targets.desktop()` | 6 | Windows/Linux/macOS, x86_64 + aarch64 |
| `targets.linux()` | 16 | Linux, all architectures |
| `targets.windows()` | 4 | Windows, x86/x64/ARM/AArch64 |
| `targets.macos()` | 2 | macOS, x86_64 + aarch64 |
| `targets.arm()` | 24 | ARM/AArch64 across all OS |
| `targets.riscv()` | 2 | RISC-V 32/64 on Linux |
| `targets.freestanding()` | 8 | No OS, all architectures |
| `targets.wasm()` | 2 | WebAssembly 32/64 on WASI |
| `targets.allArchitectures()` | 21 | All CPU architectures |

## Custom Target List

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .cross = .{
        .targets = &.{
            .{ .cpu_arch = .x86_64, .os_tag = .linux },
            .{ .cpu_arch = .aarch64, .os_tag = .linux },
            .{ .cpu_arch = .x86_64, .os_tag = .windows },
        },
        .step_name = "release-cross",
        .step_desc = "Build release binaries for Linux and Windows",
    },
});
```

## Standalone crossCompile

You can also call `crossCompile` directly on an existing compile step:

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
});

buildx.crossCompile(b, exe, .{
    .targets = buildx.targets.desktop(),
});
```

## Output

Cross-compiled artifacts are placed in `zig-out/bin/` with triple suffixes:

```
zig-out/bin/myapp-x86_64-linux
zig-out/bin/myapp-aarch64-linux
zig-out/bin/myapp-x86_64-windows.exe
```
