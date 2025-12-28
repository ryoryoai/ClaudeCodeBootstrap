#!/bin/bash
# setup-local.sh - Create _local/ directory for personal development
# Run this after cloning the repository
#
# Usage:
#   ./setup-local.sh          # Create both (claude + stacks)
#   ./setup-local.sh claude   # Claude Code skills/agents experiments only
#   ./setup-local.sh stacks   # Tech stack test environments only

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOCAL_DIR="${PROJECT_ROOT}/_local"

setup_claude() {
    echo "Setting up _local/claude/ (skills/agents experiments)..."
    mkdir -p "${LOCAL_DIR}/claude/agents"
    mkdir -p "${LOCAL_DIR}/claude/skills"
    mkdir -p "${LOCAL_DIR}/claude/commands"
    mkdir -p "${LOCAL_DIR}/claude/hooks"

    cat > "${LOCAL_DIR}/claude/README.md" << 'EOF'
# Claude Code Customization Space

Experiment with custom agents, skills, commands, and hooks here.

## Structure

```
claude/
├── agents/    # Custom agent definitions
├── skills/    # Custom skill definitions
├── commands/  # Custom slash commands
└── hooks/     # Custom hooks
```

## Usage

1. Create/modify configurations here
2. Copy to project's `.claude/` when ready
3. Test in `_local/stacks/` projects
EOF
    echo "  Created: _local/claude/"
}

setup_stacks() {
    echo "Setting up _local/stacks/ (tech stack test environments)..."
    mkdir -p "${LOCAL_DIR}/stacks"

    cat > "${LOCAL_DIR}/stacks/README.md" << 'EOF'
# Tech Stack Test Environments

Add various tech stack test projects here.

## Examples

```bash
# Python + FastAPI
mkdir python-fastapi && cd python-fastapi
poetry init

# Next.js
mkdir nextjs-app && cd nextjs-app
npx create-next-app@latest .

# Rust CLI
mkdir rust-cli && cd rust-cli
cargo init

# Go API
mkdir go-api && cd go-api
go mod init myapi
```
EOF
    echo "  Created: _local/stacks/"
}

show_usage() {
    echo "Usage: $0 [claude|stacks]"
    echo ""
    echo "  (no args)  Create both claude/ and stacks/"
    echo "  claude     Claude Code skills/agents experiments only"
    echo "  stacks     Tech stack test environments only"
}

# Main
case "${1:-all}" in
    claude)
        setup_claude
        ;;
    stacks)
        setup_stacks
        ;;
    all)
        setup_claude
        setup_stacks
        ;;
    -h|--help|help)
        show_usage
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        show_usage
        exit 1
        ;;
esac

echo ""
echo "Done! _local/ ready at ${LOCAL_DIR}/"
