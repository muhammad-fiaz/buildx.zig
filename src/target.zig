const std = @import("std");
const Build = std.Build;
const Target = std.Target;
const Cpu = Target.Cpu;
const Os = Target.Os;

pub const TargetList = []const Target.Query;

pub fn all() TargetList {
    return &all_targets;
}

pub fn desktop() TargetList {
    return &desktop_targets;
}

pub fn linux() TargetList {
    return &linux_targets;
}

pub fn windows() TargetList {
    return &windows_targets;
}

pub fn macos() TargetList {
    return &macos_targets;
}

pub fn arm() TargetList {
    return &arm_targets;
}

pub fn riscv() TargetList {
    return &riscv_targets;
}

pub fn freestanding() TargetList {
    return &freestanding_targets;
}

pub fn wasm() TargetList {
    return &wasm_targets;
}

pub fn allArchitectures() TargetList {
    return &arch_targets;
}

pub fn resolve(b: *Build, query: Target.Query) Build.ResolvedTarget {
    return b.resolveTargetQuery(query);
}

pub fn tripleSlice(b: *Build, query: Target.Query) []const u8 {
    return query.zigTriple(b.allocator) catch @panic("OOM");
}

pub fn artifactName(b: *Build, app_name: []const u8, query: Target.Query) []const u8 {
    const triple = query.zigTriple(b.allocator) catch @panic("OOM");
    const os_tag = query.os_tag orelse .windows;
    const ext = if (os_tag == .windows) ".exe" else "";
    return b.fmt("{s}-{s}{s}", .{ app_name, triple, ext });
}

const all_os = [_]Os.Tag{
    .windows, .linux, .macos,
    .freebsd, .netbsd, .openbsd,
    .uefi, .wasi, .emscripten,
    .ios, .tvos, .watchos,
};

const desktop_os = [_]Os.Tag{
    .windows, .linux, .macos,
};

const linux_os = [_]Os.Tag{.linux};
const windows_os = [_]Os.Tag{.windows};
const macos_os = [_]Os.Tag{.macos};

const all_archs = [_]Cpu.Arch{
    .x86,
    .x86_64,
    .arm,
    .aarch64,
    .riscv32,
    .riscv64,
    .mips,
    .mipsel,
    .mips64,
    .mips64el,
    .powerpc,
    .powerpc64,
    .powerpc64le,
    .sparc64,
    .wasm32,
    .wasm64,
    .s390x,
    .hexagon,
    .loongarch64,
    .thumb,
};

const desktop_archs = [_]Cpu.Arch{
    .x86_64,
    .aarch64,
};

const linux_archs = [_]Cpu.Arch{
    .x86,
    .x86_64,
    .arm,
    .aarch64,
    .riscv32,
    .riscv64,
    .mips,
    .mipsel,
    .mips64,
    .mips64el,
    .powerpc,
    .powerpc64,
    .powerpc64le,
    .sparc64,
    .s390x,
    .loongarch64,
};

const windows_archs = [_]Cpu.Arch{
    .x86,
    .x86_64,
    .aarch64,
    .arm,
};

const macos_archs = [_]Cpu.Arch{
    .x86_64,
    .aarch64,
};

const arm_archs = [_]Cpu.Arch{
    .arm,
    .aarch64,
};

const riscv_archs = [_]Cpu.Arch{
    .riscv32,
    .riscv64,
};

const freestanding_archs = [_]Cpu.Arch{
    .x86,
    .x86_64,
    .arm,
    .aarch64,
    .riscv32,
    .riscv64,
    .wasm32,
    .wasm64,
};

const wasm_archs = [_]Cpu.Arch{
    .wasm32,
    .wasm64,
};

const arch_list = [_]Cpu.Arch{
    .x86, .x86_64,
    .arm, .aarch64,
    .riscv32, .riscv64,
    .mips, .mipsel, .mips64, .mips64el,
    .powerpc, .powerpc64, .powerpc64le,
    .sparc64, .s390x,
    .wasm32, .wasm64,
    .hexagon, .loongarch64, .thumb,
};

fn q(arch: Cpu.Arch, os: Os.Tag) Target.Query {
    return .{ .cpu_arch = arch, .os_tag = os };
}

fn qf(arch: Cpu.Arch) Target.Query {
    return .{ .cpu_arch = arch, .os_tag = .freestanding };
}

fn qw(arch: Cpu.Arch) Target.Query {
    return .{ .cpu_arch = arch, .os_tag = .wasi };
}

