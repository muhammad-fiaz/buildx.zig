# project()

Create a project. The main entry point for buildx.zig.

> [!IMPORTANT]
> `project()` returns `*std.Build.Step.Compile`. You can use the full `std.Build` API on it for anything not covered by `ProjectOptions`.

## Signature

```zig
pub fn project(b: *std.Build, options: ProjectOptions) *std.Build.Step.Compile
```

## ProjectOptions

```zig
pub const ProjectOptions = struct {
    name: []const u8,                    // required: artifact name
    root: []const u8,                    // required: root source file
    target: ?ResolvedTarget = null,      // override -Dtarget
    optimize: ?OptimizeMode = null,      // override -Doptimize
    dependencies: DependencyList = &.{}, // build.zig.zon dependencies
    install: bool = false,               // add install step
    tests: bool = false,                 // add test step
    run: bool = false,                   // add run step
    docs: bool = false,                  // add docs generation step
    test_root: ?[]const u8 = null,       // override test source file
    kind: Kind = .executable,            // .executable or .library
    linkage: ?LinkMode = null,           // library: .static or .dynamic
    version: ?SemanticVersion = null,    // artifact version
    use_llvm: ?bool = null,              // force LLVM backend
    use_lld: ?bool = null,               // force LLD linker
    cross: ?CrossConfig = null,          // cross-compilation config
    link: LinkConfig = .{},              // linking configuration
};
```

## Examples

### Minimal executable

```zig
_ = buildx.project(b, .{
    .name = "hello",
    .root = "src/main.zig",
    .install = true,
});
```

### Library with tests

```zig
_ = buildx.project(b, .{
    .name = "math",
    .root = "src/root.zig",
    .kind = .library,
    .tests = true,
});
```

### With cross-compilation

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .cross = .{
        .targets = buildx.targets.desktop(),
    },
});
```

### With linking

```zig
_ = buildx.project(b, .{
    .name = "myapp",
    .root = "src/main.zig",
    .link = .{
        .include_paths = &.{"vendor/include"},
        .lib_paths = &.{"vendor/lib"},
        .system_libs = &.{
            .{ .name = "ssl", .needs_libc = true },
        },
        .frameworks = &.{"CoreFoundation"},
        .link_libc = true,
    },
    .install = true,
});
```

> [!NOTE]
> Frameworks are macOS system libraries linked via `-framework`. Use `.frameworks` only when targeting macOS.

## Return Value

Returns `*std.Build.Step.Compile`. Use this to:

- Add C source files
- Add module imports
- Create custom build steps
