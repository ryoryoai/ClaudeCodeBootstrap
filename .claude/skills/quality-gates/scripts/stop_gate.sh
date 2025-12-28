#!/usr/bin/env bash
# Stop Hook: Quality Gate
# Runs before Claude can declare "done"
# Ensures: tests pass, lint passes, no security issues

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}"

echo "========================================"
echo "[stop_gate] Quality Gate Check"
echo "========================================"

FAILED=0

# === 1. LINT / TYPE CHECK ===
if [[ -x "./scripts/lint.sh" ]]; then
  echo ""
  echo "[stop_gate] Step 1/3: Lint & Type Check"
  echo "----------------------------------------"
  if ! ./scripts/lint.sh; then
    echo "[stop_gate] ERROR: Lint/type check failed" >&2
    FAILED=1
  fi
else
  echo "[stop_gate] Step 1/3: Lint (skipped - no scripts/lint.sh)"
fi

# === 2. SECURITY SCAN ===
if [[ -x "./scripts/security_scan.sh" ]]; then
  echo ""
  echo "[stop_gate] Step 2/3: Security Scan"
  echo "----------------------------------------"
  if ! ./scripts/security_scan.sh; then
    echo "[stop_gate] WARNING: Security scan found issues" >&2
    # Security issues are warnings, not blockers (can be false positives)
    # Change to FAILED=1 if you want to block on security issues
  fi
else
  echo "[stop_gate] Step 2/3: Security (skipped - no scripts/security_scan.sh)"
fi

# === 3. TESTS ===
if [[ -x "./scripts/ci.sh" ]]; then
  echo ""
  echo "[stop_gate] Step 3/3: Full Test Suite"
  echo "----------------------------------------"
  if ! ./scripts/ci.sh; then
    echo "[stop_gate] ERROR: Tests failed" >&2
    FAILED=1
  fi
else
  echo "[stop_gate] Step 3/3: Tests (skipped - no scripts/ci.sh)"
  echo "[stop_gate] WARNING: No test script found. Create scripts/ci.sh" >&2
fi

# === SUMMARY ===
echo ""
echo "========================================"
if [[ $FAILED -eq 0 ]]; then
  echo "[stop_gate] All quality gates PASSED"
  echo "========================================"
  exit 0
else
  echo "[stop_gate] Quality gates FAILED"
  echo "========================================"
  echo "[stop_gate] Fix the issues above and try again." >&2
  exit 2
fi
