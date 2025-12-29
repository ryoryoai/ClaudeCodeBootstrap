# create-ccb

Claude Code Bootstrap - Setup your Claude Code configuration.

## Usage

```bash
npx create-ccb
```

### Options

```bash
npx create-ccb --force    # Overwrite existing files
npx create-ccb --ver 1.0.0  # Install specific version
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
