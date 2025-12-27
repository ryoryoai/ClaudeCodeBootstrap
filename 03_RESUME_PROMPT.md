# 03_RESUME_PROMPT — 別セッションでの再開（Harnessベース）

このセッションは “続き” です。Harness を起点に再開してください。

## 指示

1. `harness/PROGRESS.md` と `harness/FEATURES.json` を読み、
   - どこまで終わっているか
   - 何が未完か（Next actions）
   - 既知のブロッカー
     を短く整理する

2. 未完の Next actions を、最短で DoD に到達する順に並べ替える

3. 必要な subagent を順番に起動して進める（例）
   - 設計/要件の再整理が必要なら: req-analyst
   - 実装修正なら: implementer
   - レビューなら: code-reviewer
   - テスト失敗修正なら: test-runner

4. 作業の最後に必ず
   - `harness/PROGRESS.md` 更新（今の到達点・次の一手）
   - `harness/WORKLOG.md` に今日の作業ログ追記
     を行う
