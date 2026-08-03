---
layout: home
hero:
  name: buildx.zig
  text: Simplified Zig Build System
  tagline: A minimal, efficient library that wraps std.Build for Zig
  actions:
    - theme: brand
      text: Get Started
      link: /guide/quick-start
    - theme: alt
      text: API Reference
      link: /api/project
    - theme: alt
      text: GitHub
      link: https://github.com/muhammad-fiaz/buildx.zig
features:
  - title: Minimal API
    details: One function to create a project. No boilerplate, no complexity.
  - title: Cross Compilation
    details: Build for all platforms with a single config object.
  - title: Workspace Support
    details: Monorepo support with local dependencies between packages.
  - title: System Libraries
    details: Link system libraries with automatic libc/libcpp handling.
  - title: Custom Options
    details: Define build-time options with type-safe defaults.
  - title: Full std.Build Access
    details: Returns *Step.Compile so you can customize further with std.Build.
---

# Installation

## Method 1: Zig Fetch (Recommended)

**Latest Release (v0.0.1)**

```bash
zig fetch --save https://github.com/muhammad-fiaz/buildx.zig/archive/refs/tags/0.0.1.tar.gz
```

::: warning
Zig 0.15 is deprecated and not supported. New projects should use Zig 0.16.0+ with buildx.zig v0.0.1.
:::

## Method 2: Zig Fetch (Main Branch)

Use the latest development version from the main branch.

```bash
zig fetch --save git+https://github.com/muhammad-fiaz/buildx.zig.git
```

## Method 3: Manual `build.zig.zon` Configuration

Add the dependency to your `build.zig.zon` file.

```zig
.dependencies = .{
    .buildx = .{
        .url = "https://github.com/muhammad-fiaz/buildx.zig/archive/refs/tags/0.0.1.tar.gz",
        .hash = "...", // Run `zig fetch --save <url>` to generate the hash.
    },
},
```

## Method 4: Local Source Checkout

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

## Wire into `build.zig`

After adding the dependency, import the module in your `build.zig`:

```zig
const buildx_dep = b.dependency("buildx", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("buildx", buildx_dep.module("buildx"));
```

---

# Related Zig Projects

Build on top of the Zig ecosystem with these complementary libraries:

| Project | Description |
|---------|-------------|
| [env.zig](https://github.com/muhammad-fiaz/env.zig) | `.env` file parsing |
| [tui.zig](https://github.com/muhammad-fiaz/tui.zig) | TUI support |
| [zon.zig](https://github.com/muhammad-fiaz/zon.zig) | ZON file format support |
| [loaders.zig](https://github.com/muhammad-fiaz/loaders.zig) | Spinners, loading, and progress bar support |
| [mcp.zig](https://github.com/muhammad-fiaz/mcp.zig) | MCP support |
| [args.zig](https://github.com/muhammad-fiaz/args.zig) | Args parsing support |
| [httpx.zig](https://github.com/muhammad-fiaz/httpx.zig) | HTTP client/server support |
| [api.zig](https://github.com/muhammad-fiaz/api.zig) | API framework support |
| [zix](https://github.com/muhammad-fiaz/zix) | Web framework support |
| [archive.zig](https://github.com/muhammad-fiaz/archive.zig) | Archive/compression support |
| [zigx](https://github.com/muhammad-fiaz/zigx) | Compression file format support |
| [downloader.zig](https://github.com/muhammad-fiaz/downloader.zig) | File downloading support |
| [updater.zig](https://github.com/muhammad-fiaz/updater.zig) | Update checker/auto-updater support |
| [num.zig](https://github.com/muhammad-fiaz/num.zig) | Numerical computing support |
| [logly.zig](https://github.com/muhammad-fiaz/logly.zig) | Logging support |
| [zigantic](https://github.com/muhammad-fiaz/zigantic) | Data validation and serialization support |
| [cuda.zig](https://github.com/muhammad-fiaz/cuda.zig) | A production-ready, high-performance CUDA Runtime and Driver API library for Zig |
