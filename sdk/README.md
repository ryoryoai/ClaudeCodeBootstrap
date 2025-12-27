# Agent SDK Examples

This directory contains examples for using the Claude Agent SDK programmatically.

## Prerequisites

1. Install Claude Code CLI:

   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

2. Set your API key:
   ```bash
   export ANTHROPIC_API_KEY=your-api-key
   ```

## Python SDK

### Setup

```bash
cd sdk/python
pip install -r requirements.txt
```

### Examples

**Simple Agent** - Explore the codebase:

```bash
python simple_agent.py
```

**E2E Delivery Agent** - Full workflow orchestration:

```bash
python e2e_agent.py
```

## TypeScript SDK

### Setup

```bash
cd sdk/typescript
npm install
```

### Examples

**Simple Agent** - Explore the codebase:

```bash
npm run simple
```

**E2E Delivery Agent** - Full workflow orchestration:

```bash
npm start
```

## Features Used

| Feature         | Description                                           |
| --------------- | ----------------------------------------------------- |
| **Subagents**   | Defined in code, mirrors `.claude/agents/*.md`        |
| **Hooks**       | `PostToolUse` for logging tool usage                  |
| **Sessions**    | Capture session ID for resumption                     |
| **Settings**    | `settingSources: ["project"]` loads CLAUDE.md, skills |
| **Permissions** | `acceptEdits` for auto-approve file changes           |

## Differences from CLI

| Aspect            | CLI                  | SDK                  |
| ----------------- | -------------------- | -------------------- |
| **Interface**     | Interactive terminal | Programmatic API     |
| **Automation**    | Manual commands      | CI/CD integration    |
| **Customization** | Config files         | Code-level control   |
| **Use case**      | Development          | Production pipelines |

## Session Management

The SDK supports session persistence:

```python
# Start a session
session_id = await run_e2e_agent("Implement feature X")

# Resume later
await run_e2e_agent("Continue from where we left off", session_id)
```

This is the programmatic equivalent of `harness/PROGRESS.md` for CLI usage.

## MCP Servers

The project includes MCP server configurations in `.claude/settings.json`:

- **playwright**: Browser automation
- **github**: GitHub API integration
- **filesystem**: Extended file operations

To use in SDK:

```python
options = ClaudeAgentOptions(
    mcp_servers={
        "playwright": {"command": "npx", "args": ["@playwright/mcp@latest"]}
    }
)
```
