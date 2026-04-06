#!/usr/bin/env bash
# Stop hook: Check if documentation needs updating based on changes
# Fires when an agent finishes its response

set -euo pipefail

# Check if we're on a feature branch with changes
BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "unknown" ]; then
  exit 0
fi

# Get changed files vs main
CHANGED=$(git diff main --name-only 2>/dev/null || true)
if [ -z "$CHANGED" ]; then
  exit 0
fi

REMINDERS=""

# Check if spec files changed but docs weren't updated
if echo "$CHANGED" | grep -q "^specs/"; then
  if ! echo "$CHANGED" | grep -q "^docs/"; then
    REMINDERS="$REMINDERS\n- API specs changed but docs/ not updated. Consider updating API documentation."
  fi
fi

# Check if migrations were added but no corresponding spec
if echo "$CHANGED" | grep -q "^db/migrations/"; then
  if ! echo "$CHANGED" | grep -q "^specs/"; then
    REMINDERS="$REMINDERS\n- Database migrations added. Verify that API specs reflect schema changes."
  fi
fi

# Check if new routes added without tests
if echo "$CHANGED" | grep -q "services/api-gateway/src/routes/"; then
  if ! echo "$CHANGED" | grep -q "services/api-gateway/.*test"; then
    REMINDERS="$REMINDERS\n- New gateway routes added without corresponding tests."
  fi
fi

if echo "$CHANGED" | grep -q "services/worker-service/.*\.py$"; then
  if ! echo "$CHANGED" | grep -q "services/worker-service/tests/"; then
    REMINDERS="$REMINDERS\n- Python service files changed without corresponding tests."
  fi
fi

if [ -n "$REMINDERS" ]; then
  echo "{\"additionalContext\": \"Documentation & quality reminders:$REMINDERS\"}"
fi
