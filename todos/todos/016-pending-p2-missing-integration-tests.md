---
status: pending
priority: p2
issue_id: "016"
tags: [code-review, architecture, testing]
dependencies: []
---

# CI Lacks Integration Testing Between Services

## Problem Statement
CI tests gateway and worker in isolation but never validates they work together. No integration test validates gateway can call worker endpoints.

## Findings
- **File**: `.github/workflows/ci.yml:36-97`
- **Issue**: Only unit tests, no integration tests
- **Impact**: Unit tests pass but integration fails
- **Architecture**: False confidence that system works

## Proposed Solutions

### Option A: Add Integration Job
- **Effort**: Medium
- **Risk**: Medium
- **Pros**: Validates end-to-end flow, catches contract issues
- **Cons**: More complex CI, longer runtime

### Option B: Add to Existing Jobs
- **Effort**: Medium
- **Risk**: Medium
- **Pros**: Simpler CI structure
- **Cons**: Blurs unit/integration boundaries

### Option C: Document Decision
- **Effort**: Small
- **Risk**: Low
- **Pros**: Transparent about current limitation
- **Cons**: Doesn't solve the problem

## Recommended Action
Implement Option A: Add integration job that starts Docker Compose, runs smoke test against gateway, validates end-to-end flow. This validates the architecture's core promise.

## Acceptance Criteria
- [ ] Add integration job to ci.yml
- [ ] Job starts Docker Compose services
- [ ] Runs smoke test against gateway
- [ ] Validates gateway→worker communication
- [ ] Fails if integration broken

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Architecture gap |
