# Claude Code Bootstrap

[English](#english) | [日本語](#japanese)

---

<a id="english"></a>

## English

A production-ready bootstrap for AI-driven development with Claude Code. Includes skills, agents, commands, and hooks.

## Quick Start

```bash
npx create-ccb
```

That's it! Your project now has a complete Claude Code configuration.

## Features

- **6 Skills** - Code review, git commit, quality gates, and more
- **5 Agents** - Code reviewer, test runner, implementer, explorer, analyst
- **5 Commands** - Session management, testing, review workflows
- **Hooks** - Pre/post tool execution hooks for safety

## Installation

### Using npx (Recommended)

```bash
# Go to your project
cd /path/to/your/project

# Install Claude Code Bootstrap
npx create-ccb
```

### Options

```bash
npx create-ccb          # Install to current directory
npx create-ccb --force  # Overwrite existing .claude directory
```

### Manual Installation

Clone this repository and copy the `.claude` folder to your project:

```bash
git clone https://github.com/ryoryoai/ClaudeCodeBootstrap.git
cp -r ClaudeCodeBootstrap/.claude /path/to/your/project/
```

## What's Included

```
.claude/
├── settings.json       # Claude Code settings
├── skills/             # Custom skills
│   ├── code-review.md
│   ├── git-commit.md
│   ├── quality-gates/
│   ├── req-to-plan/
│   ├── review-checklist/
│   └── test-strategy/
├── agents/             # Custom agents
│   ├── code-reviewer.md
│   ├── test-runner.md
│   ├── implementer.md
│   ├── explorer.md
│   └── req-analyst.md
├── commands/           # Custom commands
│   ├── start-session.md
│   ├── end-session.md
│   ├── run-tests.md
│   ├── review-changes.md
│   └── implement.md
└── hooks/              # Tool hooks
    └── pre_tool_use.sh
```

## Skills

| Skill | Description |
|-------|-------------|
| code-review | Automated code review with best practices |
| git-commit | Structured commit message generation |
| quality-gates | Quality checkpoints for development |
| req-to-plan | Requirements to implementation plan |
| review-checklist | Code review checklist |
| test-strategy | Test strategy generation |

## Agents

| Agent | Description |
|-------|-------------|
| code-reviewer | Reviews code changes for quality and issues |
| test-runner | Runs and analyzes test results |
| implementer | Implements features based on requirements |
| explorer | Explores and understands codebase |
| req-analyst | Analyzes and clarifies requirements |

## Commands

| Command | Description |
|---------|-------------|
| /start-session | Start a development session with context |
| /end-session | End session with summary and next steps |
| /run-tests | Run tests and analyze results |
| /review-changes | Review current uncommitted changes |
| /implement | Implement a feature or fix |

## Usage

After installation, open your project in VS Code or Cursor and start Claude Code:

```bash
# Start a session
/start-session

# Ask Claude to implement something
Implement user authentication with JWT

# Review your changes
/review-changes

# Run tests
/run-tests

# End session
/end-session
```

## Update

```bash
npx create-ccb@latest --force
```

## Links

- [npm package](https://www.npmjs.com/package/create-ccb)
- [Upstream Guardian](https://github.com/ryoryoai/claude-upstream-guardian)

---

<a id="japanese"></a>

## 日本語

Claude Code を使った AI 駆動開発のための本番対応ブートストラップ。スキル、エージェント、コマンド、フックを含みます。

## クイックスタート

```bash
npx create-ccb
```

これだけ！プロジェクトに完全な Claude Code 設定が追加されます。

## 特徴

- **6つのスキル** - コードレビュー、gitコミット、品質ゲートなど
- **5つのエージェント** - コードレビュアー、テストランナー、実装者、探索者、アナリスト
- **5つのコマンド** - セッション管理、テスト、レビューワークフロー
- **フック** - 安全のためのツール実行前後フック

## インストール

### npx を使用（推奨）

```bash
# プロジェクトに移動
cd /path/to/your/project

# Claude Code Bootstrap をインストール
npx create-ccb
```

### オプション

```bash
npx create-ccb          # カレントディレクトリにインストール
npx create-ccb --force  # 既存の .claude ディレクトリを上書き
```

### 手動インストール

リポジトリをクローンして `.claude` フォルダをプロジェクトにコピー：

```bash
git clone https://github.com/ryoryoai/ClaudeCodeBootstrap.git
cp -r ClaudeCodeBootstrap/.claude /path/to/your/project/
```

## 含まれるもの

```
.claude/
├── settings.json       # Claude Code 設定
├── skills/             # カスタムスキル
│   ├── code-review.md
│   ├── git-commit.md
│   ├── quality-gates/
│   ├── req-to-plan/
│   ├── review-checklist/
│   └── test-strategy/
├── agents/             # カスタムエージェント
│   ├── code-reviewer.md
│   ├── test-runner.md
│   ├── implementer.md
│   ├── explorer.md
│   └── req-analyst.md
├── commands/           # カスタムコマンド
│   ├── start-session.md
│   ├── end-session.md
│   ├── run-tests.md
│   ├── review-changes.md
│   └── implement.md
└── hooks/              # ツールフック
    └── pre_tool_use.sh
```

## スキル一覧

| スキル | 説明 |
|--------|------|
| code-review | ベストプラクティスに基づく自動コードレビュー |
| git-commit | 構造化されたコミットメッセージ生成 |
| quality-gates | 開発の品質チェックポイント |
| req-to-plan | 要件から実装計画への変換 |
| review-checklist | コードレビューチェックリスト |
| test-strategy | テスト戦略の生成 |

## エージェント一覧

| エージェント | 説明 |
|--------------|------|
| code-reviewer | コード変更の品質と問題をレビュー |
| test-runner | テスト実行と結果分析 |
| implementer | 要件に基づいて機能を実装 |
| explorer | コードベースの探索と理解 |
| req-analyst | 要件の分析と明確化 |

## コマンド一覧

| コマンド | 説明 |
|----------|------|
| /start-session | コンテキスト付きで開発セッション開始 |
| /end-session | サマリと次のステップでセッション終了 |
| /run-tests | テスト実行と結果分析 |
| /review-changes | 未コミットの変更をレビュー |
| /implement | 機能やフィックスを実装 |

## 使い方

インストール後、VS Code または Cursor でプロジェクトを開き、Claude Code を起動：

```bash
# セッション開始
/start-session

# Claude に実装を依頼
JWT を使ったユーザー認証を実装して

# 変更をレビュー
/review-changes

# テスト実行
/run-tests

# セッション終了
/end-session
```

## 更新

```bash
npx create-ccb@latest --force
```

## リンク

- [npm パッケージ](https://www.npmjs.com/package/create-ccb)
- [Upstream Guardian](https://github.com/ryoryoai/claude-upstream-guardian)

---

## License

MIT
