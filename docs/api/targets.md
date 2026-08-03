# Targets

Pre-defined target lists for cross-compilation.

## Target Presets

### all()

All OS + all architectures. 216 targets.

```zig
buildx.targets.all()
```

OS: Windows, Linux, macOS, FreeBSD, NetBSD, OpenBSD, UEFI, WASI, Emscripten, iOS, tvOS, watchOS.
Architectures: x86, x86_64, ARM, AArch64, RISC-V (32/64), MIPS (32/64), PowerPC (32/64), SPARC64, S390x, WASM (32/64), Hexagon, LoongArch64, Thumb.

### desktop()

Desktop platforms only. 6 targets.

```zig
buildx.targets.desktop()
```

Windows/Linux/macOS on x86_64 and aarch64.

### linux()

Linux only. 16 targets.

```zig
buildx.targets.linux()
```

x86, x86_64, ARM, AArch64, RISC-V (32/64), MIPS (32/64), PowerPC (32/64), SPARC64, S390x, LoongArch64.

### windows()

Windows only. 4 targets.

```zig
buildx.targets.windows()
```

x86, x86_64, ARM, AArch64.

### macos()

macOS only. 2 targets.

```zig
buildx.targets.macos()
```

x86_64 and aarch64 (Apple Silicon).

### arm()

ARM architectures across all OS. 24 targets.

```zig
buildx.targets.arm()
```

ARM and AArch64 across all supported OS.

### riscv()

RISC-V architectures. 2 targets.

```zig
buildx.targets.riscv()
```

RISC-V 32-bit and 64-bit on Linux.

### freestanding()

No OS. 8 targets.

```zig
buildx.targets.freestanding()
```

x86, x86_64, ARM, AArch64, RISC-V (32/64), WASM (32/64).

### wasm()

WebAssembly. 2 targets.

```zig
buildx.targets.wasm()
```

wasm32 and wasm64 on WASI.

### allArchitectures()

All CPU architectures. 21 targets.

```zig
buildx.targets.allArchitectures()
```

## Custom Targets

Pass your own target queries:

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .cross = .{
        .targets = &.{
            .{ .cpu_arch = .x86_64, .os_tag = .linux },
            .{ .cpu_arch = .aarch64, .os_tag = .macos },
        },
    },
});
```

## Available Architectures

| Architecture | Description |
|-------------|-------------|
| `x86` | 32-bit x86 |
| `x86_64` | 64-bit x86 |
| `arm` | 32-bit ARM |
| `aarch64` | 64-bit ARM (ARMv8) |
| `riscv32` | 32-bit RISC-V |
| `riscv64` | 64-bit RISC-V |
| `mips` | 32-bit MIPS (big endian) |
| `mipsel` | 32-bit MIPS (little endian) |
| `mips64` | 64-bit MIPS (big endian) |
| `mips64el` | 64-bit MIPS (little endian) |
| `powerpc` | 32-bit PowerPC |
| `powerpc64` | 64-bit PowerPC (big endian) |
| `powerpc64le` | 64-bit PowerPC (little endian) |
| `sparc64` | 64-bit SPARC |
| `s390x` | IBM System/390 |
| `wasm32` | 32-bit WebAssembly |
| `wasm64` | 64-bit WebAssembly |
| `hexagon` | Qualcomm Hexagon |
| `loongarch64` | 64-bit LoongArch |
| `thumb` | ARM Thumb mode |

## Available OS Tags

| OS Tag | Description |
|--------|-------------|
| `windows` | Windows |
| `linux` | Linux |
| `macos` | macOS |
| `freebsd` | FreeBSD |
| `netbsd` | NetBSD |
| `openbsd` | OpenBSD |
| `uefi` | UEFI firmware |
| `wasi` | WebAssembly System Interface |
| `emscripten` | Emscripten |
| `ios` | iOS |
| `tvos` | tvOS |
| `watchos` | watchOS |
| `freestanding` | No OS |
