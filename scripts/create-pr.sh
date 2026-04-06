#!/usr/bin/env bash
# Create a PR with a structured description
# Usage: ./scripts/create-pr.sh "feat: add user registration"

set -euo pipefail

BRANCH=$(git branch --show-current)
if [ "$BRANCH" = "main" ]; then
  echo "Error: Cannot create PR from main branch"
  exit 1
fi

TITLE="${1:-$(git log -1 --pretty=%s)}"

# Gather context
CHANGED_FILES=$(git diff main --name-only)
COMMIT_LOG=$(git log main..HEAD --oneline)
SPEC_CHANGES=$(echo "$CHANGED_FILES" | grep "^specs/" || echo "None")
DB_CHANGES=$(echo "$CHANGED_FILES" | grep "^db/migrations/" || echo "None")
TEST_CHANGES=$(echo "$CHANGED_FILES" | grep -E "test|spec" || echo "None")

# Run checks
LINT_STATUS="✅" && npm run lint --silent 2>/dev/null || LINT_STATUS="❌"
TYPE_STATUS="✅" && npm run typecheck --silent 2>/dev/null || TYPE_STATUS="❌"
TEST_STATUS="✅" && npm run test --silent 2>/dev/null || TEST_STATUS="❌"

BODY=$(cat <<EOF
## Summary

_Describe what this PR does_

## Changes

### Commits
${COMMIT_LOG}

### Spec Changes
${SPEC_CHANGES}

### Database Changes
${DB_CHANGES}

### Test Changes
${TEST_CHANGES}

## Checklist

- Lint: ${LINT_STATUS}
- Type Check: ${TYPE_STATUS}
- Tests: ${TEST_STATUS}
- [ ] Spec validation passing
- [ ] Documentation updated
- [ ] No breaking changes (or documented in description)
EOF
)

gh pr create \
  --title "$TITLE" \
  --body "$BODY" \
  --base main \
  --head "$BRANCH"
