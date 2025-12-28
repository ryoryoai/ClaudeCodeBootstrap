#!/usr/bin/env bash
# PreToolUse Hook: Block dangerous commands before execution
# This hook runs BEFORE a tool is executed

set -euo pipefail

# Input is passed via stdin as JSON
INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty')

# Extract command if Bash tool
if [[ "$TOOL_NAME" == "Bash" ]]; then
  COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // empty')

  # === DANGEROUS COMMAND PATTERNS ===
  DANGEROUS_PATTERNS=(
    # Destructive file operations
    "rm -rf /"
    "rm -rf /*"
    "rm -rf ~"
    "rm -rf \$HOME"
    "> /dev/sda"
    "mkfs\."
    "dd if=.* of=/dev"

    # Git dangerous operations
    "git push.*--force.*main"
    "git push.*--force.*master"
    "git push.*-f.*main"
    "git push.*-f.*master"
    "git reset --hard.*origin"
    "git clean -fdx"

    # System modification
    "chmod -R 777 /"
    "chown -R.*/"
    "sudo rm"
    "sudo dd"

    # Network exfiltration
    "curl.*\| ?bash"
    "wget.*\| ?bash"
    "curl.*\| ?sh"
    "wget.*\| ?sh"

    # Credential exposure
    "cat.*\.env"
    "cat.*/etc/passwd"
    "cat.*/etc/shadow"
    "echo.*API_KEY"
    "echo.*SECRET"
    "echo.*PASSWORD"

    # Process/system manipulation
    "kill -9 1"
    "killall"
    "shutdown"
    "reboot"
    "init 0"
    "init 6"
  )

  for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if echo "$COMMAND" | grep -qiE "$pattern"; then
      echo "[PreToolUse] BLOCKED: Dangerous command detected" >&2
      echo "[PreToolUse] Pattern: $pattern" >&2
      echo "[PreToolUse] Command: $COMMAND" >&2

      # Return JSON to block the tool
      echo '{"decision": "block", "reason": "Dangerous command blocked by security hook"}'
      exit 0
    fi
  done

  # === REQUIRE CONFIRMATION PATTERNS ===
  CONFIRM_PATTERNS=(
    "git push"
    "npm publish"
    "pip upload"
    "docker push"
    "rm -rf"
    "DROP TABLE"
    "DROP DATABASE"
    "TRUNCATE"
    "DELETE FROM.*WHERE 1"
  )

  for pattern in "${CONFIRM_PATTERNS[@]}"; do
    if echo "$COMMAND" | grep -qiE "$pattern"; then
      echo "[PreToolUse] WARNING: Command requires attention: $pattern" >&2
      # Log but allow (could change to require confirmation)
    fi
  done
fi

# === FILE WRITE PROTECTION ===
if [[ "$TOOL_NAME" == "Write" || "$TOOL_NAME" == "Edit" ]]; then
  FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty')

  # Protected paths
  PROTECTED_PATHS=(
    "^/etc/"
    "^/usr/"
    "^/bin/"
    "^/sbin/"
    "^/boot/"
    "^/sys/"
    "^/proc/"
    "\.env$"
    "\.env\.local$"
    "credentials"
    "secrets"
    "\.pem$"
    "\.key$"
    "id_rsa"
    "id_ed25519"
  )

  for pattern in "${PROTECTED_PATHS[@]}"; do
    if echo "$FILE_PATH" | grep -qiE "$pattern"; then
      echo "[PreToolUse] BLOCKED: Protected file path" >&2
      echo "[PreToolUse] Path: $FILE_PATH" >&2
      echo '{"decision": "block", "reason": "Protected file path blocked by security hook"}'
      exit 0
    fi
  done
fi

# Allow the tool to proceed
echo '{"decision": "allow"}'
exit 0
