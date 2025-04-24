# Integrating LLVM/MLIR Audit Tools with Nativelink

This document explains how the audit tools in the NLSAFE repository can be integrated into the Nativelink build pipeline.

## Steps

1. Add `BUILD.bazel` files to expose each tool as a Bazel binary target.
2. Add a `scripts/run_audits.sh` script to run both tools and redirect output.
3. Store example `.ll` and `.mlir` inputs in `examples/`.
4. Use the `provenance/transform_provenance.py` script to convert audit outputs and Bazel build event protocol (BEP) metadata into SLSA-compliant JSON.
5. Connect this process to GitHub Actions or your CI pipeline.

These tools are meant to run after build steps and before signing steps, producing auditable intermediate reports.