# Integrating with std.Build

buildx.zig is an enhancement, not a replacement, for `std.Build`. It simplifies common patterns while giving you full access to `std.Build` when you need explicit customization.

> [!IMPORTANT]
> Every `project()` call returns `*std.Build.Step.Compile`. You can use the full `std.Build` API on it for anything not covered by buildx.zig.

## Linking via ProjectOptions (Recommended)

The `link` field in `ProjectOptions` handles all linking in one place:

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .include_paths = &.{"vendor/include"},
        .lib_paths = &.{"vendor/lib"},
        .system_libs = &.{
            .{ .name = "zlib" },
            .{ .name = "ssl", .needs_libc = true },
        },
        .frameworks = &.{"CoreFoundation"},
        .link_libc = true,
    },
    .install = true,
});
```

This replaces all of:

```zig
exe.root_module.addIncludePath(b.path("vendor/include"));
exe.root_module.addLibraryPath(b.path("vendor/lib"));
exe.root_module.linkSystemLibrary("zlib", .{});
exe.root_module.linkSystemLibrary("ssl", .{});
exe.root_module.linkFramework("CoreFoundation", .{});
exe.root_module.link_libc = true;
```

## Using std.Build Directly

For advanced cases not covered by `link`, use the returned `*Step.Compile`:

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

## Combining Both

> [!TIP]
> Use `link` for standard linking operations. Use `std.Build` directly for advanced customization like C source files, module imports, or custom steps.

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .include_paths = &.{"vendor/include"},
        .lib_paths = &.{"vendor/lib"},
        .system_libs = &.{
            .{ .name = "zlib" },
        },
    },
    .install = true,
});

// Additional std.Build customization
exe.root_module.addCSourceFiles(.{
    .root = b.path("src/c"),
    .files = &.{"helper.c"},
});
```

## Custom Steps

```zig
const exe = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .install = true,
});

// Add a custom step
const fmt_step = b.addSystemCommand(&.{"clang-format", "-i"});
fmt_step.addFileArg(b.path("src/main.zig"));
const fmt = b.step("fmt", "Format source files");
fmt.dependOn(&fmt_step.step);
```
