---
name: review-checklist
description: Review checklist for PR-style diffs. Use after code changes. Focus on correctness, security, maintainability, and tests.
---

# review-checklist

## P0 / Must fix

- Incorrect behavior vs acceptance criteria
- Security issues (authz, injection, secrets, PII logging)
- Breaking changes without migration/backward compatibility
- Missing tests for changed logic
- Flaky tests / nondeterminism introduced

## P1 / Should fix

- Poor error handling / missing validation
- Hard-to-maintain structure (high complexity)
- Performance regressions in hot paths
- Inconsistent naming / unclear responsibilities

## Output format

- Summary
- Findings (P0/P1/P2)
- Test gaps
