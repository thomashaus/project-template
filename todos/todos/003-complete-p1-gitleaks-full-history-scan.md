---
status: pending
priority: p1
issue_id: "003"
tags: [code-review, performance, security]
dependencies: []
---

# Gitleaks Full History Scan on Every CI Run

## Problem Statement
Secret scanning job uses `fetch-depth: 0` (line 28) scanning full git history on every run. As repository grows, this becomes extremely slow (5-10+ minutes on repos with >1000 commits).

## Findings
- **File**: `.github/workflows/ci.yml:28`
- **Issue**: Full history scan on every push and PR
- **Evidence**: `fetch-depth: 0` clones entire git history
- **Impact**: CI time increases linearly with repo age, becomes prohibitive

## Proposed Solutions

### Option A: Use Shallow Clone for PRs
- **Effort**: Medium
- **Risk**: Low
- **Pros**: 80% faster on PRs (only scan changed files)
- **Cons**: Misses secrets in old files (acceptable tradeoff)

### Option B: Run Only on Main Branch Pushes
- **Effort**: Small
- **Risk**: Medium
- **Pros**: Faster PR CI, main still protected
- **Cons**: Secrets in PRs not caught until merge

### Option C: Move to Scheduled Scans
- **Effort**: Medium
- **Risk**: Low
- **Pros**: No CI slowdown, comprehensive coverage
- **Cons**: Slower detection on new commits

## Recommended Action
Implement Option A: Use `fetch-depth: 1` for PRs, keep full depth only on main branch pushes. Combine with Option C for periodic full scans.

## Acceptance Criteria
- [ ] PR workflows use shallow clone (fetch-depth: 1)
- [ ] Main branch pushes use full history scan
- [ ] Scheduled workflow runs full weekly scan
- [ ] CI time reduced by 70%+ on PRs

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Performance critical issue |
