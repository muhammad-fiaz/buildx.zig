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
