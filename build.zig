const std = @import("std");

pub fn build(b: *std.Build) !void {
    const targets: []const std.Target.Query = &.{
        .{ .cpu_arch = .aarch64, .os_tag = .macos },
        .{ .cpu_arch = .aarch64, .os_tag = .linux, .abi = .gnu },
        .{ .cpu_arch = .aarch64, .os_tag = .linux, .abi = .musl },
        .{ .cpu_arch = .aarch64, .os_tag = .freebsd },
        .{ .cpu_arch = .aarch64, .os_tag = .openbsd },
        // ------------------------------------------------
        .{ .cpu_arch = .x86_64, .os_tag = .macos },
        .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu },
        .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
        .{ .cpu_arch = .x86_64, .os_tag = .freebsd },
        .{ .cpu_arch = .x86_64, .os_tag = .openbsd },
    };

    for (targets) |t| {
        const target = b.resolveTargetQuery(t);

        const lib = b.addLibrary(.{
            .name = "arenaallocator",
            .linkage = .dynamic,
            .root_module = b.createModule(.{
                .target = target,
                .optimize = .ReleaseSafe,
                .strip = true,
                .link_libc = true,
            }),
        });

        lib.addCSourceFiles(.{ .files = &.{
            "arena/arena.c", "malloc/malloc.c",
        } });
        lib.addIncludePath(b.path("arena"));
        lib.installHeader(b.path("arena/arena.h"), "arena/arena.h");

        const target_output = b.addInstallArtifact(lib, .{
            .dest_dir = .{
                .override = .{ .custom = try t.zigTriple(b.allocator) },
            },
        });

        b.getInstallStep().dependOn(&target_output.step);
    }
}
