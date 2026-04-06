---
status: pending
priority: p3
issue_id: "023"
tags: [code-review, developer-experience]
dependencies: []
---

# Setup Script Doesn't Auto-Install Pre-Commit Hooks

## Problem Statement
Setup script reminds you to install pre-commit hooks but doesn't do it automatically. New developers often skip this step.

## Findings
- **File**: `scripts/setup-project.sh:101-105`
- **Issue**: Manual pre-commit install required
- **Impact**: Developers forget, lose fast feedback loop
- **Onboarding**: Friction for new team members

## Proposed Solutions

### Option A: Auto-Install If Git Repo
- **Effort**: Small
- **Risk**: Low
- **Pros**: Automatic, can't forget
- **Cons**: Less control for developers

### Option B: Make Opt-Out with Flag
- **Effort**: Medium
- **Risk**: Low
- **Pros**: Automatic by default, explicit opt-out
- **Cons**: More complex interface

### Option C: Keep as Is
- **Effort**: Small
- **Risk**: Low
- **Pros**: Developer control
- **Cons**: Onboarding friction remains

## Recommended Action
Implement Option A: Auto-run `pre-commit install` if `.git` directory exists. Make it opt-out with `--no-hooks` flag rather than opt-in.

## Acceptance Criteria
- [ ] Auto-install pre-commit hooks if git repo exists
- [ ] Add `--no-hooks` flag to skip
- [ ] Clear messaging about what's happening
- [ ] New developers get hooks automatically

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Onboarding improvement |
