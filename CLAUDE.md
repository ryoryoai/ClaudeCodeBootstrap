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
