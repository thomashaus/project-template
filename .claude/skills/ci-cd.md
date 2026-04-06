# CI/CD Automation

Automate pull request creation and validation with comprehensive checks.

## What This Does

Creates pull requests with:
- Structured description from commits
- Automated spec conformance validation
- Full test suite execution
- Security scans (gitleaks)
- Code quality checks (lint, typecheck)
- Multi-agent code review from `/workflows:review`

## Usage

Invoke when ready to create a PR from current branch:
```bash
/pr
```

## Pre-PR Checklist

Before creating a PR, ensure:
- [ ] All tests pass: `npm run test`
- [ ] Linting clean: `npm run lint`
- [ ] Type checking passes: `npm run typecheck`
- [ ] Security scan clean: `gitleaks detect --no-banner`
- [ ] Specs validated: `npm run spec:validate`
- [ ] Code reviewed: `/workflows:review` (for significant changes)
- [ ] Documentation updated (if needed)

## Automated PR Description

Generated PR includes:
- **Summary**: What changed (from commits)
- **Type**: feat / fix / refactor / docs / test
- **References**: Links to plan docs (if applicable)
- **Test plan**: Checklist of testing performed
- **Review checklist**: Spec conformance, security, performance, etc.
- **Co-authored-by**: Tom Haus + Claude Code attribution

## Branch Protection Rules

Main branch is protected:
- **No direct edits**: Must use feature branches
- **PR required**: All changes via pull request
- **Checks required**: Tests, lint, security scan must pass
- **Review required**: At least one approval (for significant changes)

## Pre-Push Validation

Git pre-push hook automatically runs before pushing:
```bash
scripts/pre-push-check.sh
```

This checks:
- Gitleaks security scan (blocking)
- TypeScript type checking (blocking for api-gateway)
- Linting (non-blocking advisory)
- Tests (non-blocking advisory)

If checks fail, push is aborted. Fix issues and try again.

## Manual Pre-Push Check

To run manually before pushing:
```bash
bash scripts/pre-push-check.sh
```

## CI/CD Pipeline

When PR is created, automated pipeline runs:

### 1. Validation Stage (All Projects)
```yaml
- Security scan (gitleaks)
- Linting
- Type checking (TypeScript projects)
- Test suite
```

### 2. Review Stage (Significant Changes)
```yaml
- Multi-agent code review (/workflows:review)
- Spec conformance check (for API changes)
- Performance review (for database queries)
- Security review (for auth/data handling)
```

### 3. Deploy Stage (After Merge)
```yaml
- Build containers
- Run integration tests
- Deploy to staging
- Smoke tests
- Promote to production (if all pass)
```

## Commit Standards

All commits follow conventional commits format:

```
<type>: <description>

[optional body]

Refs: docs/plans/xyz.md
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **docs**: Documentation only changes
- **test**: Adding or updating tests
- **chore**: Maintenance tasks
- **perf**: Performance improvement
- **security**: Security vulnerability fix

### Examples

```
feat: add claims processing endpoint

Implement POST /api/v1/claims with validation and persistence.

Refs: docs/plans/claims-processing.md
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

```
fix: resolve race condition in member sync

Fix race condition where concurrent sync requests could create duplicate member records.

Refs: docs/solutions/race-condition-fix.md
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

## References

- CLAUDE.md: Commit standards and branch protection
- `.gitleaks/config.toml`: Secret detection patterns
- `.claude/hooks/pre-tool-use.mjs`: Automated credential blocking
- `.git/hooks/pre-push`: Pre-push validation
- `scripts/pre-push-check.sh`: Pre-push check script
