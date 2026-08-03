<div align="center">

<img  height="250" alt="image logo" src="https://github.com/user-attachments/assets/03c360c9-7609-4222-8c0a-76694ed14794" />


<a href="https://muhammad-fiaz.github.io/buildx.zig/"><img src="https://img.shields.io/badge/docs-muhammad--fiaz.github.io-blue" alt="Documentation"></a>
<a href="https://ziglang.org/"><img src="https://img.shields.io/badge/Zig-0.16.0+-orange.svg?logo=zig" alt="Zig Version"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig"><img src="https://img.shields.io/github/stars/muhammad-fiaz/buildx.zig" alt="GitHub stars"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig/issues"><img src="https://img.shields.io/github/issues/muhammad-fiaz/buildx.zig" alt="GitHub issues"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig/pulls"><img src="https://img.shields.io/github/issues-pr/muhammad-fiaz/buildx.zig" alt="GitHub pull requests"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig"><img src="https://img.shields.io/github/last-commit/muhammad-fiaz/buildx.zig" alt="GitHub last commit"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig"><img src="https://img.shields.io/github/license/muhammad-fiaz/buildx.zig" alt="License"></a>
<a href="https://github.com/muhammad-fiaz/buildx.zig/actions/workflows/ci.yml"><img src="https://github.com/muhammad-fiaz/buildx.zig/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
<img src="https://img.shields.io/badge/platforms-linux%20%7C%20windows%20%7C%20macos-blue" alt="Supported Platforms">
<a href="https://github.com/muhammad-fiaz/buildx.zig/releases/latest"><img src="https://img.shields.io/github/v/release/muhammad-fiaz/buildx.zig?label=Latest%20Release&style=flat-square" alt="Latest Release"></a>
<a href="https://github.com/sponsors/muhammad-fiaz"><img src="https://img.shields.io/badge/Sponsor-GitHub-pink?style=social&logo=github" alt="GitHub Sponsors"></a>
<a href="https://hits.sh/muhammad-fiaz/buildx.zig/"><img src="https://hits.sh/muhammad-fiaz/buildx.zig.svg?label=Visitors&extraCount=0&color=green" alt="Repo Visitors"></a>

<p><em>A minimal, efficient build system library for Zig</em></p>

<b><a href="https://muhammad-fiaz.github.io/buildx.zig/">Documentation</a> |
<a href="https://muhammad-fiaz.github.io/buildx.zig/api/project">API Reference</a> |
<a href="https://muhammad-fiaz.github.io/buildx.zig/guide/quick-start">Quick Start</a> |
<a href="CONTRIBUTING.md">Contributing</a></b>

</div>

`buildx.zig` is a minimal build system library for Zig that wraps `std.Build` with a single `project()` function. One call sets up compilation, installation, testing, and running - with full access to the underlying `std.Build` when you need more.

> [!IMPORTANT]
> **buildx.zig is not a replacement for `std.Build`.** It is an enhancement that simplifies your `build.zig` with a high-level API while giving you full access to `std.Build` for explicit customization. Use buildx.zig for common patterns, and drop down to `std.Build` when you need more control.

> [!TIP]
> If you build with buildx.zig, make sure to give it a star.

> [!NOTE]
> **Project maturity:** This project aims to be production-ready and is actively maintained. It is still a new project and not yet widely adopted. Feel free to use it in your projects.

**Related Zig projects:**

