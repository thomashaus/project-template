---
name: workflows:work
description: Execute work plans efficiently while maintaining quality and finishing features
argument-hint: "[plan file path or specification]"
---

# Work Plan Execution

**This is 20% of the effort.** If the plan is thorough, execution should be straightforward.

## Input Document

<input_document> $ARGUMENTS </input_document>

## Execution Workflow

### Phase 1: Quick Start

#### 1. Read Plan and Clarify

- Read the work document completely
- Review any referenced files, specs, or learnings
- If anything is unclear or ambiguous, ask now
- Get user approval to proceed
- **Do not skip** — better to ask now than build wrong

#### 2. Setup Environment

Check current branch:
```bash
current_branch=$(git branch --show-current)
default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
if [ -z "$default_branch" ]; then
  default_branch=$(git rev-parse --verify origin/main >/dev/null 2>&1 && echo "main" || echo "master")
fi
```

**If on feature branch:** "Continue on `[branch]`, or create new?"
**If on default branch:** Create feature branch:
```bash
git pull origin $default_branch
git checkout -b feat/descriptive-name
```

For parallel work, consider using the `git-worktree` skill.

#### 3. Create Task List

Break plan into actionable tasks:
- Include dependencies between tasks
- Prioritize by implementation order (DB → service → gateway → tests)
- Include testing and validation tasks
- Keep tasks specific and completable

### Phase 2: Execute

#### Task Execution Loop

```
while (tasks remain):
  - Read any referenced files from the plan
  - Look for similar patterns in codebase
  - Implement following existing conventions
  - Write tests alongside code
  - Run validation after changes
  - Mark task as completed
  - Check off corresponding item in plan file ([ ] → [x])
  - Evaluate for incremental commit
```

**IMPORTANT**: Update the plan document by checking off completed items.
The plan is a living document showing progress.

#### Incremental Commits

| Commit when... | Don't commit when... |
|----------------|---------------------|
| Logical unit complete (migration, route, service) | Small part of a larger unit |
| Tests pass + meaningful progress | Tests failing |
| About to switch contexts (backend → frontend) | Purely scaffolding |
| About to attempt risky changes | Would need "WIP" message |

**Heuristic:** "Can I write a commit message describing a complete, valuable
change? If yes, commit. If the message would be 'WIP', wait."

```bash
# 1. Verify tests pass
npm run test && cd services/worker-service && uv run pytest

# 2. Stage related files only (not git add .)
git add <files for this logical unit>

# 3. Commit with conventional message
git commit -m "feat(scope): description of this unit"
```

#### Follow Existing Patterns

- Plan references similar code — read those files first
- Match naming conventions exactly
- Reuse existing components
- Follow CLAUDE.md standards
- When in doubt: `grep -r "similar_pattern" services/`

#### Test Continuously

- Run relevant tests after each significant change
- Don't wait until the end
- Fix failures immediately
- Add new tests for new functionality

#### Track Progress

- Keep task list updated
- Note blockers or unexpected discoveries
- Create new tasks if scope expands

### Phase 3: Quality Check

#### Run Core Checks

```bash
# Lint
npm run lint
cd services/worker-service && uv run ruff check . && uv run ruff format --check .

# Type check
npm run typecheck
cd services/worker-service && uv run mypy .

# Test
npm run test
cd services/worker-service && uv run pytest

# Spec validation
npm run spec:validate
```

#### Consider Review Agents (Complex Changes Only)

For large, risky, or security-sensitive changes, run in parallel:

- Task security-sentinel("Review changes for security")
- Task performance-oracle("Check for performance issues")
- Task code-simplicity-reviewer("Review for unnecessary complexity")

**Don't use by default.** Tests + lint + following patterns is usually sufficient.

#### Final Validation

- [ ] All tasks marked completed
- [ ] All plan checkboxes checked off
- [ ] Tests pass
- [ ] Lint passes
- [ ] Spec validation passes
- [ ] Code follows existing patterns

### Phase 4: Ship It

#### Create Final Commit

```bash
git add .
git status
git diff --staged

git commit -m "feat(scope): description of what and why

Brief explanation if needed.

Co-Authored-By: Claude <noreply@anthropic.com>"
```

#### Create Pull Request

```bash
git push -u origin $(git branch --show-current)

gh pr create --title "feat(scope): [Description]" --body "## Summary
- What was built
- Why it was needed

## Testing
- Tests added/modified
- Manual testing performed

## Plan
- docs/plans/[plan-file].md
"
```

#### Notify User
- Summarize what was completed
- Link to PR
- Note any follow-up work needed
- Suggest: "Run `/workflows:review` for comprehensive review before merge"

## Key Principles

- **Start fast**: Get clarification once, then execute
- **Plan is your guide**: Load references, follow patterns
- **Test as you go**: Not at the end
- **Ship complete features**: Don't leave things 80% done
- **Incremental commits**: Each commit is a complete, valuable unit
