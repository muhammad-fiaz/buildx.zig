---
layout: home
hero:
  name: buildx.zig
  text: Simplified Zig Build System
  tagline: A minimal, efficient library that wraps std.Build for Zig
  actions:
    - theme: brand
      text: Get Started
      link: /guide/introduction
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

`buildx.zig` is a minimal build system library for Zig that wraps `std.Build` with a single `project()` function. One call sets up compilation, installation, testing, and running - with full access to the underlying `std.Build` when you need more.

::: tip
If you build with buildx.zig, make sure to give it a star.
:::

::: note
**Project maturity:** This project aims to be production-ready and is actively maintained. It is still a new project and not yet widely adopted. Feel free to use it in your projects.
:::

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
