# Implementation Report

## Summary

- calculator モジュールに `factorial` 関数を追加
- 全テスト Green (18 tests passed)
- 全品質ゲート PASSED (lint, typecheck, security, tests)

## Files Changed

- `src/calculator.ts` - factorial 関数を追加
- `tests/calculator.test.ts` - factorial のテストケース 5件を追加

## Notes

- Edge cases:
  - n = 0 → 1 を返す（数学的定義通り）
  - 負の整数 → Error をスロー
  - 小数 → Error をスロー
- Backward compatibility / migrations:
  - 既存関数に影響なし
  - 新規エクスポートのみ追加
- How to test:
  - `npm test` で全テスト実行
  - `npm run lint` で lint チェック
  - `npm run typecheck` で型チェック
