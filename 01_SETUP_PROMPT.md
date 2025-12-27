# 01_SETUP_PROMPT — E2E + Long-Run Harness をリポジトリにセットアップする（テンプレ完全版）

あなたは Claude Code として、このリポジトリに以下をセットアップしてください。

- **Harness（長期運用枠組み）**: `harness/*`
- **一気通貫（要件→実装→レビュー→テストGreen）**: `.claude/agents/*` + `.claude/skills/*`
- **品質ゲート（Hooks）**: `.claude/settings.json` の Stop hook でテストを強制
- **テスト入口**: `scripts/ci.sh` と `scripts/quickcheck.sh`

## 方針（重要）

- 既存ファイルがある場合は原則上書きしない。必要なら「追記」か「差分最小の更新」。
- 新規作成が必要なファイルは、下記テンプレを **そのまま** 使って作る。
- すべてのスクリプトは破壊的操作を含めない。

---

## 1) ディレクトリ作成

以下のディレクトリがなければ作成:

- `spec/`
- `docs/`
- `prompts/`
- `harness/`
- `scripts/`
- `.claude/agents/`
- `.claude/skills/`

---

## 2) ルート `CLAUDE.md`

`CLAUDE.md` が無ければ新規作成。既にある場合は内容を残しつつ末尾に追記でもよい。

```md
# E2E Delivery + Long-Run Harness Rules

このリポジトリでは、要件定義（spec/REQ.md）から **実装→レビュー→テストGreen** までを一気通貫で進める。  
また、複数日・複数セッションでも進捗と判断が崩れないように **Harness**（harness/ 配下）を常に更新する。

---

## Inputs

- spec/REQ.md（案件の要件定義）

## Sources of truth

- 進捗・次の一手: `harness/PROGRESS.md`
- feature / todo の構造化一覧: `harness/FEATURES.json`
- 日々の作業ログ: `harness/WORKLOG.md`
- 重要な判断: `harness/DECISIONS.md`
- リスク: `harness/RISKS.md`

## Harness Operating Protocol

### Session Start（毎セッション開始時に必ず実施）

1. `harness/PROGRESS.md` と `harness/FEATURES.json` を読む
2. 今日のゴール（1〜2個）と Next actions（最大5個）を決める
3. 不明点があっても停止しない（合理的な仮定を PROGRESS に明記）

### Session End（毎セッション終了時に必ず実施）

1. `harness/PROGRESS.md` を更新（現状/次の一手/ブロッカー）
2. `harness/WORKLOG.md` に今日の作業を追記（短く）
3. 重要な意思決定があれば `harness/DECISIONS.md` に追記
4. 重大リスクがあれば `harness/RISKS.md` を更新

## E2E Workflow（順番固定）

1. harness-manager: Harness 整備・現状把握・feature更新
2. req-analyst: 要件→実装計画（docs/IMPLEMENTATION_PLAN.md）
3. implementer: 実装＋テスト追加/更新
4. code-reviewer（編集禁止）: 差分レビュー（P0/P1中心）
5. implementer: 指摘反映（必要なら 3-5 繰り返し）
6. test-runner: フルテスト実行→失敗修正→Greenまでループ
7. code-reviewer: 最終差分レビュー（P0/P1が残っていないこと）
8. harness-manager: Harness最終更新（次回の再開手順を明記）

## Definition of Done（DoD）

- `spec/REQ.md` の Acceptance Criteria を満たす
- フルテストが Green（Stop hook により強制される想定）
- docs が更新されている:
  - docs/IMPLEMENTATION_PLAN.md
  - docs/IMPLEMENTATION_REPORT.md
  - docs/TEST_REPORT.md
- Harness が最新:
  - harness/PROGRESS.md
  - harness/FEATURES.json
  - harness/WORKLOG.md

---

## Notes

- スコープは Acceptance Criteria で固定し、拡張しない（必要なら CR として別扱い）。
- 変更は小さく、テストで裏付ける。
```

