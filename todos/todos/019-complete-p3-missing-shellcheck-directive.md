---
status: pending
priority: p3
issue_id: "019"
tags: [code-review, tooling]
dependencies: []
---

# Missing Shellcheck Directive

## Problem Statement
No `# shellcheck disable` directives for known false positives, making it harder to distinguish real issues from intentional patterns.

## Findings
- **File**: `scripts/setup-project.sh:1`
- **Issue**: No shellcheck directives
- **Impact**: Harder to run shellcheck effectively
- **Tooling**: Missing best practice for shell scripts

## Proposed Solutions

### Option A: Add Shellcheck Directives
- **Effort**: Small
- **Risk**: Low
- **Pros**: Clearer intent, easier to automate
- **Cons**: Need to identify false positives first

### Option B: Run Shellcheck in CI
- **Effort**: Small
- **Risk**: Low
- **Pros**: Automated quality gate
- **Cons**: Need to configure exceptions

## Recommended Action
Implement both: Add shellcheck directives for known patterns, add shellcheck to CI for automated validation.

## Acceptance Criteria
- [ ] Add shellcheck directives to setup-project.sh
- [ ] Add shellcheck step to CI workflow
- [ ] Configure appropriate exceptions
- [ ] CI validates shell script quality

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Tooling improvement |
