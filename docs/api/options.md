# Options

Build-time options with type-safe defaults.

## Functions

### boolOption

```zig
pub fn boolOption(b: *std.Build, name: []const u8, description: []const u8, default: bool) bool
```

```zig
const debug = buildx.boolOption(b, "debug", "Enable debug mode", false);
// zig build -Ddebug=true
```

### stringOption

```zig
pub fn stringOption(b: *std.Build, name: []const u8, description: []const u8, default: []const u8) []const u8
```

```zig
const version = buildx.stringOption(b, "version", "App version", "1.0.0");
// zig build -Dversion=2.0.0
```

### option (generic)

```zig
pub fn option(b: *std.Build, comptime T: type, name: []const u8, description: []const u8) ?T
```

```zig
const port = buildx.option(b, u16, "port", "Server port");
// Returns null if not specified, otherwise the value
```

### optionWithDefault

```zig
pub fn optionWithDefault(b: *std.Build, comptime T: type, name: []const u8, description: []const u8, default: T) T
```

```zig
const count = buildx.optionWithDefault(b, u32, "count", "Item count", 10);
```

### enumOption

```zig
pub fn enumOption(b: *std.Build, comptime T: type, name: []const u8, description: []const u8) ?T
```

```zig
const Mode = enum { debug, release, perf };
const mode = buildx.enumOption(b, Mode, "mode", "Build mode");
```

### intOption

```zig
pub fn intOption(b: *std.Build, comptime T: type, name: []const u8, description: []const u8) ?T
```

### floatOption

```zig
pub fn floatOption(b: *std.Build, comptime T: type, name: []const u8, description: []const u8) ?T
```

### pathOption

```zig
pub fn pathOption(b: *std.Build, name: []const u8, description: []const u8) ?Build.LazyPath
```
