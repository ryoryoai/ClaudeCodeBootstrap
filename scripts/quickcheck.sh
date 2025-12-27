#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[quickcheck] Running quick checks..."

# If project provides a dedicated quickcheck, prefer it:
if [[ -x "./scripts/project_quickcheck.sh" ]]; then
  echo "[quickcheck] Using ./scripts/project_quickcheck.sh"
  ./scripts/project_quickcheck.sh
  exit 0
fi

# Default: run full suite (override per repo if needed)
./scripts/ci.sh
