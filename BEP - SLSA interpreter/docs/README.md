# BEP to SLSA Transformer

This component transforms Bazel Build Event Protocol (BEP) data into SLSA (Supply-chain Levels for Software Artifacts) provenance format.

## Overview

The BEP to SLSA transformer is a critical part of the NLSAFE provenance system. It:

1. Extracts build information from Bazel's BEP JSON output
2. Transforms this data into the SLSA provenance format (v0.2)
3. Generates a cryptographically verifiable record of how artifacts were built

## Usage

### Command Line

```bash
bazel run //provenance/bep_to_slsa:bep_to_slsa -- \
  /path/to/bep.json \
  /path/to/output/slsa-provenance.json \
  --repo-url https://github.com/agshipley/NLSAFE \
  --repo-digest <commit-hash>
```

### Integration Script

For convenience, use the provided script:

```bash
./scripts/generate_slsa_provenance.sh \
  --bep /path/to/bep.json \
  --output /path/to/output/slsa-provenance.json \
  --repo-url https://github.com/agshipley/NLSAFE \
  --repo-digest <commit-hash>
```

## SLSA Provenance Format

The generated SLSA provenance follows the [SLSA v0.2 specification](https://slsa.dev/provenance/v0.2) and includes:

- Subject: The built artifacts and their digests
- Builder: Information about the build system
- Build Type: Identifies Bazel as the build system
- Invocation: Details about how the build was invoked
- Materials: Source code and dependencies used in the build
- Metadata: Additional information about the build

## Integration with CI/CD

This tool is designed to be integrated into CI/CD pipelines. See `.github/workflows/generate-provenance.yml` for an example GitHub Actions workflow.
