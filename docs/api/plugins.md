# System Libraries

Link C/C++ system libraries via the `link` field.

> [!IMPORTANT]
> The `link` field in `ProjectOptions` handles all linking operations. For advanced cases not covered, use the full `std.Build` API on the returned `*Step.Compile`.

## LinkConfig

```zig
pub const LinkConfig = struct {
    include_paths: []const []const u8 = &.{},  // -I paths
    lib_paths: []const []const u8 = &.{},      // -L paths
    system_libs: SystemLibSet = &.{},           // -l libraries
    frameworks: []const []const u8 = &.{},      // -framework (macOS)
    rpaths: []const []const u8 = &.{},          // runtime paths
    c_macros: []const CMacro = &.{},            // C preprocessor defines
    assembly_files: []const []const u8 = &.{},  // .S files
    object_files: []const []const u8 = &.{},    // .o files
    link_libc: bool = false,                    // link libc
    link_libcpp: bool = false,                  // link libcpp
};
```

## SystemLibConfig

```zig
pub const SystemLibConfig = struct {
    name: []const u8,
    needs_libc: bool = false,
    needs_libcpp: bool = false,
};
```

## Usage

```zig
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
        .rpaths = &.{"lib"},
        .c_macros = &.{
            .{ .name = "HAVE_SSL" },
        },
        .link_libc = true,
    },
    .install = true,
});
```

## What Each Field Does

| Field | Effect | std.Build Equivalent |
|-------|--------|---------------------|
| `include_paths` | Adds `-I` paths for header lookup | `addIncludePath()` |
| `lib_paths` | Adds `-L` paths for library lookup | `addLibraryPath()` |
| `system_libs` | Links libraries via `-l` flag | `linkSystemLibrary()` |
| `frameworks` | Links macOS frameworks via `-framework` | `linkFramework()` |
| `rpaths` | Adds runtime library paths | `addRPath()` |
| `c_macros` | Defines C preprocessor macros | `addCMacro()` |
| `assembly_files` | Adds assembly source files | `addAssemblyFile()` |
| `object_files` | Adds pre-compiled object files | `addObjectFile()` |
| `link_libc` | Links libc | `link_libc = true` |
| `link_libcpp` | Links libcpp | `link_libcpp = true` |

> [!NOTE]
> Frameworks are macOS system libraries like `CoreFoundation`, `Security`, `IOKit`. They only work when targeting macOS.
