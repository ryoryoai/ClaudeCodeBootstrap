# Implementation Plan

## Restated Goal

- calculator モジュールに factorial 関数を追加する

## Non-goals

- 他の数学関数の追加
- パフォーマンス最適化（メモ化等）

## Acceptance Criteria

- [x] factorial(5) = 120 (正の整数)
- [x] factorial(0) = 1 (ゼロ)
- [x] factorial(-1) → Error (負の整数)
- [x] factorial(3.5) → Error (小数)

## Task Breakdown (ordered)

1. src/calculator.ts に factorial 関数を追加
2. tests/calculator.test.ts に factorial のテストを追加
3. npm test で全テスト Green を確認
4. docs/IMPLEMENTATION_REPORT.md を更新
5. docs/TEST_REPORT.md を更新

## Test Plan

- Unit: Vitest で以下をテスト
  - 正の整数: factorial(1)=1, factorial(5)=120, factorial(10)=3628800
  - ゼロ: factorial(0)=1
  - 負の整数: factorial(-1) throws Error
  - 小数: factorial(3.5) throws Error

## Risks / Assumptions

- 大きな数(n>170)ではオーバーフローするが、今回は対象外とする
