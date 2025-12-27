#!/usr/bin/env bash
# Lint and Type Check Script
# Runs linters and type checkers for various languages

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[lint] Running lint and type checks..."

FAILED=0

# === Node.js / TypeScript ===
if [[ -f "package.json" ]]; then
  PKG_MANAGER="npm"
  [[ -f "pnpm-lock.yaml" ]] && PKG_MANAGER="pnpm"
  [[ -f "yarn.lock" ]] && PKG_MANAGER="yarn"

  # ESLint
  if [[ -f ".eslintrc.js" || -f ".eslintrc.json" || -f ".eslintrc.yml" || -f "eslint.config.js" || -f "eslint.config.mjs" ]]; then
    echo "[lint] ESLint"
    if ! $PKG_MANAGER run lint 2>/dev/null; then
      if command -v npx >/dev/null 2>&1; then
        if ! npx eslint . --max-warnings=0 2>/dev/null; then
          echo "[lint] ERROR: ESLint failed" >&2
          FAILED=1
        fi
      fi
    fi
  fi

  # Prettier
  if [[ -f ".prettierrc" || -f ".prettierrc.json" || -f ".prettierrc.js" || -f "prettier.config.js" ]]; then
    echo "[lint] Prettier"
    if ! $PKG_MANAGER run format:check 2>/dev/null; then
      if command -v npx >/dev/null 2>&1; then
        if ! npx prettier --check . 2>/dev/null; then
          echo "[lint] ERROR: Prettier check failed" >&2
          FAILED=1
        fi
      fi
    fi
  fi

  # TypeScript
  if [[ -f "tsconfig.json" ]]; then
    echo "[lint] TypeScript type check"
    if ! $PKG_MANAGER run typecheck 2>/dev/null; then
      if command -v npx >/dev/null 2>&1; then
        if ! npx tsc --noEmit 2>/dev/null; then
          echo "[lint] ERROR: TypeScript type check failed" >&2
          FAILED=1
        fi
      fi
    fi
  fi
fi

# === Python ===
if [[ -f "pyproject.toml" || -f "setup.py" || -f "requirements.txt" ]]; then
  # Ruff (fast Python linter)
  if command -v ruff >/dev/null 2>&1; then
    echo "[lint] Ruff"
    if ! ruff check . 2>/dev/null; then
      echo "[lint] ERROR: Ruff check failed" >&2
      FAILED=1
    fi
  # Fallback to flake8
  elif command -v flake8 >/dev/null 2>&1; then
    echo "[lint] flake8"
    if ! flake8 . 2>/dev/null; then
      echo "[lint] ERROR: flake8 failed" >&2
      FAILED=1
    fi
  fi

  # Black (formatter)
  if command -v black >/dev/null 2>&1; then
    echo "[lint] Black (format check)"
    if ! black --check . 2>/dev/null; then
      echo "[lint] ERROR: Black format check failed" >&2
      FAILED=1
    fi
  fi

  # MyPy (type checker)
  if command -v mypy >/dev/null 2>&1 && [[ -f "pyproject.toml" || -f "mypy.ini" ]]; then
    echo "[lint] MyPy"
    if ! mypy . 2>/dev/null; then
      echo "[lint] ERROR: MyPy type check failed" >&2
      FAILED=1
    fi
  fi
fi

# === Go ===
if [[ -f "go.mod" ]] && command -v go >/dev/null 2>&1; then
  echo "[lint] go vet"
  if ! go vet ./... 2>/dev/null; then
    echo "[lint] ERROR: go vet failed" >&2
    FAILED=1
  fi

  if command -v golangci-lint >/dev/null 2>&1; then
    echo "[lint] golangci-lint"
    if ! golangci-lint run 2>/dev/null; then
      echo "[lint] ERROR: golangci-lint failed" >&2
      FAILED=1
    fi
  fi

  echo "[lint] gofmt"
  if [[ -n "$(gofmt -l . 2>/dev/null)" ]]; then
    echo "[lint] ERROR: gofmt found unformatted files" >&2
    FAILED=1
  fi
fi

# === Rust ===
if [[ -f "Cargo.toml" ]] && command -v cargo >/dev/null 2>&1; then
  echo "[lint] cargo clippy"
  if ! cargo clippy -- -D warnings 2>/dev/null; then
    echo "[lint] ERROR: cargo clippy failed" >&2
    FAILED=1
  fi

  echo "[lint] cargo fmt check"
  if ! cargo fmt -- --check 2>/dev/null; then
    echo "[lint] ERROR: cargo fmt check failed" >&2
    FAILED=1
  fi
fi

# === Shell Scripts ===
if command -v shellcheck >/dev/null 2>&1; then
  SHELL_FILES=$(find . -name "*.sh" -type f 2>/dev/null | head -50)
  if [[ -n "$SHELL_FILES" ]]; then
    echo "[lint] ShellCheck"
    if ! echo "$SHELL_FILES" | xargs shellcheck 2>/dev/null; then
      echo "[lint] ERROR: ShellCheck failed" >&2
      FAILED=1
    fi
  fi
fi

# === Summary ===
if [[ $FAILED -eq 0 ]]; then
  echo "[lint] All lint and type checks passed"
  exit 0
else
  echo "[lint] Lint/type checks failed (see errors above)" >&2
  exit 1
fi
