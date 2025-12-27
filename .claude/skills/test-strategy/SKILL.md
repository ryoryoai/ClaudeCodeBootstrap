---
name: test-strategy
description: Define test strategy based on acceptance criteria. Use when planning changes or when test coverage is unclear.
---

# test-strategy

## Guidance

- Map each Acceptance Criteria to at least one test (unit/integration/e2e).
- Prefer unit tests for pure logic; integration tests for IO/DB/API boundaries; e2e only for critical flows.
- Include negative and edge cases (validation, authz, empty inputs, large inputs).

## Output suggestions

- Add a "Test Plan" section in docs/IMPLEMENTATION_PLAN.md.
