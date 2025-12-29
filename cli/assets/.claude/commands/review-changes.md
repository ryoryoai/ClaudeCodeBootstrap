---
description: Review current changes (read-only code review)
---

# Review Changes

Perform a code review of the current changes. This is a READ-ONLY operation.

## Steps

1. Run `git status` to see changed files
2. Run `git diff` to see the actual changes
3. Review for:
   - P0 (must fix): correctness, security, breaking changes, missing tests
   - P1 (should fix): error handling, complexity, performance
   - P2 (nice to have): style, naming

## Output Format

### Summary

- Brief description of changes

### Findings

#### P0 - Must Fix

- [file:line] Issue description
  - Risk: ...
  - Fix: ...

#### P1 - Should Fix

- [file:line] Issue description
  - Suggestion: ...

#### P2 - Nice to Have

- [file:line] Minor suggestion

### Test Gaps

- Tests that should be added
