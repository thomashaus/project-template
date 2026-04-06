---
status: pending
priority: p2
issue_id: "015"
tags: [code-review, simplicity]
dependencies: []
---

# Unnecessary Abstractions for Single-Use Script

## Problem Statement
`safe_copy()` function wraps a 3-line operation used 7 times. The function call overhead exceeds the logic it encapsulates.

## Findings
- **File**: `scripts/setup-project.sh:35-45`
- **Issue**: Function for trivial operation
- **Impact**: Unnecessary indirection, harder to read
- **YAGNI Violation**: Abstraction without enough duplication

## Proposed Solutions

### Option A: Inline the Logic
- **Effort**: Small
- **Risk**: Low
- **Pros**: Clearer intent, easier to understand
- **Cons**: Slightly more verbose

### Option B: Keep Function
- **Effort**: Small
- **Risk**: Low
- **Pros**: Maintains DRY principle
- **Cons**: Function overhead exceeds benefit

## Recommended Action
Implement Option A: Inline the `if [ -f "$dest" ]; then ... fi` logic. Simpler and more direct.

## Acceptance Criteria
- [ ] Remove safe_copy function
- [ ] Inline the copy logic at each call site
- [ ] Script still works correctly
- [ ] Easier to understand flow

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Simplicity improvement |
