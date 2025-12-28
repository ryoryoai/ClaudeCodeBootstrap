#!/usr/bin/env bash
# Security Scan Script
# Runs security audits for various package managers and code scanners

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[security] Running security scans..."

FAILED=0

# === Node.js Security ===
if [[ -f "package.json" ]]; then
  echo "[security] Checking npm packages..."

  if [[ -f "pnpm-lock.yaml" ]] && command -v pnpm >/dev/null 2>&1; then
    echo "[security] pnpm audit"
    if ! pnpm audit --audit-level=high 2>/dev/null; then
      echo "[security] WARNING: npm audit found vulnerabilities" >&2
      FAILED=1
    fi
  elif [[ -f "yarn.lock" ]] && command -v yarn >/dev/null 2>&1; then
    echo "[security] yarn audit"
    if ! yarn audit --level high 2>/dev/null; then
      echo "[security] WARNING: yarn audit found vulnerabilities" >&2
      FAILED=1
    fi
  elif command -v npm >/dev/null 2>&1; then
    echo "[security] npm audit"
    if ! npm audit --audit-level=high 2>/dev/null; then
      echo "[security] WARNING: npm audit found vulnerabilities" >&2
      FAILED=1
    fi
  fi
fi

# === Python Security ===
if [[ -f "pyproject.toml" || -f "requirements.txt" || -f "setup.py" ]]; then
  echo "[security] Checking Python packages..."

  # pip-audit
  if command -v pip-audit >/dev/null 2>&1; then
    echo "[security] pip-audit"
    if ! pip-audit 2>/dev/null; then
      echo "[security] WARNING: pip-audit found vulnerabilities" >&2
      FAILED=1
    fi
  fi

  # bandit (Python security linter)
  if command -v bandit >/dev/null 2>&1; then
    echo "[security] bandit"
    if ! bandit -r . -ll -q 2>/dev/null; then
      echo "[security] WARNING: bandit found security issues" >&2
      FAILED=1
    fi
  fi
fi

# === Go Security ===
if [[ -f "go.mod" ]] && command -v govulncheck >/dev/null 2>&1; then
  echo "[security] govulncheck"
  if ! govulncheck ./... 2>/dev/null; then
    echo "[security] WARNING: govulncheck found vulnerabilities" >&2
    FAILED=1
  fi
fi

# === Rust Security ===
if [[ -f "Cargo.toml" ]] && command -v cargo-audit >/dev/null 2>&1; then
  echo "[security] cargo audit"
  if ! cargo audit 2>/dev/null; then
    echo "[security] WARNING: cargo audit found vulnerabilities" >&2
    FAILED=1
  fi
fi

# === Generic Code Security (Semgrep) ===
if command -v semgrep >/dev/null 2>&1; then
  echo "[security] semgrep (OWASP rules)"
  if ! semgrep --config=auto --error --quiet . 2>/dev/null; then
    echo "[security] WARNING: semgrep found security issues" >&2
    FAILED=1
  fi
fi

# === Secret Detection ===
if command -v gitleaks >/dev/null 2>&1; then
  echo "[security] gitleaks (secret detection)"
  if ! gitleaks detect --source . --no-git -q 2>/dev/null; then
    echo "[security] WARNING: gitleaks found potential secrets" >&2
    FAILED=1
  fi
elif command -v trufflehog >/dev/null 2>&1; then
  echo "[security] trufflehog (secret detection)"
  if ! trufflehog filesystem . --no-update --only-verified -q 2>/dev/null; then
    echo "[security] WARNING: trufflehog found potential secrets" >&2
    FAILED=1
  fi
fi

# === Docker Security ===
if [[ -f "Dockerfile" ]] && command -v hadolint >/dev/null 2>&1; then
  echo "[security] hadolint (Dockerfile linting)"
  if ! hadolint Dockerfile 2>/dev/null; then
    echo "[security] WARNING: hadolint found Dockerfile issues" >&2
    FAILED=1
  fi
fi

# === Summary ===
if [[ $FAILED -eq 0 ]]; then
  echo "[security] All security scans passed"
  exit 0
else
  echo "[security] Security scans found issues (see warnings above)" >&2
  echo "[security] NOTE: Some tools may not be installed. Install for full coverage:" >&2
  echo "[security]   npm: npm audit (built-in)" >&2
  echo "[security]   python: pip install pip-audit bandit" >&2
  echo "[security]   go: go install golang.org/x/vuln/cmd/govulncheck@latest" >&2
  echo "[security]   rust: cargo install cargo-audit" >&2
  echo "[security]   generic: pip install semgrep" >&2
  echo "[security]   secrets: brew install gitleaks" >&2
  exit 1
fi
