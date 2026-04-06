---
status: pending
priority: p1
issue_id: "001"
tags: [code-review, security, simplicity]
dependencies: []
---

# Redundant Branch Protection Hook

## Problem Statement
The `no-commit-to-branch` pre-commit hook (line 29-30) duplicates GitHub branch protection rules, enforcing the same constraint twice with no added value.

## Findings
- **File**: `.pre-commit-config.yaml:29-30`
- **Issue**: Hook blocks commits to `main` branch
- **Evidence**: CLAUDE.md already states "No direct edits: Must use feature branches" enforced by GitHub branch protection
- **Impact**: Pure redundancy, adds no security value, violates YAGNI principle

## Proposed Solutions

### Option A: Remove the Hook
- **Effort**: Small (2 minutes)
- **Risk**: Low
- **Pros**: Removes redundancy, simpler config, relies on GitHub enforcement
- **Cons**: None — GitHub branch protection is the authoritative enforcement mechanism

### Option B: Document Why Both Exist
- **Effort**: Small (5 minutes)
- **Risk**: Low
- **Pros**: Maintains defense-in-depth
- **Cons**: Doesn't fix the redundancy issue

## Recommended Action
Remove the hook entirely. GitHub branch protection is the enforcement mechanism for this rule.

## Acceptance Criteria
- [ ] Remove `no-commit-to-branch` hook from `.pre-commit-config.yaml`
- [ ] Verify pre-commit still runs remaining hooks
- [ ] Update documentation if needed

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Code simplicity finding - redundant enforcement |
