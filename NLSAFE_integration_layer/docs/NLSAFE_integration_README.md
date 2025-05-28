# NLSAFE Integration Layer

This integration layer bridges the standalone audit tools in the [NLSAFE repository](https://github.com/agshipley/NLSAFE) with the Nativelink verifiable build pipeline. It enables these tools to be used within Bazel-based workflows, automated via CI/CD, and incorporated into cryptographically verifiable provenance chains using SLSA, in-toto, and Sigstore.

> This package assumes your build system uses **Bazel** with `rules_rust` and is working toward SLSA-compliant software supply chain security.

---

## 📦 Overview

The NLSAFE integration layer includes:

| Component | Purpose |
|----------|---------|
| `BUILD.bazel` (per tool) | Exposes each audit tool as a Bazel target |
| `scripts/run_audits.sh` | Runs both audit tools against example IR inputs |
| `examples/` | Contains sample `.ll` and `.mlir` files for testing |
| `provenance/` | Placeholder for converting build + audit metadata to SLSA |
| `docs/` | Integration guide for developers |
| `.github/workflows/ci.yml` | GitHub Actions pipeline for audit tool CI |

---

## 🚀 Quick Start

1. **Unzip the integration layer**
2. **Move or merge** its contents into the root of your existing NLSAFE repo
3. Ensure Bazel is installed (`brew install bazelisk`)
4. Run:

```bash
chmod +x scripts/run_audits.sh
./scripts/run_audits.sh
```

This will run both tools against example IR files in `examples/` and generate basic audit logs.

---

## 🧱 Project Structure

```bash
NLSAFE/
├── llvm_ir_analyzer/
│   └── BUILD.bazel                # Bazel build target for LLVM IR audit tool
├── mlir_audit_tool/
│   └── BUILD.bazel                # Bazel build target for MLIR audit tool
├── scripts/
│   └── run_audits.sh              # Unified runner script
├── examples/
│   ├── test.ll                    # Sample LLVM IR file
│   ├── test.mlir                  # Sample MLIR file
│   ├── llvm_audit_output.txt     # Output of analyzer
│   └── mlir_audit_output.txt     # Output of audit tool
├── provenance/
│   └── transform_provenance.py   # Convert BEP + audit logs to SLSA JSON
├── docs/
│   └── integration_with_nativelink.md  # Integration reference
└── .github/
    └── workflows/
        └── ci.yml                # GitHub Actions pipeline
```

---

## 🔧 Build and Run (Locally)

These tools are exposed as Bazel `rust_binary` targets:

```bash
bazel run //llvm_ir_analyzer:llvm_ir_analyzer -- examples/test.ll
bazel run //mlir_audit_tool:mlir_audit_tool -- examples/test.mlir
```

To automate both:

```bash
./scripts/run_audits.sh
```

---

## 🧪 Continuous Integration

CI is provided via `.github/workflows/ci.yml`, which:
- Sets up Bazel
- Runs both audit tools
- Validates example output

CI triggers on `push` and `pull_request` to `main`.

---

## 🔐 Provenance and Security Toolchain

This integration layer prepares the foundation for secure, verifiable build infrastructure by:
- Creating structured audit logs during build/test phases
- Enabling provenance tracking using Bazel’s Build Event Protocol (BEP)
- Allowing in-toto wrapping of audit steps (future)
- Supporting Sigstore signing of artifacts (future)
- Tracking the full chain of custody via SLSA-compliant metadata

Use `provenance/transform_provenance.py` to convert Bazel BEP output and audit logs into SLSA provenance JSON.
### Generate SLSA Provenance
```bash
python provenance/transform_provenance.py --bep /path/to/bep.json --audit examples/llvm_audit_output.txt --audit examples/mlir_audit_output.txt --output provenance.json
```

---

## 📌 Future Work

- Expand `bep_to_slsa` parsing with additional BEP fields
- Add in-toto link generators around each audit step
- Add `cosign` or `fulcio` Sigstore signing step
- Integrate OpenTelemetry spans for trace-level observability
- Build a local development container (`devcontainer.json`) for repeatable builds

---

## 🤝 Contributing

This layer is meant as a public extension point for traceable, auditable, safety-first software build pipelines. Contributions are welcome — particularly around:

- Static IR analysis patterns (LLVM, MLIR)
- Provenance schema improvements
- Secure CI/CD modeling
- GitHub Actions hardening

---

## 📄 License

This project is licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

---

## 📬 Questions?

Contact [Andrew Shipley](mailto:andrew@tracemachina.com) or raise an Issue on [https://github.com/agshipley/NLSAFE](https://github.com/agshipley/NLSAFE).