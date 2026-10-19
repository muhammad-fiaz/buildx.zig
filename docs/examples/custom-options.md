---
title: "Custom Options"
description: "Use typed build-time options with defaults and -D flags in a buildx.zig project."
head:
  - - meta
    - name: keywords
      content: "custom options example, boolOption, stringOption, -D flags, buildx.zig example"
---

# Custom Options

Build-time configuration with typed options.

## build.zig

```zig
const std = @import("std");
const buildx = @import("buildx");

pub fn build(b: *std.Build) void {
    const enable_feature = buildx.boolOption(b, "enable-feature", "Enable optional feature", false);
    const version = buildx.stringOption(b, "app-version", "Application version", "1.0.0");

    std.debug.print("Feature: {}, Version: {s}\n", .{ enable_feature, version });

    _ = buildx.project(b, .{
        .name = "optionsapp",
        .root = "src/main.zig",
        .install = true,
    });
}
```

## Usage

```bash
zig build
# Output: Feature: false, Version: 1.0.0

zig build -Denable-feature=true -Dapp-version=2.0.0
# Output: Feature: true, Version: 2.0.0
```
