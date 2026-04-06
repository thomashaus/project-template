---
status: pending
priority: p2
issue_id: "017"
tags: [code-review, documentation]
dependencies: []
---

# Documentation Assumes Working Code That Doesn't Exist

## Problem Statement
CHEATSHEET.md shows manual validation commands (npm run spec:validate, Python lint/test) but this is a template with empty service directories.

## Findings
- **File**: `docs/CHEATSHEET.md:36-42`
- **Issue**: Shows commands for non-existent implementations
- **Impact**: Misleading documentation, false confidence
- **Context**: Template state vs. working project mismatch

## Proposed Solutions

### Option A: Add "After Implementation" Note
- **Effort**: Small
- **Risk**: Low
- **Pros**: Clear about when commands apply
- **Cons**: Slightly more verbose

### Option B: Split Into Two Sections
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Clearer separation of template vs. project
- **Cons**: More documentation to maintain

### Option C: Scaffold Minimal Services
- **Effort**: Large
- **Risk**: Medium
- **Pros**: Makes template immediately functional
- **Cons**: Outside scope of current review

## Recommended Action
Implement Option A: Add clear section header "After Implementing Services" to validation commands. Clarify this is a template first.

## Acceptance Criteria
- [ ] Add section header for implementation-dependent commands
- [ ] Clarify template state upfront
- [ ] Documentation accurate for current state

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Documentation clarity |
