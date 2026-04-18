---
name: workflows:pr
description: Create a pull request after completing the compound step
allowed-tools: Read, Glob, Grep, Bash
---

# /workflows:pr

Create a pull request for the current branch. This is the final step in the compound
engineering workflow — run it after `/workflows:compound` has captured the learnings.

## Pre-PR Checklist

Verify all checks pass before creating the PR:

```bash
npm run test        # All tests green
npm run lint        # Lint clean
npm run typecheck   # TypeScript clean
npm run spec:validate  # Specs valid (if applicable)
gitleaks detect --no-banner  # No secrets
```

## Instructions

1. Get current branch and commit history:
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

   Include `Closes #<issue-number>` in the body to auto-close the GitHub issue on merge.

4. Share the PR URL.

Use conventional commit types: feat, fix, refactor, docs, chore, test.

## After PR

GitHub Actions will automatically:
- Transition issue label to `status:in-review`
- Run CI checks (tests, lint, security scan)
- Close the issue and prompt compound on merge
