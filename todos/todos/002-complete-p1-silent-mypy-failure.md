---
status: pending
priority: p1
issue_id: "002"
tags: [code-review, security, types]
dependencies: []
---

# Silent Type Check Failure Swallows Errors

## Problem Statement
The mypy type check uses `|| true` (line 94) which silently ignores all failures, making type safety violations invisible in CI.

## Findings
- **File**: `.github/workflows/ci.yml:94`
- **Issue**: `uv run mypy . || true` silently ignores failures
- **Evidence**: No error output when mypy fails
- **Impact**: Type safety violations can reach production, causing runtime errors and potential security issues

## Proposed Solutions

### Option A: Remove || True and Make Blocking
- **Effort**: Small
- **Risk**: Medium (may fail CI if mypy config is unstable)
- **Pros**: Catches type errors, prevents runtime issues
- **Cons**: Requires stable mypy configuration

### Option B: Remove Entirely Until Stable
- **Effort**: Small
- **Risk**: Low
- **Pros**: Honest about current state, no false confidence
- **Cons**: Loses type safety feedback

### Option C: Make Advisory with Explicit Warning
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Visibility into issues without blocking
- **Cons**: More complex workflow

## Recommended Action
Either fix mypy configuration and make it blocking (Option A), or remove it entirely until ready (Option B). Current silent failure is worst of both worlds.

## Acceptance Criteria
- [ ] Either remove `|| true` and stabilize mypy, or remove mypy step entirely
- [ ] If keeping: all Python code passes mypy without errors
- [ ] CI job shows clear pass/fail for type checking

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Security and code simplicity finding |
