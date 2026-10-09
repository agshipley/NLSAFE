# NLSAFE integration experiments

This directory documents **prototype integration work**, not a complete or certified secure-build pipeline. The intent is to connect the repository's LLVM/MLIR IR-analysis tools with Bazel build metadata and eventually bind their outputs to verifiable provenance.

## What is present

| Component | Location | Role |
|---|---|---|
| Bazel build target sketches | [LLVM target](../llvm_ir_analyzer/BUILD.bazel) and [MLIR target](../mlir_audit_tool/BUILD.bazel) | Candidate integration targets for the standalone Rust analyzers |
| Local sample inputs | [examples/](../examples/) | Small test IR inputs, not a validation corpus |
| Audit runner | [scripts/run_audits.sh](../scripts/run_audits.sh) | Shell orchestration for prototype auditing |
| Provenance placeholder | [provenance/transform_provenance.py](../provenance/transform_provenance.py) | **Stub only**; it does not implement conversion or signing |
| Separate BEP interpreter | [BEP-to-SLSA prototype](../../BEP%20-%20SLSA%20interpreter/) | Standalone Rust attempt to translate BEP data to an older provenance structure |

## Intended flow

```text
LLVM / MLIR inputs -> prototype analysis -> audit findings
Bazel build events -> BEP parser -> provenance JSON
                  [future: authenticated binding + signing]
```

These pieces should not be described as an end-to-end verified pipeline. In particular, the previously documented `.github/workflows/ci.yml` file and top-level Bazel setup are not present in this repository. The existing scripts and targets should be evaluated and wired together before describing them as a working CI integration.

## Remaining work

- Make the audit targets and orchestration reproducibly runnable from a documented checkout.
- Define a schema for linking IR findings to concrete artifact digests.
- Replace the stub provenance transformation and reconcile it with the standalone interpreter.
- Add test fixtures, versioned expected results, and a functioning CI workflow.
- Add authenticated attestations and verification before making cryptographic integrity claims.

See the [top-level project overview](../../README.md) for scope and limitations.
