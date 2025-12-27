# Progress

_Last updated: 2025-12-28_

## Today Goal

- [x] factorial 関数を calculator モジュールに追加する
- [x] 全テスト Green を達成する

## Current Status

- Summary: **完了** - factorial 関数の実装とテストが完了
- What is already done:
  - factorial 関数を src/calculator.ts に追加
  - 5件のテストケースを tests/calculator.test.ts に追加
  - 全品質ゲート PASSED (lint, typecheck, security, tests)
- What remains: なし

## Next Actions (max 5)

1. （次の要件があれば追加）

## Blockers / Unknowns

- なし

## Acceptance Criteria Checklist (from spec/REQ.md)

- [x] (Given) 正の整数 n (When) factorial(n) (Then) n! が返る
- [x] (Given) n = 0 (When) factorial(0) (Then) 1 が返る
- [x] (Given) 負の整数 (When) factorial(-1) (Then) エラー
- [x] (Given) 小数 (When) factorial(3.5) (Then) エラー

## DoD Checklist

- [x] Full tests green (./scripts/ci.sh)
- [x] docs updated (PLAN / IMPLEMENTATION_REPORT / TEST_REPORT)
- [x] harness updated (PROGRESS / FEATURES / WORKLOG)
