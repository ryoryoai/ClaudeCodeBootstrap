# claude-bootstrap-cli

CLI to install Claude Code Bootstrap configuration.

## Installation

```bash
npm install -g claude-bootstrap-cli
```

## Usage

```bash
# Initialize in current directory
claude-bootstrap init

# Force overwrite existing
claude-bootstrap init --force

# Install specific version
claude-bootstrap init --version 1.0.0

# Check for updates
claude-bootstrap update

# List available versions
claude-bootstrap versions
```

## What gets installed

```
.claude/
├── settings.json       # Claude Code settings
├── skills/             # Custom skills
├── agents/             # Custom agents
├── commands/           # Custom commands
└── hooks/              # Pre/post tool hooks
```

## After installation

1. Open the project in VS Code / Cursor
2. Start Claude Code
3. Use `/start-session` to begin

## License

MIT
