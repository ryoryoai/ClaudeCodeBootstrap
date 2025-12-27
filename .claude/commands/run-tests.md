---
description: Run the full test suite and report results
---

# Run Tests

Execute the full test suite and handle any failures.

## Steps

1. Run ./scripts/ci.sh
2. If tests pass:
   - Update docs/TEST_REPORT.md with GREEN status
   - Report success
3. If tests fail:
   - Analyze the failure
   - Fix the root cause (minimal changes)
   - Re-run tests
   - Repeat until GREEN
4. Update harness/WORKLOG.md with test results

## Constraints

- Do not skip tests
- Do not weaken test assertions
- Fix the implementation, not the tests
- Keep fixes minimal and within scope
