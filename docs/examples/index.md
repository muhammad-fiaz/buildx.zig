---
title: "Examples"
description: "Browse runnable buildx.zig examples covering executables, libraries, cross compilation, options, system libraries, and monorepos."
head:
  - - meta
    - name: keywords
      content: "buildx.zig examples, zig examples, sample build.zig"
---

# Examples

All examples are in the `examples/` directory and build successfully.

## Available Examples

| Example | Description | Key Features |
|---------|-------------|--------------|
| [basic-executable](/examples/basic-executable) | Minimal executable | `install = true` |
| [library-with-tests](/examples/library-with-tests) | Library with test suite | `kind = .library`, `tests = true` |
| [cross-compile](/examples/cross-compile) | Multi-platform build | `cross` field, `targets.all()` |
| [custom-options](/examples/custom-options) | Build-time options | `boolOption`, `stringOption` |
| [system-lib](/examples/system-lib) | Link C libraries | `system_libs` field |
| [run-with-args](/examples/run-with-args) | Run step with arguments | `run = true` |
| [monorepo](/examples/monorepo) | Multi-package workspace | `workspace()`, `local_deps` |

## Running Examples

```bash
cd examples/basic-executable
zig build
```

## Using buildx as a Dependency

Each example's `build.zig.zon` references buildx.zig:

```zig
.dependencies = .{
    .buildx = .{
        .path = "../..",
    },
},
```
