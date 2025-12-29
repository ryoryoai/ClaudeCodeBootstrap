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
  - **spec_file**: path to source spec file (e.g., "spec/01-auth.md")
  - **priority**: numeric priority from spec file
  - acceptance_criteria (array of strings)
  - tasks (array of strings)
  - tests (array of strings)
  - **depends_on**: array of feature IDs (optional)
- Update when scope changes, tasks are completed, or new work is discovered.
- When a new spec file is added, create a corresponding feature entry.

### WORKLOG.md

- Append short bullets per day.
- Record: what changed, what was fixed, tests run, important outcomes.

### DECISIONS.md / RISKS.md

- Only add when it's meaningful (avoid noise).
- Keep each entry short and actionable.
