---
description: Start a new delivery session (reads harness, sets goals)
---

# Start Session

You are starting a new delivery session. Follow the Harness Operating Protocol from CLAUDE.md.

## Steps

1. Read harness/PROGRESS.md and harness/FEATURES.json
2. Discover spec files:
   - Glob `spec/*.md` to find all requirement files
   - Parse YAML front matter if present
   - Sort by priority (front matter `priority` > filename prefix > alphabetical)
   - Read files in priority order
3. Determine today's goals (1-2 items) based on highest-priority incomplete spec
4. Update harness/PROGRESS.md with:
   - Today Goal
   - Current Status
   - Next Actions (max 5)
   - Active Spec File(s)
5. If any blockers or unknowns, document them

## Spec File Format (recommended)

```yaml
---
priority: 1
title: "Feature Name"
status: todo | in-progress | done
---
```

## Output

Provide a brief summary:

- What was done last session
- What we'll focus on today
- Active spec files being processed
- Any blockers or decisions needed
