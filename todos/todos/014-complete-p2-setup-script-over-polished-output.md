---
status: pending
priority: p2
issue_id: "014"
tags: [code-review, simplicity]
dependencies: []
---

# Over-Polished Output Formatting

## Problem Statement
Unicode box drawing adds maintenance burden and terminal compatibility risk for cosmetic benefit.

## Findings
- **File**: `scripts/setup-project.sh:28-32`
- **Issue**: Complex Unicode formatting for simple status messages
- **Impact**: Harder to maintain, potential terminal compatibility issues
- **YAGNI Violation**: Formatting doesn't earn its complexity

## Proposed Solutions

### Option A: Use Simple Echo Statements
- **Effort**: Small
- **Risk**: Low
- **Pros**: Simpler, more compatible, easier to maintain
- **Cons**: Less pretty (users don't care)

### Option B: Keep with Compatibility Check
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Maintains aesthetics
- **Cons**: Still more complex than needed

## Recommended Action
Implement Option A: Replace Unicode box with simple echo statements. Users care that it worked, not how pretty the box is.

## Acceptance Criteria
- [ ] Replace Unicode box with simple output
- [ ] Script works on all terminals
- [ ] Output still clear and readable

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Simplicity improvement |
