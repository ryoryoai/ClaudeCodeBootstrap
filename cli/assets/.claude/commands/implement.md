---
description: Implement the next task from the implementation plan
---

# Implement Next Task

Implement the next task from docs/IMPLEMENTATION_PLAN.md.

## Steps

1. Read docs/IMPLEMENTATION_PLAN.md
2. Identify the next incomplete task
3. Implement in small increments:
   - Write/modify code
   - Add/update tests
   - Run quick checks if available (./scripts/quickcheck.sh)
4. Update docs/IMPLEMENTATION_REPORT.md:
   - What changed and why
   - Files changed
   - Edge cases handled
5. Append to harness/WORKLOG.md when milestones are reached

## Constraints

- Stay within scope (Acceptance Criteria only)
- Do not expand scope
- Ensure tests cover the changes
- Do not claim done without passing tests
