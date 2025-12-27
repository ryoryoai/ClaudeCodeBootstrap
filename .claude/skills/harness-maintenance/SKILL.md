---
name: harness-maintenance
description: Maintain the long-run harness files (harness/*). Use at session start/end and after meaningful milestones.
---

# harness-maintenance

## Files to maintain

- harness/PROGRESS.md
- harness/FEATURES.json
- harness/WORKLOG.md
- harness/DECISIONS.md
- harness/RISKS.md

## Update rules

### PROGRESS.md

- Keep: Today Goal, Current Status, Next Actions (max 5), Blockers.
- Update at session start and session end.

### FEATURES.json

- Keep features small and structured.
- Each feature should include at least:
  - id, title, status (todo|doing|done|blocked)
  - acceptance_criteria (array of strings)
  - tasks (array of strings)
  - tests (array of strings)
- Update when scope changes, tasks are completed, or new work is discovered.

### WORKLOG.md

- Append short bullets per day.
- Record: what changed, what was fixed, tests run, important outcomes.

### DECISIONS.md / RISKS.md

- Only add when it's meaningful (avoid noise).
- Keep each entry short and actionable.
