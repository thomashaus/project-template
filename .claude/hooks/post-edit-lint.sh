#!/usr/bin/env bash
# Post-edit hook: Run linters on the edited file
# Receives JSON on stdin with tool_input.file_path

set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

MESSAGES=""

# TypeScript/JavaScript files
if [[ "$FILE_PATH" == *.ts || "$FILE_PATH" == *.tsx || "$FILE_PATH" == *.js || "$FILE_PATH" == *.jsx ]]; then
  if command -v npx &>/dev/null && [ -f "package.json" ]; then
    LINT_OUTPUT=$(npx eslint --fix "$FILE_PATH" 2>&1) || true
    if [ -n "$LINT_OUTPUT" ]; then
      MESSAGES="ESLint: $LINT_OUTPUT"
    fi
    # Also run prettier
    npx prettier --write "$FILE_PATH" 2>/dev/null || true
  fi
fi

# Python files
if [[ "$FILE_PATH" == *.py ]]; then
  if command -v uv &>/dev/null; then
    RUFF_OUTPUT=$(cd services/worker-service 2>/dev/null && uv run ruff check --fix "$FILE_PATH" 2>&1) || true
    if [ -n "$RUFF_OUTPUT" ]; then
      MESSAGES="Ruff: $RUFF_OUTPUT"
    fi
    # Also format
    (cd services/worker-service 2>/dev/null && uv run ruff format "$FILE_PATH" 2>/dev/null) || true
  fi
fi

# YAML files (specs)
if [[ "$FILE_PATH" == *.yaml || "$FILE_PATH" == *.yml ]]; then
  if [[ "$FILE_PATH" == specs/openapi/* ]]; then
    VALIDATE=$(npx @redocly/cli lint "$FILE_PATH" 2>&1) || true
    if echo "$VALIDATE" | grep -q "error"; then
      MESSAGES="OpenAPI validation errors found. Run: npx @redocly/cli lint $FILE_PATH"
    fi
  fi
  if [[ "$FILE_PATH" == specs/asyncapi/* ]]; then
    VALIDATE=$(npx @asyncapi/cli validate "$FILE_PATH" 2>&1) || true
    if echo "$VALIDATE" | grep -q "error"; then
      MESSAGES="AsyncAPI validation errors found. Run: npx @asyncapi/cli validate $FILE_PATH"
    fi
  fi
fi

# Output additional context if there were issues
if [ -n "$MESSAGES" ]; then
  echo "{\"additionalContext\": \"Lint results for $FILE_PATH: $MESSAGES\"}"
fi
