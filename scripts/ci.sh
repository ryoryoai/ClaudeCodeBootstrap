#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[ci] Running full test suite..."

# If project provides a dedicated CI command, prefer it:
if [[ -x "./scripts/project_ci.sh" ]]; then
  echo "[ci] Using ./scripts/project_ci.sh"
  ./scripts/project_ci.sh
  exit 0
fi

# Makefile
if [[ -f "Makefile" ]]; then
  if grep -qE '^ci:' Makefile; then
    echo "[ci] make ci"
    make ci
    exit 0
  fi
  if grep -qE '^test:' Makefile; then
    echo "[ci] make test"
    make test
    exit 0
  fi
fi

# Node.js
if [[ -f "package.json" ]]; then
  if [[ -f "pnpm-lock.yaml" ]] && command -v pnpm >/dev/null 2>&1; then
    echo "[ci] pnpm test"
    pnpm -s test
    exit 0
  fi
  if [[ -f "yarn.lock" ]] && command -v yarn >/dev/null 2>&1; then
    echo "[ci] yarn test"
    yarn test
    exit 0
  fi
  if command -v npm >/dev/null 2>&1; then
    echo "[ci] npm test"
    npm -s test
    exit 0
  fi
fi

# Python
if [[ -f "pyproject.toml" || -f "pytest.ini" || -d "tests" ]]; then
  if command -v python >/dev/null 2>&1; then
    echo "[ci] python -m pytest"
    python -m pytest
    exit 0
  fi
  if command -v pytest >/dev/null 2>&1; then
    echo "[ci] pytest"
    pytest
    exit 0
  fi
fi

# Go
if [[ -f "go.mod" ]] && command -v go >/dev/null 2>&1; then
  echo "[ci] go test ./..."
  go test ./...
  exit 0
fi

# Rust
if [[ -f "Cargo.toml" ]] && command -v cargo >/dev/null 2>&1; then
  echo "[ci] cargo test"
  cargo test
  exit 0
fi

echo "[ci] ERROR: Could not determine how to run tests. Please customize scripts/ci.sh for this repo." >&2
exit 2
