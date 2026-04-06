---
status: pending
priority: p3
issue_id: "020"
tags: [code-review, performance]
dependencies: []
---

# No Build Artifact Caching

## Problem Statement
Gateway builds output on every run even if source hasn't changed. Wastes CI time.

## Findings
- **File**: `.github/workflows/ci.yml`
- **Issue**: No caching of dist/ directory
- **Impact**: Unnecessary rebuilds on every run
- **Performance**: Minor optimization but adds up

## Proposed Solutions

### Option A: Cache dist/ Directory
- **Effort**: Medium
- **Risk**: Medium
- **Pros**: Faster rebuilds, less wasted time
- **Cons**: Complex cache invalidation logic

### Option B: Skip for Now
- **Effort**: Small
- **Risk**: Low
- **Pros**: Simpler CI
- **Cons**: Slower builds

## Recommended Action
Implement Option B: Skip for now. Add only if build time becomes a bottleneck. YAGNI.

## Acceptance Criteria
- [ ] Monitor build times
- [ ] Add caching only if needed (>5 min builds)
- [ ] Keep CI simple until proven necessary

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | YAGNI optimization |
