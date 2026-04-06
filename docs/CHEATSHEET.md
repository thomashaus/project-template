# Cheat Sheet

Quick reference for the compound engineering workflow.

**Note:** This is a project template. Commands that validate code (lint, typecheck, tests) assume services have been implemented. Use this cheatsheet after bootstrapping your project.

## The Loop

```
/workflows:brainstorm  →  /workflows:plan  →  /workflows:work  →  /workflows:review  →  /workflows:compound
```

## Branch Naming

```
feat/add-user-auth
fix/login-timeout
hotfix/critical-payment-bug
refactor/extract-claims-middleware
```

## Commit Messages

```
feat: add claims processing endpoint
fix: resolve race condition in member sync
docs: update API spec for enrollment
refactor: extract auth middleware
test: add regression test for #57
chore: upgrade dependencies
perf: add index for claims lookup query
security: rotate exposed API key
```

## Before Every PR

**After implementing services**, run these checks:

```bash
npm run lint
npm run typecheck
npm test
npm run spec:validate
cd services/worker-service && uv run ruff check . && uv run pytest
gitleaks detect --no-banner
```

Or just run: `/workflows:review` (automates all of the above)

## Hotfix Flow

```bash
git checkout main && git pull
git checkout -b hotfix/description
# fix + regression test + commit
git push && gh pr create --base main
```

## Key Files

```
CLAUDE.md                                    # Project brain — every agent reads this
docs/solutions/patterns/critical-patterns.md # Required Reading — checked every cycle
docs/plans/                                  # Implementation plans
docs/solutions/[category]/                   # Accumulated knowledge
todos/                                       # Review findings with priority
specs/openapi/                               # REST API contracts
specs/asyncapi/                              # Event contracts
```

## Agent Quick Reference

```
/workflows:brainstorm <idea>         # Explore what to build
/workflows:plan <feature>            # Research + plan (40% of effort)
/workflows:work <plan-file>          # Execute plan (20% of effort)
/workflows:review                    # Multi-agent review (40% of effort)
/workflows:compound                  # Capture learnings (never skip)
/workflows:spec                      # Define/update API contracts
/cto:architecture-review             # Strategic architecture evaluation
/cto:tech-debt-assessment            # Prioritize technical debt
/cto:team-planning                   # Capacity and org planning
/pr                                  # Create PR with validation
```

## Solution Doc Categories

```
api-issues          database-issues      security-issues
build-errors        integration-issues   test-failures
runtime-errors      logic-errors         performance-issues
developer-experience  workflow-issues    best-practices
documentation-gaps  patterns/ (Required Reading)
```
