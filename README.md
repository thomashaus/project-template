# Project Template

A standardized template for new projects with Claude Code, GitHub workflows, and security best practices.

## What's Included

### 📁 Directory Structure
```
project-template/
├── .claude/              # Claude Code settings
│   └── settings.json     # Claude plugin configuration
├── .github/              # GitHub configuration
│   ├── workflows/        # GitHub Actions workflows
│   │   └── test.yml      # CI/CD pipeline
│   ├── ISSUE_TEMPLATE.md         # Feature request template
│   ├── ISSUE_TEMPLATE_BUG.md     # Bug report template
│   ├── ISSUE_TEMPLATE_DEBT.md    # Tech debt template
│   └── pull_request_template.md  # PR template
├── .hooks/               # Git hooks
│   ├── commit-msg        # Enforce conventional commits
│   ├── pre-commit        # Quality checks before commit
│   └── pre-push          # Full test suite before push
├── docs/                 # Documentation
│   ├── specs/            # Feature specifications
│   │   └── .spec-template.md
│   └── plans/            # Implementation plans
│       └── .plan-template.md
├── scripts/              # Utility scripts
│   ├── security-check.sh # Security validation
│   └── setup-hooks.sh    # Install git hooks
├── .gitignore            # Standard ignores
├── .gitleaks.toml        # Secret scanning config
└── CLAUDE.md             # Instructions for Claude Code
```

### 🤖 Claude Code Integration
- **CLAUDE.md**: Project-specific instructions for Claude Code
- **.claude/settings.json**: Enable Claude plugins (frontend-design, etc.)

### 🐙 GitHub Workflows
- **Issue Templates**: Feature requests, bug reports, tech debt
- **PR Template**: Structured pull request reviews
- **CI/CD Pipeline**: Lint, test, build, security scan

### 🪝 Git Hooks
- **commit-msg**: Enforces conventional commit format (`type(scope): subject`)
- **pre-commit**: Linting, TypeScript checks, secret detection
- **pre-push**: Full test suite, security scan, branch naming validation

### 🔒 Security
- **Gitleaks**: Automated secret scanning with custom rules
- **security-check.sh**: Manual security validation script
- **Secret patterns**: Common secret types detected

## Quick Start

### 1. Create New Project from Template
```bash
# Clone template
git clone https://github.com/thomashaus/project-template.git my-new-project
cd my-new-project

# Remove template git history
rm -rf .git
git init
```

### 2. Install Git Hooks
```bash
# Make scripts executable
chmod +x scripts/*.sh .hooks/*

# Run setup
./scripts/setup-hooks.sh

# Or manually install hooks
cp .hooks/* .git/hooks/
chmod +x .git/hooks/*
```

### 3. Customize for Your Project
1. **Edit CLAUDE.md** - Update project description, tech stack, and conventions
2. **Update package.json** - Add your dependencies and scripts
3. **Create .env.example** - Document required environment variables
4. **Update this README** - Replace with your project info

### 4. Install Dependencies
```bash
# If using npm
npm init -y
npm install

# If copying from existing project
npm install
```

## Git Hooks Details

### Commit Message Format
```
type(scope): subject

Types: feat, fix, refactor, perf, test, docs, chore, style, ci, build, revert

Examples:
  feat(auth): add OAuth login
  fix(api): handle null response
  docs(readme): update setup instructions
```

### Pre-Commit Checks
- ESLint (if configured)
- TypeScript (if configured)
- Gitleaks secret scan
- Large file detection
- Sensitive keyword detection

### Pre-Push Checks
- Full test suite
- Production build
- Complete security scan
- TODO/FIXME detection
- Branch naming validation

## Security

### Gitleaks Configuration
The `.gitleaks.toml` file configures secret detection for:
- API keys and tokens
- Database credentials
- OAuth secrets
- Private keys

### Running Security Checks
```bash
# Manual check
./scripts/security-check.sh

# Gitleaks directly
gitleaks detect --config .gitleaks.toml --no-banner

# Full git history scan
gitleaks detect --config .gitleaks.toml --no-banner
```

### Secret Patterns Detected
- Generic API keys (`api_key`, `secret`, `token`)
- Database URLs with credentials
- OAuth client IDs and secrets
- Private keys (Firebase, etc.)
- Custom project patterns

## GitHub Actions

### Test Suite (test.yml)
Runs on:
- Push to main/master
- Pull requests to main/master

Jobs:
1. **Lint** - ESLint check
2. **Tests** - Test suite with coverage
3. **Build** - Production build
4. **Security** - Gitleaks scan

### Required Secrets
- `GITHUB_TOKEN` (auto-provided)
- `GITLEAKS_LICENSE` (for gitleaks-action, if using Pro features)

## Documentation Templates

### Feature Specification (`docs/specs/`)
- Problem statement
- User stories
- Technical design
- API changes
- Database changes
- Testing strategy

### Implementation Plan (`docs/plans/`)
- Step-by-step implementation
- Database migrations
- Rollback procedure
- Testing checklist
- Deployment steps

## Customization

### Add Custom Gitleaks Rules
Edit `.gitleaks.toml`:
```toml
[[rules]]
id = "my-custom-token"
description = "My Custom Token Pattern"
regex = '''my_token_[a-zA-Z0-9]{32}'''
keywords = ["my_token_"]
```

### Extend Git Hooks
Add checks to `.hooks/pre-commit`:
```bash
# Custom check
run_check "your-command" "Your check name" || true
```

### Add GitHub Workflows
Create new files in `.github/workflows/`:
- `deploy.yml` - Deployment automation
- `release.yml` - Release automation
- `dependabot.yml` - Dependency updates

## Best Practices

### DO ✅
- Create issues before starting work
- Use conventional commit messages
- Write specs for significant features
- Run security checks before pushing
- Keep CLAUDE.md updated

### DON'T ❌
- Commit real credentials
- Skip pre-commit hooks (`--no-verify`)
- Ignore failing tests
- Leave TODOs in production code

## Requirements

### Required
- Git 2.x+
- Node.js 18+ (for npm)

### Optional
- Gitleaks (for secret scanning)
- Claude Code CLI (for AI-assisted development)

## Contributing

1. Fork the repository
2. Create a feature branch (`feature/improvement`)
3. Make changes following conventions
4. Run all checks: `./scripts/security-check.sh`
5. Submit a pull request

## License

MIT License - Feel free to use for any project.

---

**Maintained by**: Tom Haus  
**Inspired by**: espresso.haus project standards
