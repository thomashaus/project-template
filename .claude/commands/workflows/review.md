---
name: workflows:review
description: Perform comprehensive code reviews using multi-agent parallel analysis
argument-hint: "[branch name, PR number, or 'latest' for current branch]"
---

# Comprehensive Code Review

**This is 40% of the effort.** Review gates shipping — thorough review prevents compounding debt.

## Review Target

<review_target> $ARGUMENTS </review_target>

## Execution

### 1. Setup & Context

```bash
# Determine what to review
git branch --show-current
git diff main --name-only
git diff main --stat
git log main..HEAD --oneline
```

If a PR number was given:
```bash
gh pr view $PR_NUMBER --json title,body,files
gh pr checkout $PR_NUMBER
```

### 2. Run Automated Checks First

```bash
# Lint
npm run lint 2>&1 | tail -20
cd services/worker-service && uv run ruff check . 2>&1 | tail -20

# Type check
npm run typecheck 2>&1 | tail -20
cd services/worker-service && uv run mypy . 2>&1 | tail -20

# Tests
npm run test 2>&1 | tail -20
cd services/worker-service && uv run pytest 2>&1 | tail -20

# Spec validation
npm run spec:validate 2>&1 | tail -20
```

### 3. Parallel Multi-Agent Review

Run ALL applicable agents **in parallel**:

**Always run:**
- Task security-sentinel(changed files)
- Task performance-oracle(changed files)
- Task code-simplicity-reviewer(changed files)
- Task architecture-strategist(changed files)
- Task spec-conformance-reviewer(changed files)

**Conditional — run if applicable:**
- Task data-integrity-guardian(changed files) — if migrations or DB changes
- Task git-history-analyzer(changed files) — if significant refactors

### 4. Protected Artifacts

Never flag these for deletion or cleanup:
- `docs/plans/*.md` — living plan documents
- `docs/solutions/*.md` — compound knowledge base
- `docs/brainstorms/*.md` — design exploration documents

### 5. Synthesize Findings

Collect all agent reports and:

1. **Categorize** by type: security, performance, architecture, quality, spec drift
2. **Assign severity**: 🔴 P1 Critical (blocks merge), 🟡 P2 Important, 🔵 P3 Nice-to-have
3. **Deduplicate**: Remove overlapping findings
4. **Estimate effort**: Small / Medium / Large per finding

### 6. Create Todo Files

Use the `file-todos` skill to create structured todo files for ALL findings.

For each finding:
```bash
mkdir -p todos
# Create: todos/{id}-pending-{priority}-{description}.md
```

Use the template from `.claude/skills/file-todos/assets/todo-template.md`.

For large reviews (15+ findings), create todos in parallel.

### 7. Summary Report

```markdown
## ✅ Code Review Complete

**Target:** [branch or PR]
**Files Changed:** [count]

### Automated Results
- Lint: pass/fail
- Types: pass/fail
- Tests: X passing, Y failing
- Spec validation: pass/fail

### Findings Summary
- **Total:** [X]
- **🔴 P1 Critical:** [count] — BLOCKS MERGE
- **🟡 P2 Important:** [count] — Should fix
- **🔵 P3 Nice-to-have:** [count] — Enhancements

### P1 Findings (Must Fix)
1. [finding] — [file:line] — [why critical]

### P2 Findings
1. [finding] — [file:line] — [recommendation]

### P3 Findings
1. [finding] — [file:line] — [suggestion]

### Agents Used
[List of review agents that ran]

### Next Steps
1. Fix P1 findings before merge
2. Address P2 findings (recommended)
3. Consider P3 findings for follow-up work
4. Run `/workflows:compound` after fixes to capture learnings
```

### 8. Post-Review Options

1. **Fix P1 findings** → Address critical issues
2. **Run `/workflows:work`** → Implement all todo fixes
3. **Merge** → If no P1 findings, proceed to merge
4. **Run `/workflows:compound`** → Document any learnings from this review

## P1 Findings Block Merge

Any **🔴 P1 Critical** finding must be resolved before merging.
Present these prominently and track resolution.
