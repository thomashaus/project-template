---
status: pending
priority: p2
issue_id: "010"
tags: [code-review, simplicity]
dependencies: []
---

# Over-Engineered Directory Copy Function

## Problem Statement
`safe_copy_dir()` wraps `find + while read` for what could be a simple `cp -r` with check. The function is only called once.

## Findings
- **File**: `scripts/setup-project.sh:47-56`
- **Issue**: Complex function for single-use operation
- **Impact**: Unnecessary abstraction, harder to maintain
- **YAGNI Violation**: Generic function for specific use case

## Proposed Solutions

### Option A: Use cp -rn Directly
- **Effort**: Small
- **Risk**: Low
- **Pros**: Simpler, standard Unix command
- **Cons**: Less explicit about what's happening

### Option B: Inline the Logic
- **Effort**: Small
- **Risk**: Low
- **Pros**: Clearer intent, easier to understand
- **Cons**: Slightly more verbose at call site

### Option C: Keep with Comment
- **Effort**: Small
- **Risk**: Low
- **Pros**: Maintains abstraction
- **Cons**: Still over-engineered for single use

## Recommended Action
Implement Option A: Use `cp -rn "$src_dir/"* "$dest_dir/"` (recursive, no-clobber). Simple and effective.

## Acceptance Criteria
- [ ] Replace safe_copy_dir with simple cp -rn
- [ ] Script still copies directories correctly
- [ ] Script simpler and easier to understand

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Simplicity improvement |
