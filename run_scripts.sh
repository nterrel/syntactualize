#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Run repo checks/demos via Makefile targets.
# Examples:
#   ./run_all.sh
#   ./run_all.sh bash
#   ./run_all.sh python
#   ./run_all.sh all
#   ./run_all.sh clean

if ! command -v make >/dev/null 2>&1; then
  echo "Error: 'make' not found. Install Xcode Command Line Tools (macOS) or build-essential (Linux)." >&2
  exit 1
fi

# Default target if none provided
target="${1:-all}"
shift || true

make "$target" "$@"