---

## 3) Harness ファイル作成（harness/\*）

存在しないものを新規作成（既存は上書きしない）。

### `harness/README.md`

```md
# Long-Run Harness

このフォルダは、Claude Code を **複数セッション（複数日）** で運用しても、進捗・判断・次の手が崩れないようにするための “運用枠組み” です。

## 目的

- 進捗（今どこか）と次の手（次に何をするか）を **ファイルで固定**する
- 重要な意思決定やリスクを **後から追跡可能**にする
- エージェントのコンテキストが途切れても、Harnessを読むだけで再開できる状態にする

## 更新ルール（必須）

- セッション開始時: PROGRESS と FEATURES を読む
- セッション終了時: PROGRESS と WORKLOG を更新する
- 大きな判断をしたら: DECISIONS に残す
- リスクが見えたら: RISKS を更新する

## ファイルの役割

- PROGRESS.md: 現状/次の一手/ブロッカー/受入条件の達成状況
- FEATURES.json: 構造化した feature/todo（ステータス管理）
- WORKLOG.md: 日付ごとの簡易ログ
- DECISIONS.md: 重要な判断（ADR）
- RISKS.md: リスク登録簿
```

### `harness/PROGRESS.md`

```md
# Progress

_Last updated: <YYYY-MM-DD>_

## Today Goal

- [ ] <goal 1>
- [ ] <goal 2>

## Current Status

- Summary:
- What is already done:
- What remains:

## Next Actions (max 5)

1.
2.
3.
4.
5.

## Blockers / Unknowns

-

## Acceptance Criteria Checklist (from spec/REQ.md)

- [ ]
- [ ]

## DoD Checklist

- [ ] Full tests green (./scripts/ci.sh)
- [ ] docs updated (PLAN / IMPLEMENTATION_REPORT / TEST_REPORT)
- [ ] harness updated (PROGRESS / FEATURES / WORKLOG)
```

### `harness/WORKLOG.md`

```md
# Worklog

## <YYYY-MM-DD>

-

## <YYYY-MM-DD>

-
```

### `harness/DECISIONS.md`

```md
# Decisions (ADR)

## ADR-001: <title>

- Date: <YYYY-MM-DD>
- Context:
- Decision:
- Consequences:
```

### `harness/RISKS.md`

```md
# Risks

| ID    | Risk | Impact | Mitigation | Status |
| ----- | ---- | ------ | ---------- | ------ |
| R-001 |      |        |            | Open   |
```

### `harness/FEATURES.json`

```json
{
  "schema_version": 1,
  "features": []
}
```

---

## 4) spec/REQ.md（テンプレ）

`spec/REQ.md` が無ければ新規作成。既にある場合は `spec/REQ_TEMPLATE.md` として作る。

```md
# REQ: <機能名>

## Goal

- ユーザーが◯◯できること

## Non-goals (NOT-DO)

- 今回は××はやらない

## Acceptance Criteria

- [ ] (Given) ... (When) ... (Then) ...
- [ ] ...

## Constraints

- Tech stack:
- Existing behaviors:
- Performance / Security:

## Definition of Done

- [ ] ユニットテスト追加/更新
- [ ] 既存テスト含め全テストGreen
- [ ] lint/typecheck が Green（存在する場合）
- [ ] 変更点とテスト結果を docs/ に記録
- [ ] Harness（harness/PROGRESS.md, FEATURES.json）が最新
```

---

## 5) docs 初期ファイル

存在しない場合に新規作成:

### `docs/IMPLEMENTATION_PLAN.md`

```md
# Implementation Plan

## Restated Goal

-

## Non-goals

-

## Acceptance Criteria

- [ ]
- [ ]

## Task Breakdown (ordered)

1.
2.
3.

## Test Plan

- Unit:
- Integration:
- E2E:

## Risks / Assumptions

-
```

