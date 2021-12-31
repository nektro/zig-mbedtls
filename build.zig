const std = @import("std");
const deps = @import("./deps.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const selftest = b.addExecutable("selftest", null);
    selftest.setTarget(target);
    selftest.setBuildMode(mode);
    deps.addAllTo(selftest);
    selftest.addCSourceFile(deps.dirs._hRwPLfShRVk8 ++ "/programs/test/selftest.c", &.{});
    selftest.defineCMacro("MBEDTLS_SELF_TEST", null);

    const run_selftest = selftest.run();
    run_selftest.step.dependOn(&selftest.step);
    const test_step = b.step("test", "Run mbedtls selftest");
    test_step.dependOn(&run_selftest.step);
}
