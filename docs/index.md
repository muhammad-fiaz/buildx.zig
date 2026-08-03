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
      link: https://github.com/user/buildx.zig
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