### `docs/IMPLEMENTATION_REPORT.md`

```md
# Implementation Report

## Summary

-

## Files Changed

-

## Notes

- Edge cases:
- Backward compatibility / migrations:
- How to test:
```

### `docs/TEST_REPORT.md`

```md
# Test Report

## Commands Used

-

## Result

- Status: (GREEN/RED)
- Date:

## Failures Encountered (if any)

-

## Fixes Applied (if any)

-
```

---

## 6) prompts/e2e-system.txt

`prompts/e2e-system.txt` を作成（既存があればレビューして不足を追記）。

```text
You are an end-to-end delivery orchestrator.

Operating constraints:
- Follow the project rules in CLAUDE.md.
- Use the long-run harness in ./harness (PROGRESS.md, FEATURES.json, WORKLOG.md).
- Use subagents proactively (harness-manager, req-analyst, implementer, code-reviewer, test-runner).
- Do not stop until full tests are green and reports are updated.

Output expectations:
- Keep progress updated in harness/PROGRESS.md and harness/WORKLOG.md
- Ensure docs/IMPLEMENTATION_PLAN.md, docs/IMPLEMENTATION_REPORT.md, docs/TEST_REPORT.md are updated

```

---

## 7) Subagents（.claude/agents/\*）

以下ファイルを作成（既存があれば最小差分で更新）。

### `.claude/agents/harness-manager.md`

```md
---
name: harness-manager
description: MUST BE USED at the start and end of any delivery session. Maintains harness/* files, tracks progress, and coordinates subagents. Does NOT implement product code.
tools: Read, Glob, Grep, Edit, Bash
model: inherit
skills: harness-maintenance, req-to-plan
permissionMode: acceptEdits
---

You are the harness manager.

Primary responsibilities:

- Ensure harness/ exists and required files are present (PROGRESS.md, FEATURES.json, WORKLOG.md, DECISIONS.md, RISKS.md).
- Keep progress and next actions up to date so that another session can resume purely from harness/ files.
- Keep scope tight and aligned with spec/REQ.md acceptance criteria.
- Coordinate the workflow by delegating to other subagents in the required order.

Session Start Checklist:

1. Read harness/PROGRESS.md and harness/FEATURES.json.
2. Read spec/REQ.md (if exists) and confirm the current acceptance criteria.
3. Update harness/PROGRESS.md with today's goals and next actions.
4. If FEATURES.json is empty or outdated, create/update it with:
   - id, title, status, acceptance_criteria, tasks, tests, files (optional), notes.

Session End Checklist:

1. Update harness/PROGRESS.md (current status + next actions + blockers).
2. Append to harness/WORKLOG.md (short bullets).
3. If a key design choice was made, update harness/DECISIONS.md.
4. If a new risk emerged, update harness/RISKS.md.

Hard rules:

- Never implement product code (delegate to implementer).
- Keep harness files concise (avoid massive dumps).
```

### `.claude/agents/req-analyst.md`

```md
---
name: req-analyst
description: MUST BE USED proactively when a new spec/REQ.md is provided or scope needs breakdown. Produces an implementation plan and a test plan.
tools: Read, Glob, Grep, Edit
model: inherit
skills: req-to-plan, test-strategy
permissionMode: acceptEdits
---

You are a requirements analyst.

Input:

- spec/REQ.md

Output:

- docs/IMPLEMENTATION_PLAN.md

docs/IMPLEMENTATION_PLAN.md must include:

- Restated Goal / Non-goals
- Acceptance Criteria checklist (testable; Given/When/Then preferred)
- Task breakdown (ordered)
- Suspected files/modules to change
- Test plan (unit/integration/e2e) and how to run
- Assumptions & risks

Rules:

- Do not implement code.
- If something is unclear, make a reasonable assumption and document it.
```

### `.claude/agents/implementer.md`

