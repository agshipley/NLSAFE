# BEP-to-SLSA provenance prototype

A Rust command-line tool that reads Bazel Build Event Protocol (BEP) JSON and produces a **SLSA v0.2-style provenance JSON document**. This is a research component of [NLSAFE](../README.md), not a production provenance attestation service.

## What it does

The program parses build-event data and assembles a JSON envelope containing subject, builder, invocation, materials and metadata fields. The target is the **older v0.2 predicate format**; the project has not established conformance with newer SLSA provenance versions.

**Important boundary:** Emitting a JSON record does **not** cryptographically authenticate the record or establish artifact/build integrity. The repository does not provide a completed signing, verification, or trusted-builder chain. A digest carried in an output document should not be interpreted as an independently attested fact.

## Repository layout and usage

- [Rust CLI and manifest](src/main.rs), [Cargo.toml](Cargo.toml)
- [Example BEP input](example_bep.json)
- [Legacy Bazel wrapper](scripts/generate_slsa_provenance.sh)

The Rust crate is located in this directory, which is named `BEP - SLSA interpreter` (including spaces). From the NLSAFE repository root, the intended direct invocation is:

```bash
cargo run --manifest-path "BEP - SLSA interpreter/Cargo.toml" -- \
  "BEP - SLSA interpreter/example_bep.json" \
  /tmp/nlsafe-provenance.json \
  --repo-url https://github.com/agshipley/NLSAFE \
  --repo-digest YOUR_COMMIT_SHA
```

This is a documented invocation of the CLI argument interface, **not** a claim that the project has been build-tested or that the sample input produces valid cryptographic attestations.

The accompanying `generate_slsa_provenance.sh` script invokes `//provenance/bep_to_slsa:bep_to_slsa`, a Bazel target path **not present in this repository layout**. It is retained as a legacy integration sketch, not a verified working quick start. The older documentation's link to `.github/workflows/generate-provenance.yml` was also stale; no such workflow is included in this repository.

## What remains to be established

- A verified mapping from real Bazel event streams to provenance subjects and materials.
- Cryptographically authenticated build identity, artifact-digest binding, signing and verification.
- Validation against an appropriate contemporary SLSA/in-toto specification.
- An integrated, tested CI workflow with clear failure behavior.

See the [NLSAFE integration notes](../NLSAFE_integration_layer/docs/NLSAFE_integration_README.md) for the broader prototype architecture.
