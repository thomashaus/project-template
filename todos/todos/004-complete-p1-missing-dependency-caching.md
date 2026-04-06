---
status: pending
priority: p1
issue_id: "004"
tags: [code-review, performance]
dependencies: []
---

# Missing Dependency Caching in CI Jobs

## Problem Statement
Both Gateway (Node.js) and Worker (Python) jobs reinstall all dependencies on every run, wasting 2-3 minutes per build.

## Findings
- **Files**: `.github/workflows/ci.yml:44-45, 78-82`
- **Gateway**: `cache: 'npm'` set but not effective (no cache key validation)
- **Worker**: `setup-uv` action without cache parameter
- **Impact**: 30-60 seconds wasted on npm, 1-3 minutes on uv per build

## Proposed Solutions

### Option A: Fix Gateway npm Cache
- **Effort**: Small
- **Risk**: Low
- **Pros**: Reduces Gateway job time by 50%
- **Cons**: None
- **Implementation**: Verify cache key includes `package-lock.json` hash

### Option B: Add UV Cache for Worker
- **Effort**: Small
- **Risk**: Low
- **Pros**: Reduces Worker job time by 70%
- **Cons**: None
- **Implementation**: Add `cache: 'uv'` parameter to setup-uv action

### Option C: Add Build Artifact Caching
- **Effort**: Medium
- **Risk**: Medium
- **Pros**: Even faster rebuilds
- **Cons**: More complex cache invalidation logic

## Recommended Action
Implement both Option A and Option B immediately. Add build artifact caching (Option C) as follow-up optimization.

## Acceptance Criteria
- [ ] Gateway job uses npm cache effectively
- [ ] Worker job uses uv cache
- [ ] Build time reduced by 2-3 minutes total
- [ ] Cache invalidation works correctly when dependencies change

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Performance critical - easy win |
