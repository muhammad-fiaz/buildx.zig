# crossCompile()

Cross-compile a project for multiple targets.

## Signature

```zig
pub fn crossCompile(b: *std.Build, compile: *Step.Compile, cfg: CrossConfig) void
```

## CrossConfig

```zig
pub const CrossConfig = struct {
    targets: []const std.Target.Query = &.{},
    step_name: []const u8 = "cross",
    step_desc: []const u8 = "Cross compile for all targets",
};
```

## Usage

### Via ProjectOptions (recommended)

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .cross = .{
        .targets = buildx.targets.desktop(),
    },
});
```

### Standalone

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
});

buildx.crossCompile(b, exe, .{
    .targets = &.{
        .{ .cpu_arch = .x86_64, .os_tag = .linux },
        .{ .cpu_arch = .aarch64, .os_tag = .linux },
    },
});
```

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

## Output

Artifacts are placed in `zig-out/bin/` with triple suffixes:

```
zig-out/bin/myapp-x86_64-linux
zig-out/bin/myapp-aarch64-linux
zig-out/bin/myapp-x86_64-windows.exe
```
