---
title: "System Libraries"
description: "Link C/C++ system libraries, frameworks, include paths, macros, and objects using the buildx.zig link configuration."
head:
  - - meta
    - name: keywords
      content: "system libraries, zig linking, link libc, libcpp, frameworks, include paths, c macros"
---

# System Libraries

Link C/C++ system libraries with the `link` field.

> [!IMPORTANT]
> buildx.zig simplifies linking with the `link` field in `ProjectOptions`. For advanced cases not covered, you can use the full `std.Build` API on the returned `*Step.Compile`.

## Basic Usage

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .system_libs = &.{
            .{ .name = "m" },
            .{ .name = "pthread" },
        },
    },
    .install = true,
});
```

## With libc

```zig
.link = .{
    .system_libs = &.{
        .{ .name = "c" },
        .{ .name = "m", .needs_libc = true },
    },
    .link_libc = true,
},
```

## With libcpp

```zig
.link = .{
    .system_libs = &.{
        .{ .name = "stdc++", .needs_libcpp = true },
    },
    .link_libcpp = true,
},
```

## Include Paths and Library Paths

```zig
.link = .{
    .include_paths = &.{"vendor/include", "third_party/headers"},
    .lib_paths = &.{"vendor/lib", "third_party/libs"},
    .system_libs = &.{
        .{ .name = "zlib" },
    },
},
```

## Frameworks (macOS)

> [!NOTE]
> Frameworks are macOS system libraries (like `CoreFoundation`, `Security`, `IOKit`) linked via `-framework`. They only work when targeting macOS.

```zig
.link = .{
    .frameworks = &.{"CoreFoundation", "Security"},
},
```

## Runtime Paths (RPath)

```zig
.link = .{
    .rpaths = &.{"lib", "/usr/local/lib"},
},
```

## C Macros

```zig
.link = .{
    .c_macros = &.{
        .{ .name = "DEBUG" },
        .{ .name = "VERSION", .value = "\"1.0\"" },
    },
},
```

## Assembly and Object Files

```zig
.link = .{
    .assembly_files = &.{"src/boot.S"},
    .object_files = &.{"vendor/prebuilt.o"},
},
```

## Full Example

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .include_paths = &.{"vendor/include"},
        .lib_paths = &.{"vendor/lib"},
        .system_libs = &.{
            .{ .name = "ssl", .needs_libc = true },
            .{ .name = "crypto", .needs_libc = true },
            .{ .name = "zlib" },
        },
        .frameworks = &.{"CoreFoundation"},
        .rpaths = &.{"lib"},
        .c_macros = &.{
            .{ .name = "HAVE_SSL" },
        },
        .link_libc = true,
    },
    .install = true,
});
```

## LinkConfig Reference

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

## Direct std.Build Usage

> [!TIP]
> For cases not covered by `link`, use the returned `*Step.Compile` directly with `std.Build` APIs.

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
