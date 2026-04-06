---
status: pending
priority: p2
issue_id: "007"
tags: [code-review, security]
dependencies: []
---

# Command Injection Risk in find Loop

## Problem Statement
The `find` command without null delimiter can break on files with newlines in names, potentially causing unexpected behavior.

## Findings
- **File**: `scripts/setup-project.sh:51-54`
- **Issue**: `find "$src_dir" -type f | while read -r src_file; do`
- **Risk**: Files with newlines in names cause path parsing issues
- **Impact**: Script breaks or behaves unexpectedly on edge cases

## Proposed Solutions

### Option A: Use Null Delimiter
- **Effort**: Small
- **Risk**: Low
- **Pros**: Handles all filenames safely
- **Cons**: Slightly more complex syntax

### Option B: Use Globbing Instead
- **Effort**: Small
- **Risk**: Low
- **Pros**: Simpler, works for most cases
- **Cons**: Doesn't handle nested directories as well

## Recommended Action
Implement Option A: Use `find -print0 | while read -r -d $'\0'` for null-terminated safety.

## Acceptance Criteria
- [ ] Replace find loop with null-delimited version
- [ ] Test with filenames containing spaces and newlines
- [ ] Script handles edge cases correctly

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Security hardening |
