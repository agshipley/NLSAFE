#!/bin/bash
set -e

echo "Running LLVM IR Analyzer..."
bazel run //llvm_ir_analyzer:llvm_ir_analyzer -- examples/test.ll > examples/llvm_audit_output.txt

echo "Running MLIR Audit Tool..."
bazel run //mlir_audit_tool:mlir_audit_tool -- examples/test.mlir > examples/mlir_audit_output.txt