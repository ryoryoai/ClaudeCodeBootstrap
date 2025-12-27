# REQ: Calculator Module - Factorial Function

## Goal

- calculatorモジュールに `factorial` 関数を追加する

## Non-goals (NOT-DO)

- 他の数学関数の追加は今回はやらない
- パフォーマンス最適化は今回はやらない

## Acceptance Criteria

- [ ] (Given) 正の整数 n (When) factorial(n) を呼び出す (Then) n! の結果が返る
- [ ] (Given) n = 0 (When) factorial(0) を呼び出す (Then) 1 が返る
- [ ] (Given) 負の整数 (When) factorial(-1) を呼び出す (Then) エラーがスローされる
- [ ] (Given) 小数 (When) factorial(3.5) を呼び出す (Then) エラーがスローされる

## Constraints

- Tech stack: TypeScript, Vitest
- Existing behaviors: 既存の calculator 関数に影響を与えない
- Performance / Security: 特になし

## Definition of Done

- [ ] ユニットテスト追加（上記 Acceptance Criteria をカバー）
- [ ] 既存テスト含め全テストGreen
- [ ] lint/typecheck が Green
- [ ] 変更点とテスト結果を docs/ に記録
- [ ] Harness（harness/PROGRESS.md, FEATURES.json）が最新
