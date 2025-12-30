# Workflow Guide

## 概要

このリポジトリは Claude Code を使った AI 駆動開発の「配布用 Orchestrator」です。
検証済みの skills / agents / hooks / harness のみを含みます。

## 運用フロー

```
[Upstream Guardian が上流変更を検知]
   ↓
[回帰テスト実行]
   ↓
[検証済みなら ClaudeCodeOrch に PR]
   ↓
[レビュー → マージ（手動）]
   ↓
[tag でバージョン固定]
```

## セットアップ

```bash
# 1. リポジトリをクローン
git clone https://github.com/ryoryoai/ClaudeCodeOrch.git
cd ClaudeCodeOrch

# 2. 依存関係をインストール
pip install -r requirements.txt -r requirements-dev.txt

# 3. 回帰テストを実行
make regression

# 4. Claude Code で使用
claude --config .claude/settings.json
```

## バージョン管理

- 本番環境では必ず **tag 固定** で使用してください
- 例: `git checkout v1.0.0`
- 最新版への追従は CR（Change Request）扱いです

## 顧客案件での使用

顧客案件では ClaudeCodeOrch の最新版追従は **禁止** です。

1. 案件開始時に特定の tag をチェックアウト
2. 案件期間中はそのバージョンを固定
3. アップグレードが必要な場合は CR を起票

## トラブルシューティング

### hooks がエラーになる場合

```bash
# hooks の構文チェック
python -m py_compile hooks/pre_tool_use.py
python -m py_compile hooks/post_tool_use.py
```

### skills/agents が認識されない場合

- `.claude/skills/*.md` と `.claude/agents/*.md` に配置されているか確認
- YAML frontmatter が正しい形式か確認
