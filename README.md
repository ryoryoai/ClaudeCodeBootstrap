# Claude Code E2E (Requirements -> Implement -> Review -> Test) + Long-Run Harness

このZIPは、Claude Code に貼り付けて実行する **指示文セット**です。  
目的は、リポジトリ内に以下を自動生成して、要件定義から **実装→レビュー→テストGreen** までを一気通貫で回しつつ、複数日・複数セッションでも進捗が崩れない **長期運用Harness**（進捗・意思決定・リスク管理）を入れることです。

## 使い方（最短）

1. このZIPを **リポジトリのルート**で展開
2. Claude Code をそのリポジトリで起動
3. `01_SETUP_PROMPT.md` を開き、**全文をそのまま** Claude Code に貼り付けて実行
4. 生成されたファイルを確認してコミット
5. 案件を始めるときは `spec/REQ.md` を書いて `02_RUN_E2E_PROMPT.md` を貼り付け
6. 翌日/別セッションで再開する場合は `03_RESUME_PROMPT.md` を貼り付け

## 生成される主なもの

- `.claude/agents/*`：役割分割（harness-manager / req-analyst / implementer / code-reviewer / test-runner）
- `.claude/skills/*`：手順（req-to-plan / test-strategy / review-checklist / quality-gates / harness-maintenance）
- `.claude/settings.json`：Stop hook（終了時に必ずテストを走らせるゲート）
- `harness/*`：長期運用の進捗・意思決定・リスク・作業ログ・Feature一覧
- `scripts/ci.sh` / `scripts/quickcheck.sh`：テスト入口（なければ作成）
- `CLAUDE.md`：プロジェクトルール（E2E手順＋Harness運用ルール）

---

> 注意: Hookで実行するシェルスクリプトはあなたの環境権限で動きます。内容は必ず目視確認してください。
