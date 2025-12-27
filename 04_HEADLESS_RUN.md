# 04_HEADLESS_RUN — claude -p で一気通貫（任意）

要件が `spec/REQ.md` にある前提で、headless 実行例です。

```bash
claude -p   --system-prompt-file prompts/e2e-system.txt   --allowedTools "Read,Edit,Bash,Glob,Grep,Skill"   --output-format json   "Complete E2E delivery for @spec/REQ.md using harness-manager -> req-analyst -> implementer -> code-reviewer -> implementer fixes -> test-runner -> final review. Do not finish until full tests are green and harness/docs are updated."
```
