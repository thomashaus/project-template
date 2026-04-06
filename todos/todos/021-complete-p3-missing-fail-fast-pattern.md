---
status: pending
priority: p3
issue_id: "021"
tags: [code-review, performance]
dependencies: []
---

# Missing Fast-Fail Pattern

## Problem Statement
All hooks run even if early hooks (like gitleaks) fail. Wastes time when critical gates fail.

## Findings
- **File**: `.pre-commit-config.yaml`
- **Issue**: No fail_fast for critical hooks
- **Impact**: All hooks run even after critical failures
- **Performance**: Unnecessary waiting when blocking issues found

## Proposed Solutions

### Option A: Add fail_fast to Critical Hooks
- **Effort**: Small
- **Risk**: Low
- **Pros**: Faster feedback on critical issues
- **Cons**: May miss secondary issues (acceptable)

### Option B: Add fail_fast Globally
- **Effort**: Small
- **Risk**: Low
- **Pros**: Stops on first failure
- **Cons**: May hide multiple issues

## Recommended Action
Implement Option A: Add `fail_fast: true` to gitleaks and detect-private-key hooks. Security checks should stop everything immediately.

## Acceptance Criteria
- [ ] Add fail_fast: true to gitleaks hook
- [ ] Add fail_fast: true to detect-private-key hook
- [ ] Other hooks continue to run
- [ ] Pre-commit fails faster on critical issues

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Performance optimization |