fn buildAll() [all_os.len * all_archs.len]Target.Query {
    var r: [all_os.len * all_archs.len]Target.Query = undefined;
    var i: usize = 0;
    for (all_os) |os| {
        for (all_archs) |arch| {
            r[i] = q(arch, os);
            i += 1;
        }
    }
    return r;
}

fn buildDesktop() [desktop_os.len * desktop_archs.len]Target.Query {
    var r: [desktop_os.len * desktop_archs.len]Target.Query = undefined;
    var i: usize = 0;
    for (desktop_os) |os| {
        for (desktop_archs) |arch| {
            r[i] = q(arch, os);
            i += 1;
        }
    }
    return r;
}

fn buildLinux() [linux_archs.len]Target.Query {
    var r: [linux_archs.len]Target.Query = undefined;
    for (linux_archs, 0..) |arch, i| {
        r[i] = q(arch, .linux);
    }
    return r;
}

fn buildWindows() [windows_archs.len]Target.Query {
    var r: [windows_archs.len]Target.Query = undefined;
    for (windows_archs, 0..) |arch, i| {
        r[i] = q(arch, .windows);
    }
    return r;
}

fn buildMacos() [macos_archs.len]Target.Query {
    var r: [macos_archs.len]Target.Query = undefined;
    for (macos_archs, 0..) |arch, i| {
        r[i] = q(arch, .macos);
    }
    return r;
}

fn buildArm() [arm_archs.len * all_os.len]Target.Query {
    var r: [arm_archs.len * all_os.len]Target.Query = undefined;
    var i: usize = 0;
    for (arm_archs) |arch| {
        for (all_os) |os| {
            r[i] = q(arch, os);
            i += 1;
        }
    }
    return r;
}

fn buildRiscv() [riscv_archs.len]Target.Query {
    var r: [riscv_archs.len]Target.Query = undefined;
    for (riscv_archs, 0..) |arch, i| {
        r[i] = q(arch, .linux);
    }
    return r;
}

fn buildFreestanding() [freestanding_archs.len]Target.Query {
    var r: [freestanding_archs.len]Target.Query = undefined;
    for (freestanding_archs, 0..) |arch, i| {
        r[i] = qf(arch);
    }
    return r;
}

fn buildWasm() [wasm_archs.len]Target.Query {
    var r: [wasm_archs.len]Target.Query = undefined;
    for (wasm_archs, 0..) |arch, i| {
        r[i] = qw(arch);
    }
    return r;
}

fn buildArch() [arch_list.len]Target.Query {
    var r: [arch_list.len]Target.Query = undefined;
    for (arch_list, 0..) |arch, i| {
        r[i] = .{ .cpu_arch = arch };
    }
    return r;
}

const all_targets = buildAll();
const desktop_targets = buildDesktop();
const linux_targets = buildLinux();
const windows_targets = buildWindows();
const macos_targets = buildMacos();
const arm_targets = buildArm();
const riscv_targets = buildRiscv();
const freestanding_targets = buildFreestanding();
const wasm_targets = buildWasm();
const arch_targets = buildArch();

test "all targets count" {
    try std.testing.expectEqual(@as(usize, all_os.len * all_archs.len), all().len);
}

test "desktop targets count" {
    try std.testing.expectEqual(@as(usize, desktop_os.len * desktop_archs.len), desktop().len);
}

test "linux targets are all linux" {
    for (linux()) |t| {
        try std.testing.expect(t.os_tag.? == .linux);
    }
}

test "windows targets are all windows" {
    for (windows()) |t| {
        try std.testing.expect(t.os_tag.? == .windows);
    }
}

test "macos targets are all macos" {
    for (macos()) |t| {
        try std.testing.expect(t.os_tag.? == .macos);
    }
}

test "arm targets are ARM architectures" {
    for (arm()) |t| {
        const arch = t.cpu_arch.?;
        try std.testing.expect(arch == .arm or arch == .aarch64);
    }
}

test "riscv targets are RISC-V" {
    for (riscv()) |t| {
        const arch = t.cpu_arch.?;
        try std.testing.expect(arch == .riscv32 or arch == .riscv64);
    }
}

test "freestanding targets are freestanding" {
    for (freestanding()) |t| {
        try std.testing.expect(t.os_tag.? == .freestanding);
    }
}

test "wasm targets are WebAssembly" {
    for (wasm()) |t| {
        const arch = t.cpu_arch.?;
        try std.testing.expect(arch == .wasm32 or arch == .wasm64);
    }
}