- For env.zig (.env parsing), check out [env.zig](https://github.com/muhammad-fiaz/env.zig).
- For TUI support, check out [tui.zig](https://github.com/muhammad-fiaz/tui.zig).
- For ZON file format support, check out [zon.zig](https://github.com/muhammad-fiaz/zon.zig).
- For spinners/loading/progress bar support, check out [loaders.zig](https://github.com/muhammad-fiaz/loaders.zig).
- For MCP support, check out [mcp.zig](https://github.com/muhammad-fiaz/mcp.zig).
- For args parsing support, check out [args.zig](https://github.com/muhammad-fiaz/args.zig).
- For HTTP client/server support, check out [httpx.zig](https://github.com/muhammad-fiaz/httpx.zig).
- For API framework support, check out [api.zig](https://github.com/muhammad-fiaz/api.zig).
- For web framework support, check out [zix](https://github.com/muhammad-fiaz/zix).
- For archive/compression support, check out [archive.zig](https://github.com/muhammad-fiaz/archive.zig).
- For compression file format support, check out [zigx](https://github.com/muhammad-fiaz/zigx).
- For file downloading support, check out [downloader.zig](https://github.com/muhammad-fiaz/downloader.zig).
- For update checker/auto-updater support, check out [updater.zig](https://github.com/muhammad-fiaz/updater.zig).
- For numerical computing support, check out [num.zig](https://github.com/muhammad-fiaz/num.zig).
- For logging support, check out [logly.zig](https://github.com/muhammad-fiaz/logly.zig).
- For data validation and serialization support, check out [zigantic](https://github.com/muhammad-fiaz/zigantic).
- For CUDA support, check out [cuda.zig](https://github.com/muhammad-fiaz/cuda.zig).

---

<details>
<summary><strong>Features</strong> (click to expand)</summary>

| Feature | Description | Documentation |
|---------|-------------|---------------|
| **Minimal API** | One function to create a project. No boilerplate, no complexity. | https://muhammad-fiaz.github.io/buildx.zig/api/project |
| **Full std.Build Access** | Returns `*Step.Compile` for complete customization with std.Build. | https://muhammad-fiaz.github.io/buildx.zig/guide/std-integration |
| **Cross Compilation** | Build for all platforms with a single config object. 216 targets. | https://muhammad-fiaz.github.io/buildx.zig/guide/cross-compile |
| **Workspace Support** | Monorepo support with local dependencies between packages. | https://muhammad-fiaz.github.io/buildx.zig/guide/workspace |
| **System Libraries** | Link C/C++ system libraries with automatic libc/libcpp handling. | https://muhammad-fiaz.github.io/buildx.zig/guide/system-libs |
| **Include/Library Paths** | Add -I and -L paths directly in ProjectOptions. | https://muhammad-fiaz.github.io/buildx.zig/guide/system-libs |
| **Frameworks** | Link macOS frameworks (CoreFoundation, Security, etc). | https://muhammad-fiaz.github.io/buildx.zig/guide/system-libs |
| **C Macros** | Define C preprocessor macros directly. | https://muhammad-fiaz.github.io/buildx.zig/guide/system-libs |
| **Custom Options** | Define build-time options with type-safe defaults. | https://muhammad-fiaz.github.io/buildx.zig/guide/options |
| **Library Support** | Create static/dynamic libraries with test suites. | https://muhammad-fiaz.github.io/buildx.zig/api/project |
| **Test Integration** | Built-in test step creation for executables and libraries. | https://muhammad-fiaz.github.io/buildx.zig/guide/quick-start |
| **Run Step** | Add a run step with argument passthrough. | https://muhammad-fiaz.github.io/buildx.zig/guide/quick-start |
| **Doc Generation** | Generate documentation for your project. | https://muhammad-fiaz.github.io/buildx.zig/api/project |
| **Target Presets** | Pre-defined target lists: all, desktop, linux, windows, macos, arm, riscv, freestanding, wasm. | https://muhammad-fiaz.github.io/buildx.zig/api/targets |
| **Dependency Wiring** | Automatically wire build.zig.zon dependencies to modules. | https://muhammad-fiaz.github.io/buildx.zig/api/project |
| **No External Dependencies** | Pure Zig implementation wrapping std.Build. | https://muhammad-fiaz.github.io/buildx.zig/guide/quick-start |

</details>

----

<details>
<summary><strong>Prerequisites and Supported Platforms</strong> (click to expand)</summary>

<br>

## Prerequisites

Before using `buildx.zig`, ensure you have the following:

| Requirement | Version | Notes |
|-------------|---------|-------|
| **Zig** | 0.16.0 or later | Download from [ziglang.org](https://ziglang.org/download/) |
| **Operating System** | Windows 10+, Linux, macOS | Cross-platform build support |

---

## Supported Platforms

`buildx.zig` is validated on these architectures:

| Platform | x86_64 (64-bit) | aarch64 (ARM64) | x86 (32-bit) |
|----------|-----------------|-----------------|--------------|
| **Linux** | Yes | Yes | Yes |
| **Windows** | Yes | Yes | Yes |
| **macOS** | Yes | Yes (Apple Silicon) | No |

### Cross-Compilation

Zig makes cross-compilation easy. Build for any target from any host:

```bash
# Build for Linux ARM64 from Windows
zig build -Dtarget=aarch64-linux

# Build for Windows from Linux  
zig build -Dtarget=x86_64-windows

# Build for macOS Apple Silicon from Linux
zig build -Dtarget=aarch64-macos
```

</details>

---

## Installation

### Method 1: Zig Fetch (Recommended)

**Latest Release (v0.0.1)**

```bash
zig fetch --save https://github.com/muhammad-fiaz/buildx.zig/archive/refs/tags/0.0.1.tar.gz
```

> [!WARNING]
> Zig 0.15 is deprecated and not supported. New projects should use Zig 0.16.0+ with buildx.zig v0.0.1.

### Method 2: Zig Fetch (Main Branch)

Use the latest development version from the main branch.

```bash
zig fetch --save git+https://github.com/muhammad-fiaz/buildx.zig.git
```

### Method 3: Manual `build.zig.zon` Configuration

Add the dependency to your `build.zig.zon` file.

```zig
.dependencies = .{
    .buildx = .{
        .url = "https://github.com/muhammad-fiaz/buildx.zig/archive/refs/tags/0.0.1.tar.gz",
        .hash = "...", // Run `zig fetch --save <url>` to generate the hash.
    },
},
```

### Method 4: Local Source Checkout

Clone the repository locally.

```bash
git clone https://github.com/muhammad-fiaz/buildx.zig.git
cd buildx.zig
zig build
```

To use a local checkout from another project, add a path dependency to your `build.zig.zon`:

```zig
.dependencies = .{
    .buildx = .{
        .path = "../buildx.zig",
    },
},
```

### Wire into `build.zig`

After adding the dependency, import the module in your `build.zig`:

```zig
const buildx_dep = b.dependency("buildx", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("buildx", buildx_dep.module("buildx"));
```

## Quick Start

### Minimal Executable

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

### Library with Tests

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

Run with `zig build test`.

### Cross Compilation

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "myapp",
        .root = "src/main.zig",
        .cross = .{
            .targets = buildx.targets.desktop(),
        },
    });
}
```

Run with `zig build cross`.

### Workspace (Monorepo)

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

### System Libraries and Linking

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    _ = buildx.project(b, .{
        .name = "myapp",
        .root = "src/main.zig",
        .link = .{
            .include_paths = &.{"vendor/include"},
            .lib_paths = &.{"vendor/lib"},
            .system_libs = &.{
                .{ .name = "ssl", .needs_libc = true },
                .{ .name = "zlib" },
            },
            .frameworks = &.{"CoreFoundation"},
            .link_libc = true,
        },
        .install = true,
    });
}
```

> [!NOTE]
> Frameworks are macOS system libraries linked via `-framework`. Use `.frameworks` only when targeting macOS.

### Custom Options

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    const enable_feature = buildx.boolOption(b, "enable-feature", "Enable optional feature", false);
    const version = buildx.stringOption(b, "app-version", "Application version", "1.0.0");

    std.debug.print("Feature: {}, Version: {s}\n", .{ enable_feature, version });

    _ = buildx.project(b, .{
        .name = "myapp",
        .root = "src/main.zig",
        .install = true,
    });
}
```

Usage:

```bash
zig build                           # Feature disabled, version 1.0.0
zig build -Denable-feature=true -Dapp-version=2.0.0
```

### Using std.Build Directly

> [!TIP]
> Use `link` for standard linking. Use `std.Build` directly for C source files, module imports, or custom steps.

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
});

// Add C source files
exe.root_module.addCSourceFiles(.{
    .root = b.path("vendor"),
    .files = &.{"lib.c"},
    .flags = &.{"-O2"},
});

// Add module imports
const dep = b.dependency("json", .{});
exe.root_module.addImport("json", dep.module("json"));
```

## Examples

The `examples/` directory contains **7 comprehensive, runnable examples** demonstrating all features of `buildx.zig`:

| Example | Description | Key Features |
|---------|-------------|--------------|
| [`basic-executable`](examples/basic-executable/) | Minimal executable | `install = true` |
| [`library-with-tests`](examples/library-with-tests/) | Library with test suite | `kind = .library`, `tests = true` |
| [`cross-compile`](examples/cross-compile/) | Multi-platform build | `cross` field, `targets.desktop()` |
| [`custom-options`](examples/custom-options/) | Build-time options | `boolOption`, `stringOption` |
| [`system-lib`](examples/system-lib/) | Link C libraries | `link` field |
| [`run-with-args`](examples/run-with-args/) | Run step with arguments | `run = true` |
| [`monorepo`](examples/monorepo/) | Multi-package workspace | `workspace()`, `local_deps` |

To run any example:

```bash
cd examples/basic-executable
zig build
```

## API Reference

### `buildx.project(b, options)`

Creates a project. The main entry point.

```zig
pub fn project(b: *std.Build, options: ProjectOptions) *std.Build.Step.Compile
```

**ProjectOptions:**

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `name` | `[]const u8` | required | Artifact name |
| `root` | `[]const u8` | required | Root source file |
| `kind` | `Kind` | `.executable` | `.executable` or `.library` |
| `install` | `bool` | `false` | Add install step |
| `run` | `bool` | `false` | Add run step |
| `tests` | `bool` | `false` | Add test step |
| `docs` | `bool` | `false` | Add docs generation step |
| `target` | `?ResolvedTarget` | `null` | Override `-Dtarget` |
| `optimize` | `?OptimizeMode` | `null` | Override `-Doptimize` |
| `dependencies` | `DependencyList` | `&.{}` | build.zig.zon dependencies |
| `link` | `LinkConfig` | `.{}` | Linking configuration |
| `linkage` | `?LinkMode` | `.static` | Library: `.static` or `.dynamic` |
| `version` | `?SemanticVersion` | `null` | Artifact version |
| `cross` | `?CrossConfig` | `null` | Cross-compilation config |

**LinkConfig:**

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `include_paths` | `[]const []const u8` | `&.{}` | Include paths (-I) |
| `lib_paths` | `[]const []const u8` | `&.{}` | Library paths (-L) |
| `system_libs` | `SystemLibSet` | `&.{}` | System libraries (-l) |
| `frameworks` | `[]const []const u8` | `&.{}` | macOS frameworks |
| `rpaths` | `[]const []const u8` | `&.{}` | Runtime library paths |
| `c_macros` | `[]const CMacro` | `&.{}` | C preprocessor defines |
| `assembly_files` | `[]const []const u8` | `&.{}` | Assembly source files |
| `object_files` | `[]const []const u8` | `&.{}` | Pre-compiled object files |
| `link_libc` | `bool` | `false` | Link libc |
| `link_libcpp` | `bool` | `false` | Link libcpp |

### `buildx.workspace(b, options)`

Creates a workspace for monorepo support.

```zig
var ws = buildx.workspace(b, .{
    .members = &.{...},
});
_ = ws.build("core", .{});
_ = ws.build("cli", .{});
```

### `buildx.crossCompile(b, compile, cfg)`

Cross-compiles for multiple targets.

```zig
buildx.crossCompile(b, exe, .{
    .targets = buildx.targets.all(),
});
```

### `buildx.targets`

| Preset | Targets | Description |
|--------|---------|-------------|
| `all()` | 216 | All OS + all architectures |
| `desktop()` | 6 | Windows/Linux/macOS, x86_64 + aarch64 |
| `linux()` | 16 | Linux, all architectures |
| `windows()` | 4 | Windows, x86/x64/ARM/AArch64 |
| `macos()` | 2 | macOS, x86_64 + aarch64 |
| `arm()` | 24 | ARM/AArch64 across all OS |
| `riscv()` | 2 | RISC-V 32/64 on Linux |
| `freestanding()` | 8 | No OS, all architectures |
| `wasm()` | 2 | WebAssembly 32/64 on WASI |
| `allArchitectures()` | 21 | All CPU architectures |

### `buildx.option()`, `buildx.boolOption()`, `buildx.stringOption()`

Build-time options with type-safe defaults.

```zig
const debug = buildx.boolOption(b, "debug", "Enable debug mode", false);
const version = buildx.stringOption(b, "version", "App version", "1.0.0");
const port = buildx.option(b, u16, "port", "Server port");
```

## Validation

```bash
# Run library tests
zig build test

# Build all examples
cd examples/basic-executable && zig build
cd examples/library-with-tests && zig build test
cd examples/cross-compile && zig build cross
cd examples/custom-options && zig build
cd examples/run-with-args && zig build run
cd examples/system-lib && zig build
cd examples/monorepo && zig build
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass: `zig build test`
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.
