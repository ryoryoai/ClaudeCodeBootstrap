# create-cco

[English](#english) | [日本語](#japanese)

---

<a id="english"></a>

## English

ClaudeCodeOrchestrator (CCOrch) - Instantly setup your Claude Code configuration with best practices.

### Installation

```bash
npx create-cco
```

### Options

```bash
npx create-cco          # Install to current directory
npx create-cco --force  # Overwrite existing .claude directory
```

### What's Included

```
.claude/
├── settings.json       # Claude Code settings
├── skills/             # Custom skills (code-review, git-commit, etc.)
├── agents/             # Custom agents (code-reviewer, test-runner, etc.)
├── commands/           # Custom commands (start-session, run-tests, etc.)
└── hooks/              # Pre/post tool hooks
```

### Skills

| Skill | Description |
|-------|-------------|
| code-review | Automated code review with best practices |
| git-commit | Structured commit message generation |
| quality-gates | Quality checkpoints for development |
| req-to-plan | Requirements to implementation plan |
| review-checklist | Code review checklist |
| test-strategy | Test strategy generation |

### Agents

| Agent | Description |
|-------|-------------|
| code-reviewer | Reviews code changes |
| test-runner | Runs and analyzes tests |
| implementer | Implements features |
| explorer | Explores codebase |
| req-analyst | Analyzes requirements |

### Commands

| Command | Description |
|---------|-------------|
| /start-session | Start a development session |
| /end-session | End session with summary |
| /run-tests | Run tests |
| /review-changes | Review current changes |
| /implement | Implement a feature |

### After Installation

1. Open the project in VS Code / Cursor
2. Start Claude Code
3. Use `/start-session` to begin

### Update

```bash
npx create-cco@latest --force
```

### Links

- [npm](https://www.npmjs.com/package/create-cco)
- [GitHub](https://github.com/ryoryoai/ClaudeCodeOrch)

---

<a id="japanese"></a>

## 日本語

ClaudeCodeOrchestrator（CCOrch） - Claude Code の設定をベストプラクティスで即座にセットアップ。

### インストール

```bash
npx create-cco
```

### オプション

```bash
npx create-cco          # カレントディレクトリにインストール
npx create-cco --force  # 既存の .claude ディレクトリを上書き
```

### 含まれるもの

```
.claude/
├── settings.json       # Claude Code 設定
├── skills/             # カスタムスキル (code-review, git-commit 等)
├── agents/             # カスタムエージェント (code-reviewer, test-runner 等)
├── commands/           # カスタムコマンド (start-session, run-tests 等)
└── hooks/              # ツール実行前後のフック
```

### スキル一覧

| スキル | 説明 |
|--------|------|
| code-review | ベストプラクティスに基づく自動コードレビュー |
| git-commit | 構造化されたコミットメッセージ生成 |
| quality-gates | 開発の品質チェックポイント |
| req-to-plan | 要件から実装計画への変換 |
| review-checklist | コードレビューチェックリスト |
| test-strategy | テスト戦略の生成 |

### エージェント一覧

| エージェント | 説明 |
|--------------|------|
| code-reviewer | コード変更をレビュー |
| test-runner | テスト実行・分析 |
| implementer | 機能実装 |
| explorer | コードベース探索 |
| req-analyst | 要件分析 |

### コマンド一覧

| コマンド | 説明 |
|----------|------|
| /start-session | 開発セッション開始 |
| /end-session | セッション終了（サマリ付き） |
| /run-tests | テスト実行 |
| /review-changes | 現在の変更をレビュー |
| /implement | 機能を実装 |

### インストール後

1. VS Code / Cursor でプロジェクトを開く
2. Claude Code を起動
3. `/start-session` で開始

### 更新

```bash
npx create-cco@latest --force
```

### リンク

- [npm](https://www.npmjs.com/package/create-cco)
- [GitHub](https://github.com/ryoryoai/ClaudeCodeOrch)

---

## License

MIT
