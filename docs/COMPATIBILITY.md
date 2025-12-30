# Compatibility Matrix

## Claude Code バージョン互換性

| CCOrch Version | Claude Code Version | Status |
|-------------------|---------------------|--------|
| v1.0.x            | 1.0.x               | Supported |

## 依存関係

### Python

- 最小バージョン: 3.10
- 推奨バージョン: 3.11+

### 必須パッケージ

- `pyyaml>=6.0.1`
- `pytest>=8.0.0`

## hooks 契約

### stdin JSON スキーマ

```json
{
  "session_id": "string",
  "type": "tool_use | tool_result",
  "tool": {
    "name": "string",
    "input": {}
  },
  "message": {}
}
```

### exit code 規約

| Code | 意味 |
|------|------|
| 0    | 許可（allow） |
| 1    | エラー（allow with warning） |
| 2    | 拒否（block） |

## skills 契約

### 必須 frontmatter

```yaml
---
name: skill-name       # ファイル名と一致
description: 説明文
path: /slash-command   # / で始まる
---
```

## agents 契約

### 必須 frontmatter

```yaml
---
name: agent-name       # ファイル名と一致
description: 説明文
tools:                 # オプション
  - Read
  - Glob
model: sonnet          # オプション: sonnet | opus | haiku
---
```

### 有効な tools

- Read, Write, Edit
- Glob, Grep
- Bash
- WebFetch, WebSearch
- Task, TodoWrite
- LSP, AskUserQuestion, NotebookEdit

## Breaking Changes

### v1.0.0

- 初期リリース
