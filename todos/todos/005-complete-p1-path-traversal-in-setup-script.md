---
status: pending
priority: p1
issue_id: "005"
tags: [code-review, security]
dependencies: []
---

# Path Traversal Vulnerability in Setup Script

## Problem Statement
User-provided path is used without validation: `TARGET_DIR="${1:-.}"` allowing potential path traversal attacks.

## Findings
- **File**: `scripts/setup-project.sh:15-16`
- **Issue**: No path validation on user input
- **Evidence**: Script accepts any path including `../../etc/`
- **Impact**: Attacker could attempt to copy template files to sensitive system locations

## Proposed Solutions

### Option A: Add Path Validation
- **Effort**: Small
- **Risk**: Low
- **Pros**: Prevents malicious paths, allows safe paths
- **Cons**: Requires defining safe directory criteria

### Option B: Require Empty Target Directory
- **Effort**: Small
- **Risk**: Low
- **Pros**: Prevents overwrites, clearer intent
- **Cons**: Less flexible for existing projects

### Option C: Resolve and Validate Absolute Path
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Handles symlinks correctly, most robust
- **Cons**: More complex validation logic

## Recommended Action
Implement Option A: Add validation to ensure target directory is within user's home directory or explicitly approved location, and resolves to absolute path without `..` components.

## Acceptance Criteria
- [ ] Add path validation function
- [ ] Reject paths with `..` components
- [ ] Reject paths outside safe directories (home, /tmp, /Users)
- [ ] Clear error message for invalid paths
- [ ] Tests for malicious path rejection

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Security critical finding |
