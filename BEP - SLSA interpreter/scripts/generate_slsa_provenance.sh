#!/bin/bash
# File: scripts/generate_slsa_provenance.sh

set -euo pipefail

# Default values
BEP_FILE=""
OUTPUT_FILE=""
REPO_URL=""
REPO_DIGEST=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --bep)
      BEP_FILE="$2"
      shift 2
      ;;
    --output)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    --repo-url)
      REPO_URL="$2"
      shift 2
      ;;
    --repo-digest)
      REPO_DIGEST="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate required arguments
if [[ -z "$BEP_FILE" ]]; then
  echo "Error: BEP file path is required (--bep)"
  exit 1
fi

if [[ -z "$OUTPUT_FILE" ]]; then
  echo "Error: Output file path is required (--output)"
  exit 1
fi

if [[ -z "$REPO_URL" ]]; then
  echo "Error: Repository URL is required (--repo-url)"
  exit 1
fi

if [[ -z "$REPO_DIGEST" ]]; then
  echo "Error: Repository digest is required (--repo-digest)"
  exit 1
fi

# Run the BEP to SLSA transformer
bazel run //provenance/bep_to_slsa:bep_to_slsa -- \
  "$BEP_FILE" \
  "$OUTPUT_FILE" \
  --repo-url "$REPO_URL" \
  --repo-digest "$REPO_DIGEST"

echo "SLSA provenance generated at: $OUTPUT_FILE"
