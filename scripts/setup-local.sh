#!/bin/bash
# setup-local.sh - Create _local/ directory for personal development
# Run this after cloning the repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Setting up _local/ directory..."

mkdir -p "${PROJECT_ROOT}/_local/stacks"
mkdir -p "${PROJECT_ROOT}/_local/experiments"

cat > "${PROJECT_ROOT}/_local/README.md" << 'EOF'
# _local/ - Personal Development Space

This directory is for **your personal use only** and is excluded from distribution.

## Structure

```
_local/
├── stacks/        # Various tech stack test environments
│   ├── python-fastapi/
│   ├── nextjs-app/
│   └── ...
└── experiments/   # Experimental features, prototypes
```

## Usage

- Add any test projects under `stacks/`
- Try experimental Claude Code configurations in `experiments/`
- This folder is in `.gitignore` - changes here won't affect the distributed template

## Creating a New Stack

```bash
cd _local/stacks
mkdir my-new-stack && cd my-new-stack
# Initialize your project (npm init, poetry init, cargo init, etc.)
```
EOF

echo "Done! _local/ directory created at ${PROJECT_ROOT}/_local/"
echo ""
echo "You can now add your test stacks:"
echo "  cd _local/stacks && mkdir my-project"
