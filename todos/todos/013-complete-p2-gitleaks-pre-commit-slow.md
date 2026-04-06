---
status: pending
priority: p2
issue_id: "013"
tags: [code-review, performance]
dependencies: []
---

# Gitleaks Pre-Commit Hook Runs Full History Scan

## Problem Statement
Every commit triggers full git history scan. Becomes prohibitively slow as repo grows (>5 seconds per commit).

## Findings
- **File**: `.pre-commit-config.yaml:14-17`
- **Issue**: Gitleaks hook scans full history on every commit
- **Impact**: 5+ seconds per commit, gets worse over time
- **Developer Experience**: Discourages frequent commits

## Proposed Solutions

### Option A: Use --no-git Flag
- **Effort**: Small
- **Risk**: Medium
- **Pros**: Only scans staged files, much faster
- **Cons**: Misses secrets in git history (acceptable for pre-commit)

### Option B: Remove from Pre-Commit Entirely
- **Effort**: Small
- **Risk**: Low
- **Pros**: Faster local development, CI still catches secrets
- **Cons**: Slower feedback loop for secrets

### Option C: Make Optional
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Developer choice, opt-in for security
- **Cons**: Inconsistent security coverage

## Recommended Action
Implement Option A: Use `--no-git` flag for scanning only staged files. Keep full history scan in CI where speed matters less.

## Acceptance Criteria
- [ ] Add `--no-git` flag to gitleaks pre-commit hook
- [ ] Commit time reduced to <2 seconds
- [ ] CI still does full history scan
- [ ] Documentation updated on local vs CI scanning

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Performance optimization |
