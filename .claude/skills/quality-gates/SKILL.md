---
name: quality-gates
description: Run quick checks and full CI tests. Use after edits, before finishing, or when tests fail.
---

# quality-gates

## Commands

- Quick: ./scripts/quickcheck.sh
- Full : ./scripts/ci.sh

## Rules

- If tests fail: fix and re-run until green.
- Do not claim completion without green full test run.
- Prefer minimal fixes aligned with acceptance criteria.
