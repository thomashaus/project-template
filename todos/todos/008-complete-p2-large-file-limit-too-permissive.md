---
status: pending
priority: p2
issue_id: "008"
tags: [code-review, security]
dependencies: []
---

# Large File Check Too Permissive

## Problem Statement
500KB file size limit allows potentially large files containing secrets or binary data to slip through pre-commit hooks.

## Findings
- **File**: `.pre-commit-config.yaml:31-32`
- **Issue**: `--maxkb=500` allows 500KB files
- **Risk**: 400KB file with base64-encoded credentials could pass
- **Impact**: Security bypass for large secret files

## Proposed Solutions

### Option A: Reduce to 100KB
- **Effort**: Small
- **Risk**: Low
- **Pros**: Catches most problematic large files
- **Cons**: May flag some legitimate files (images, etc.)

### Option B: Reduce to 250KB
- **Effort**: Small
- **Risk**: Low
- **Pros**: Better balance, catches most issues
- **Cons**: Still allows some large files

### Option C: Remove Entirely
- **Effort**: Small
- **Risk**: Low
- **Pros**: YAGNI — don't guard against problems we don't have
- **Cons**: Loses protection if problem emerges later

## Recommended Action
Implement Option B: Reduce to 250KB as reasonable middle ground. Consider Option C if this proves to be a false positive problem.

## Acceptance Criteria
- [ ] Update maxkb to 250 in .pre-commit-config.yaml
- [ ] Document why this limit exists
- [ ] Monitor for false positives in practice

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Security tuning |
