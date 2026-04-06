---
description: Create a pull request from the current branch with structured description
allowed-tools: Read, Glob, Grep, Bash
---

Create a pull request for the current branch.

## Instructions

1. Get current branch and changed files:
   ```bash
   BRANCH=$(git branch --show-current)
   git diff main --name-only
   git log main..HEAD --oneline
   ```

2. Build a PR description with this structure:
   - **Summary**: What this PR does (1-2 sentences)
   - **Spec Changes**: Any OpenAPI/AsyncAPI changes
   - **Database Changes**: Any new migrations
   - **Testing**: What tests were added/updated
   - **Checklist**: lint ✅, typecheck ✅, tests ✅, spec validation ✅

3. Create the PR:
   ```bash
   gh pr create --title "<type>: <description>" --body "<structured body>"
   ```

Use conventional commit types: feat, fix, refactor, docs, chore, test.
