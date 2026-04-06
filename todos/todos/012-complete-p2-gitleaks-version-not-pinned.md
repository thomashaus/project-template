---
status: pending
priority: p2
issue_id: "012"
tags: [code-review, security]
dependencies: []
---

# Gitleaks Action Version Not Pinned

## Problem Statement
Using `@v2` is a moving target. Breaking changes or compromised versions could be introduced automatically.

## Findings
- **File**: `.github/workflows/ci.yml:29`
- **Issue**: `gitleaks-action@v2` not pinned to specific version
- **Risk**: Breaking changes or compromised versions
- **Security**: Supply chain vulnerability

## Proposed Solutions

### Option A: Pin to Specific Version
- **Effort**: Small
- **Risk**: Low
- **Pros**: Predictable behavior, explicit dependency
- **Cons**: Manual updates needed

### Option B: Pin to Commit SHA
- **Effort**: Small
- **Risk**: Low
- **Pros**: Most secure, immutable reference
- **Cons**: Harder to understand what version

## Recommended Action
Implement Option A: Pin to specific version like `@v2.1.0`. This balances security with maintainability.

## Acceptance Criteria
- [ ] Update gitleaks action to specific version
- [ ] Document version in comments
- [ ] CI still passes with pinned version

## Work Log
| Date | Action | Learnings |
|------|--------|-----------|
| 2026-04-05 | Created from review | Supply chain security |
