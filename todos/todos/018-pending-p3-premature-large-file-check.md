---
status: pending
priority: p3
issue_id: "018"
tags: [code-review, simplicity]
dependencies: []
---

# Premature Large File Check

## Problem Statement
500KB limit is arbitrary enforcement. Do you actually have a problem with large files?

## Findings
- **File**: `.pre-commit-config.yaml:31-32`
- **Issue**: Guarding against problem that may not exist
- **YAGNI Violation**: Check exists because someone *might* commit something big
- **Impact**: False positives, enforcement without clear need

## Proposed Solutions

### Option A: Remove Entirely
- **Effort**: Small
- **Risk**: Low
- **Pros**: YAGNI — remove until problem exists
- **Cons**: Lose guard if problem emerges

### Option B: Keep with Documentation
- **Effort**: Small
- **Risk**: Low
- **Pros**: Maintains protection
- **Cons**: Still arbitrary enforcement

## Recommended Action
Implement Option A: Remove it until you actually hit the problem. YAGNI principle.

## Acceptance Criteria
- [ ] Remove check-added-large-files hook
- [ ] Monitor for large file issues in practice
- [ ] Add back if problem emerges

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | YAGNI violation |
