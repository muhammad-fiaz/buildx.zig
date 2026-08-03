# Introduction

`buildx.zig` is a minimal build system library for Zig that wraps `std.Build` with a single `project()` function. One call sets up compilation, installation, testing, and running - with full access to the underlying `std.Build` when you need more.

> [!TIP]
> If you build with buildx.zig, make sure to give it a star.

> [!NOTE]
> **Project maturity:** This project aims to be production-ready and is actively maintained. It is still a new project and not yet widely adopted. Feel free to use it in your projects.

## Why buildx.zig?

Zig's `std.Build` is powerful but verbose. buildx.zig simplifies common patterns:

| Without buildx.zig | With buildx.zig |
|---------------------|-----------------|
| Manually create modules, executables, install steps | One `project()` call |
| Repeat target/optimize setup for each artifact | Cached automatically |
| Wire dependencies by hand | Automatic dependency wiring |
| Cross-compile with boilerplate | `cross` field with 216+ target presets |

## Key Features

- **Minimal API** - One function to create a project
- **Full std.Build Access** - Returns `*Step.Compile` for complete customization
- **Cross Compilation** - Build for all platforms with a single config object
- **Workspace Support** - Monorepo support with local dependencies
- **System Libraries** - Link C/C++ libraries with automatic libc/libcpp handling
- **Custom Options** - Define build-time options with type-safe defaults
- **No External Dependencies** - Pure Zig implementation

## Requirements

- **Zig:** 0.16.0 or later
- **Operating System:** Windows 10+, Linux, or macOS
