---
status: pending
priority: p1
issue_id: "006"
tags: [code-review, architecture, ci-cd]
dependencies: []
---

# Pre-Commit Hooks Don't Mirror CI Blocking Rules

## Problem Statement
Pre-commit hooks run gitleaks (good) but don't enforce TypeScript type checking or spec validation — yet CI blocks on these. Developers get false confidence when pre-commit passes but CI fails.

## Findings
- **File**: `.pre-commit-config.yaml`
- **Missing**: TypeScript type checking, spec validation
- **Evidence**: CLAUDE.md line 189 says "TypeScript type checking (blocking for api-gateway)" but pre-commit doesn't check it
- **Impact**: Wasted CI minutes, developer friction, broken "fast feedback" promise

## Proposed Solutions

### Option A: Add TypeScript and Spec Hooks
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Fast feedback loop, prevents wasted CI runs
- **Cons**: Slower local commits (acceptable tradeoff)

### Option B: Make CI Checks Non-Blocking
- **Effort**: Small
- **Risk**: High
- **Pros**: Matches pre-commit behavior
- **Cons**: Loses quality gate, violates template principles

### Option C: Document the Mismatch
- **Effort**: Small
- **Risk**: Low
- **Pros**: Transparent about current state
- **Cons**: Doesn't fix the problem

## Recommended Action
Implement Option A: Add TypeScript type checking and spec validation to pre-commit. Use local hooks to match CI blocking rules.

## Acceptance Criteria
- [ ] Add npm run typecheck hook (when TypeScript files present)
- [ ] Add npm run spec:validate hook
- [ ] Hooks fail appropriately when violations found
- [ ] Pre-commit run time acceptable (<30 seconds)
- [ ] Documentation updated to reflect pre-commit coverage

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Architecture-critical misalignment |