```md
---
name: implementer
description: MUST BE USED to implement tasks from docs/IMPLEMENTATION_PLAN.md. Writes code and tests. Keeps changes minimal and consistent. Updates reports/harness.
tools: Read, Glob, Grep, Edit, Bash
model: inherit
skills: quality-gates, harness-maintenance
permissionMode: acceptEdits
---

You are a senior engineer implementing the plan.

Process:

1. Read docs/IMPLEMENTATION_PLAN.md.
2. Implement in small increments.
3. Add/adjust tests for changed behavior.
4. Run quick checks when available (./scripts/quickcheck.sh).

Reporting:

- Update docs/IMPLEMENTATION_REPORT.md with:
  - What changed and why
  - Files changed
  - Notes on edge cases
  - How to test (commands)
- Append short entries to harness/WORKLOG.md when meaningful milestones are reached.

Constraints:

- Do not broaden scope beyond Acceptance Criteria.
- Never declare done without tests passing.
```

### `.claude/agents/code-reviewer.md`

```md
---
name: code-reviewer
description: MUST BE USED after code changes. Read-only reviewer. Reviews for correctness, security, maintainability, and test coverage. DO NOT edit files.
tools: Read, Glob, Grep, Bash
model: inherit
skills: review-checklist
permissionMode: default
---

You are a strict code reviewer.

Rules:

- Never edit files (no Edit tool available).
- Review only the diff and relevant context.

How to review:

- Use git status / git diff to identify changes.
- Focus on P0/P1 issues: correctness, security, breaking changes, missing tests.
- Provide actionable suggestions: file path, location, risk, exact fix idea.

Output format:

- Summary (1–3 bullets)
- Findings:
  - P0 (must fix), P1 (should fix), P2 (nice to have)
  - Each includes: file path, reasoning, concrete fix suggestion
- Test gaps:
  - What tests to add/update
```

### `.claude/agents/test-runner.md`

```md
---
name: test-runner
description: MUST BE USED to run the full test suite and fix failures. Re-run until green. Updates test report and harness.
tools: Read, Glob, Grep, Edit, Bash
model: inherit
skills: quality-gates, harness-maintenance
permissionMode: acceptEdits
---

You are a test automation specialist.

Primary objective:

- Run the full test suite (./scripts/ci.sh).
- If failures occur: fix minimal root cause and re-run until GREEN.

Reporting:

- Update docs/TEST_REPORT.md with:
  - commands used
  - final result (GREEN)
  - notable failures encountered and fixes applied
- Append brief notes to harness/WORKLOG.md.

Constraints:

- Keep fixes minimal and within scope.
- Do not skip tests unless there is a clear reason and it is documented.
```

---

## 8) Skills（.claude/skills/\*）

以下を作成（既存があれば必要最小限の差分で統合）。

### `.claude/skills/req-to-plan/SKILL.md`

```md
---
name: req-to-plan
description: Convert spec/REQ.md into a concrete implementation plan. Use when a requirements doc is provided or scope needs breakdown.
---

# req-to-plan

## Output

- docs/IMPLEMENTATION_PLAN.md

## Must include

- Goal / Non-goals
- Acceptance Criteria (testable checklist)
- Ordered task list
- Impacted files/modules (likely)
- Test plan (unit/integration/e2e)
- Risks & assumptions
```

### `.claude/skills/test-strategy/SKILL.md`

```md
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
```

### `.claude/skills/review-checklist/SKILL.md`

```md
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
```

### `.claude/skills/quality-gates/SKILL.md`

```md
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
```

### `.claude/skills/harness-maintenance/SKILL.md`

```md
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
```

---

## 9) Quality gate（Stop hook）用スクリプト

以下を作成し、実行権限を付与:

### `.claude/skills/quality-gates/scripts/stop_gate.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-.}"

