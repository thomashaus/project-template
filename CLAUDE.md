# CLAUDE.md — Project Instructions for Claude Code

This file guides Claude Code (claude.ai/code) when working in this repository.

## Project Overview

_Brief description of what this project does and its architecture._

- **Frontend**: [React/Vue/etc] + [Vite/Webpack/etc] + [Tailwind/CSS/etc]
- **Backend**: [FastAPI/Express/etc] + [Postgres/Mongo/etc]
- **Deployment**: [Docker, App Platform, etc]

## Key Conventions

### Branch Naming
- `feature/description` — new features
- `bugfix/description` — bug fixes
- `hotfix/description` — production hotfixes
- `refactor/description` — code refactoring
- `chore/description` — maintenance tasks

### Commit Format
```
type(scope): subject

Types: feat, fix, refactor, perf, test, docs, chore, style, ci, build, revert

Examples:
  feat(auth): add OAuth login
  fix(api): handle null response
  docs(readme): update setup instructions
```

### File Structure
```
project/
├── src/           # Frontend source
├── backend/       # Backend source (if monorepo)
├── docs/          # Documentation
│   ├── specs/     # Feature specs
│   └── plans/     # Implementation plans
├── test/          # Test files
├── scripts/       # Utility scripts
└── deploy/        # Deployment configs
```

## Development Commands

```bash
# Development
npm run dev

# Build
npm run build

# Test
npm test

# Lint
npm run lint

# Format
npm run format
```

## Security Rules

1. **NEVER commit real credentials** to git
2. **Store secrets** in `.env` (gitignored) or secure vault
3. **Use** `.env.example` for documentation only
4. **Run** security checks before pushing

```bash
# Security scan
gitleaks detect --config .gitleaks.toml --no-banner
```

## Workflow

1. **Before starting**: Create issue → Create branch
2. **During work**: Follow conventions → Run tests → Document changes
3. **Before PR**: Self-review → Run all checks → Update docs
4. **After merge**: Close issues → Update changelog

## Documentation

- `docs/specs/` — Feature specifications (before coding)
- `docs/plans/` — Implementation plans (before coding)
- Update this file when conventions change

---

_Customize this file for your project's specific needs._
