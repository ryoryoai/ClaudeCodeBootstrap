#!/bin/bash
# dist.sh - Generate distribution ZIP (excludes _local/ and dev files)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DIST_NAME="ClaudeCodeOrch"
OUTPUT_DIR="${PROJECT_ROOT}/dist"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ZIP_FILE="${OUTPUT_DIR}/${DIST_NAME}_${TIMESTAMP}.zip"

# Files/directories to exclude from distribution
EXCLUDES=(
    "_local/*"
    "node_modules/*"
    "dist/*"
    ".git/*"
    "coverage/*"
    "*.log"
    ".env"
    ".env.*"
    ".DS_Store"
    "Thumbs.db"
)

echo "=== Creating distribution package ==="
echo "Source: ${PROJECT_ROOT}"
echo "Output: ${ZIP_FILE}"
echo ""

# Create output directory
mkdir -p "${OUTPUT_DIR}"

# Build exclude arguments for zip
EXCLUDE_ARGS=""
for pattern in "${EXCLUDES[@]}"; do
    EXCLUDE_ARGS="${EXCLUDE_ARGS} -x '${pattern}'"
done

# Create ZIP
cd "${PROJECT_ROOT}"
eval "zip -r '${ZIP_FILE}' . ${EXCLUDE_ARGS}"

# Show result
echo ""
echo "=== Distribution package created ==="
echo "File: ${ZIP_FILE}"
echo "Size: $(du -h "${ZIP_FILE}" | cut -f1)"
echo ""
echo "Contents:"
unzip -l "${ZIP_FILE}" | tail -n +4 | head -n -2 | awk '{print "  " $4}'

echo ""
echo "Done!"
