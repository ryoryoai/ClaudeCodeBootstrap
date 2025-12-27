# 02_RUN_E2E_PROMPT — 要件定義から一気通貫で完了（Harness運用込み）

以下を実行してください。入力は `spec/REQ.md` です。

## 実行ルール

- Harness を必ず使う（進捗を `harness/PROGRESS.md` と `harness/FEATURES.json` に維持）
- 工程は必ず「harness-manager → req-analyst → implementer → code-reviewer → implementer(修正) → test-runner → code-reviewer(最終)」の順
- DoD:
  - 受入条件を満たす
  - フルテスト Green（Stop hook がある前提）
  - docs/IMPLEMENTATION_REPORT.md と docs/TEST_REPORT.md 更新
  - harness/PROGRESS.md / WORKLOG.md / FEATURES.json 更新

## 指示

1. harness-manager:
   - `harness/PROGRESS.md` / `FEATURES.json` を読み、今回の作業対象 feature を明確化
   - 無ければ `spec/REQ.md` から初期 feature を作り、FEATURES.json を更新
   - PROGRESS.md に「今回のゴール/次のアクション」を書く

2. req-analyst:
   - `spec/REQ.md` を読み、docs/IMPLEMENTATION_PLAN.md を作成
   - 受入条件を testable なチェックリスト化
   - テスト計画（unit/integration/e2e）と実行コマンドを提案

3. implementer:
   - PLAN に沿って実装とテスト追加
   - 変更点を docs/IMPLEMENTATION_REPORT.md と harness/WORKLOG.md に記録

4. code-reviewer（編集禁止）:
   - 差分をレビューし、P0/P1 を中心に指摘（ファイル/理由/修正案）

5. implementer:
   - 指摘を反映して修正（必要なら 3-5 を繰り返す）
   - レポート更新

6. test-runner:
   - `./scripts/ci.sh` を実行
   - 失敗したら最小修正して再実行し、Green までループ
   - 結果を docs/TEST_REPORT.md と harness/WORKLOG.md に記録

7. code-reviewer（最終）:
   - 最終差分を確認し、P0/P1 が残っていないことを宣言

最後に harness-manager が `harness/PROGRESS.md` を更新し、次回セッションの再開手順（Next actions）を明記してください。