if [[ ! -x "./scripts/ci.sh" ]]; then
  echo "[stop_gate] ERROR: ./scripts/ci.sh が見つからないか実行権限がありません。" >&2
  echo "[stop_gate] scripts/ci.sh を用意し、chmod +x scripts/ci.sh を実行してください。" >&2
  exit 2
fi

echo "[stop_gate] Running full tests via ./scripts/ci.sh"
if ! ./scripts/ci.sh; then
  echo "[stop_gate] Tests failed. Fix failures and re-run." >&2
  exit 2
fi

echo "[stop_gate] Tests are green."
exit 0

```

---

## 10) scripts/ci.sh / scripts/quickcheck.sh

存在しなければ作成し、実行権限を付与:

### `scripts/ci.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[ci] Running full test suite..."

# If project provides a dedicated CI command, prefer it:
if [[ -x "./scripts/project_ci.sh" ]]; then
  echo "[ci] Using ./scripts/project_ci.sh"
  ./scripts/project_ci.sh
  exit 0
fi

# Makefile
if [[ -f "Makefile" ]]; then
  if grep -qE '^ci:' Makefile; then
    echo "[ci] make ci"
    make ci
    exit 0
  fi
  if grep -qE '^test:' Makefile; then
    echo "[ci] make test"
    make test
    exit 0
  fi
fi

# Node.js
if [[ -f "package.json" ]]; then
  if [[ -f "pnpm-lock.yaml" ]] && command -v pnpm >/dev/null 2>&1; then
    echo "[ci] pnpm test"
    pnpm -s test
    exit 0
  fi
  if [[ -f "yarn.lock" ]] && command -v yarn >/dev/null 2>&1; then
    echo "[ci] yarn test"
    yarn test
    exit 0
  fi
  if command -v npm >/dev/null 2>&1; then
    echo "[ci] npm test"
    npm -s test
    exit 0
  fi
fi

# Python
if [[ -f "pyproject.toml" || -f "pytest.ini" || -d "tests" ]]; then
  if command -v python >/dev/null 2>&1; then
    echo "[ci] python -m pytest"
    python -m pytest
    exit 0
  fi
  if command -v pytest >/dev/null 2>&1; then
    echo "[ci] pytest"
    pytest
    exit 0
  fi
fi

# Go
if [[ -f "go.mod" ]] && command -v go >/dev/null 2>&1; then
  echo "[ci] go test ./..."
  go test ./...
  exit 0
fi

# Rust
if [[ -f "Cargo.toml" ]] && command -v cargo >/dev/null 2>&1; then
  echo "[ci] cargo test"
  cargo test
  exit 0
fi

echo "[ci] ERROR: Could not determine how to run tests. Please customize scripts/ci.sh for this repo." >&2
exit 2

```

### `scripts/quickcheck.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

echo "[quickcheck] Running quick checks..."

# If project provides a dedicated quickcheck, prefer it:
if [[ -x "./scripts/project_quickcheck.sh" ]]; then
  echo "[quickcheck] Using ./scripts/project_quickcheck.sh"
  ./scripts/project_quickcheck.sh
  exit 0
fi

# Default: run full suite (override per repo if needed)
./scripts/ci.sh

```

---

## 11) Hooks 設定（.claude/settings.json）

`.claude/settings.json` を作成（既存なら Stop hook を統合）。テンプレ:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/skills/quality-gates/scripts/stop_gate.sh",
            "timeout": 900
          }
        ]
      }
    ]
  }
}
```

---

## 12) 最終チェック（必須）

1. 以下に実行権限を付与（未付与の場合）
   - `chmod +x scripts/ci.sh scripts/quickcheck.sh .claude/skills/quality-gates/scripts/stop_gate.sh`
2. `git status` を実行して変更を確認
3. 可能なら `./scripts/quickcheck.sh` を実行（失敗しても良いが、原因を短くメモ）
4. 最後に、作成/更新したファイル一覧を箇条書きで出力

以上を実行してセットアップを完了してください。
