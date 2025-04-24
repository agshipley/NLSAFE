load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library", "rust_test")

rust_binary(
    name = "bep_to_slsa",
    srcs = ["src/main.rs"],
    edition = "2021",
    deps = [
        "@crates//:serde",
        "@crates//:serde_json",
        "@crates//:structopt",
        "@crates//:sha2",
        "@crates//:hex",
        "@crates//:anyhow",
        "@crates//:log",
        "@crates//:env_logger",
    ],
    visibility = ["//visibility:public"],
)

rust_test(
    name = "bep_to_slsa_test",
    srcs = ["src/main.rs"],
    edition = "2021",
    deps = [
        "@crates//:serde",
        "@crates//:serde_json",
        "@crates//:structopt",
        "@crates//:sha2",
        "@crates//:hex",
        "@crates//:anyhow",
        "@crates//:log",
        "@crates//:env_logger",
    ],
)
