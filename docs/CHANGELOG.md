# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - YYYY-MM-DD

### Added

- Initial ClaudeCodeOrchestrator structure
- Sample skills: `code-review`, `git-commit`
- Sample agent: `explorer`
- Hooks: `pre_tool_use`, `post_tool_use`
- Regression test suite
- Documentation: WORKFLOW.md, COMPATIBILITY.md

### Security

- hooks で危険なツールをブロック可能

---

## バージョニングルール

- **MAJOR**: 破壊的変更（hooks/skills/agents の契約変更）
- **MINOR**: 後方互換性のある機能追加
- **PATCH**: バグ修正

## 上流追従ポリシー

1. Upstream Guardian が変更を検知
2. 回帰テストを実行
3. 検証済みの場合のみ PR 作成
4. 手動レビュー後にマージ
5. tag でバージョン固定
