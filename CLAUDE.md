# {{PROJECT_NAME}}

## Architecture

3-tier architecture: **API Gateway** (Node.js/Express) → **Services** (Python/FastAPI) → **Database** (PostgreSQL).

All inter-service contracts are spec-first: OpenAPI for REST, AsyncAPI for events.

## Directory Layout

```
├── specs/                  # Source of truth for all contracts
│   ├── openapi/            # REST API specs (OpenAPI 3.1)
│   └── asyncapi/           # Event/message specs (AsyncAPI 3.0)
├── services/
│   ├── api-gateway/        # Node.js Express — public-facing API tier
│   └── worker-service/     # Python FastAPI — business logic & background jobs
├── db/
│   ├── migrations/         # PostgreSQL migrations (node-pg-migrate)
│   └── seeds/              # Dev/test seed data
├── docs/
│   ├── plans/              # Implementation plans
│   ├── brainstorms/        # Feature exploration documents
│   └── solutions/          # Compound knowledge base (categorized)
│       └── patterns/       # Critical patterns — Required Reading
├── todos/                  # Structured review findings and action items
├── scripts/                # Build, deploy, and CI helper scripts
└── .claude/
    ├── agents/             # Agent definitions
    │   ├── research/       # Research subagents
    │   └── review/         # Review subagents
    ├── commands/
    │   └── workflows/      # Compound engineering workflow commands
    └── skills/             # Reusable skill definitions
```

## Tech Stack

| Layer       | Technology          | Notes                              |
|-------------|---------------------|-------------------------------------|
| API Gateway | Node.js 22 + Express 5 | TypeScript, OpenAPI validation   |
| Services    | Python 3.12 + FastAPI | Pydantic v2, async-first         |
| Database    | PostgreSQL 16       | node-pg-migrate for migrations     |
| Specs       | OpenAPI 3.1         | Swagger UI served from gateway     |
| Events      | AsyncAPI 3.0        | For inter-service messaging        |
| Containers  | Docker Compose      | Local dev environment              |

## Key Commands

```bash
# Local dev
docker compose up -d                 # Start all services + postgres
npm run dev --workspace=api-gateway  # Gateway in watch mode
cd services/worker-service && uv run fastapi dev  # Worker in dev mode

# Database
npm run migrate up                   # Run pending migrations
npm run migrate create <n>           # Create new migration

# Specs & docs
npm run spec:validate                # Validate all OpenAPI/AsyncAPI specs
npm run spec:generate                # Generate types from specs

# Quality
npm run lint                         # Lint all workspaces
npm run test                         # Run all tests
npm run typecheck                    # TypeScript type checking
cd services/worker-service && uv run pytest  # Python tests
```

## Code Standards

- TypeScript strict mode, no `any` — use `unknown` + type guards
- Python: ruff for linting/formatting, mypy for type checking
- All REST endpoints must have OpenAPI spec BEFORE implementation
- All event schemas must have AsyncAPI spec BEFORE publishing
- Database migrations are forward-only; never edit a committed migration
- Every PR needs: passing tests, lint clean, spec validation, updated docs

## Security Rules - CRITICAL

### NEVER Commit These Items
1. **Real API keys** (DigitalOcean, AWS, Tana, etc.)
2. **Secret tokens** or authentication credentials
3. **Files with real credentials** in any format
4. **`.env.local`** or similar files with real values

### ALWAYS Use Templates
1. **`.env.example`** for environment variable templates
2. **Placeholder values** like `YOUR_API_KEY_HERE`
3. **Example tokens** clearly marked as examples
4. **Environment variables** instead of hardcoded credentials

### Automated Security Hooks
- **PreToolUse**: Blocks edits on `main` branch + blocks operations with detected credentials
- **PostToolUse**: Runs linting after edits
- **Security skill**: Invoke `/security-review` for manual security scans

### Before Committing
1. **Run `gitleaks`** to ensure no secrets are committed
   ```bash
   gitleaks detect --no-banner
   ```
2. **Review git diff** carefully for any credentials
3. **Use `.env.example`** for templates, `.env.local` for real values
4. **Verify `.env.local` is in `.gitignore`**

### Emergency Procedures
If real credentials are accidentally committed:
1. **IMMEDIATE ACTION**: Remove credentials from files
2. **ROTATE KEYS**: Invalidate all exposed API keys/tokens immediately
3. **GIT HISTORY**: Consider rewriting git history to remove commits with secrets
4. **SCAN REPO**: Run `gitleaks` to verify all secrets are removed
5. **UPDATE .gitignore**: Ensure sensitive files are properly excluded

### Security Commands
```bash
# Scan for secrets
gitleaks detect --no-banner

# Check current files only (no git history)
gitleaks detect --no-git --no-banner

# Check git history (includes deleted files)
gitleaks detect --no-banner
```

### Security Skill
Use the `/security-review` skill to perform comprehensive security audits before committing code, especially when:
- Adding new API integrations
- Modifying authentication logic
- Working with environment variables
- Setting up external service connections

## Commit and PR Standards

### Commit Message Format

All commits follow **conventional commits** format:

```
<type>: <description>

[optional body]

Refs: docs/plans/xyz.md
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

### Commit Types
- **feat**: New feature
- **fix**: Bug fix
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **docs**: Documentation only changes
- **test**: Adding or updating tests
- **chore**: Maintenance tasks
- **perf**: Performance improvement
- **security**: Security vulnerability fix

### Commit Examples

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

### Pre-Push Validation

Git pre-push hook automatically runs before pushing:
```bash
scripts/pre-push-check.sh
```

**Checks performed:**
- ✅ Gitleaks security scan (blocking)
- ✅ TypeScript type checking (blocking for api-gateway)
- ⚠️  Linting (non-blocking advisory)
- ⚠️  Tests (non-blocking advisory)

If blocking checks fail, push is aborted. Fix issues and try again.

**Manual pre-push check:**
```bash
bash scripts/pre-push-check.sh
```

### Pull Request Workflow

When ready to create a PR from current branch:
```bash
/pr
```

**Pre-PR checklist:**
- [ ] All tests pass: `npm run test`
- [ ] Linting clean: `npm run lint`
- [ ] Type checking passes: `npm run typecheck`
- [ ] Security scan clean: `gitleaks detect --no-banner`
- [ ] Specs validated: `npm run spec:validate`
- [ ] Code reviewed: `/workflows:review` (for significant changes)
- [ ] Documentation updated (if needed)

**Generated PR includes:**
- Structured description from commits
- Type (feat/fix/refactor/docs/test)
- References to plan docs
- Test plan checklist
- Review checklist (spec conformance, security, performance)
- Co-authored-by attribution

### Branch Protection

**Main branch protection rules:**
- **No direct edits**: Must use feature branches
- **PR required**: All changes via pull request
- **Checks required**: Tests, lint, security scan must pass
- **Review required**: At least one approval (for significant changes)

### CI/CD Automation Skill

Use the `/ci-cd` skill for:
- Creating pull requests with validation
- Understanding commit standards
- Configuring CI/CD pipelines
- Troubleshooting pre-push failures

**Resources:**
- `.claude/skills/ci-cd.md` - Full CI/CD workflow documentation
- `.gitleaks/config.toml` - Secret detection patterns
- `.claude/hooks/pre-tool-use.mjs` - Automated credential blocking
- `.git/hooks/pre-push` - Pre-push validation hook
- `scripts/pre-push-check.sh` - Pre-push check script

## Compound Engineering Workflow

This project uses **compound engineering** methodology (inspired by Every.to).

**Core principle**: Each unit of work should make subsequent units easier, not harder.

**80/20 Rule**: 80% of effort in Plan + Review, 20% in Work.

### The Loop

```
Brainstorm → Plan → Work → Review → Compound
    ↑                                    ↓
    └──── learnings feed back into ──────┘
```

### Workflow Commands

| Command | Phase | Effort | Purpose |
|---------|-------|--------|---------|
| `/workflows:brainstorm` | 0 | — | Explore WHAT to build |
| `/workflows:plan` | 1 | 40% | Research + create implementation plan |
| `/workflows:work` | 2 | 20% | Execute plan with incremental commits |
| `/workflows:review` | 3 | 40% | Multi-agent parallel code review |
| `/workflows:compound` | 4 | — | Capture learnings for next cycle |
| `/workflows:spec` | Any | — | Define/update API contracts |

### Agent Team

| Agent | Role | Notes |
|-------|------|-------|
| **compound** | Master orchestrator — runs the full loop | Delegates to all others |
| **plan** | Research and implementation planning | Reads learnings first |
| **work** | Code implementation against specs/plans | Incremental commits |
| **review** | Multi-agent parallel code review | Read-only, creates todos |
| **spec** | API-first contract design | OpenAPI + AsyncAPI |

### Research Subagents (used by plan)

| Agent | Purpose |
|-------|---------|
| repo-research-analyst | Scans codebase patterns, conventions |
| learnings-researcher | Searches docs/solutions/ for past lessons |
| best-practices-researcher | External best practices (for high-risk topics) |
| git-history-analyzer | Commit history patterns and context |

### Review Subagents (used by review)

| Agent | Focus |
|-------|-------|
| security-sentinel | Vulnerabilities, injection, auth gaps |
| performance-oracle | N+1, bottlenecks, scalability |
| code-simplicity-reviewer | YAGNI, overengineering |
| architecture-strategist | Service boundaries, coupling |
| spec-conformance-reviewer | API contract drift |
| data-integrity-guardian | Migration safety, query safety |

### Knowledge Locations

| What | Where | When Read |
|------|-------|-----------|
| Project rules | `CLAUDE.md` (this file) | Every agent, every time |
| Critical patterns | `docs/solutions/patterns/critical-patterns.md` | Every plan and review |
| Accumulated solutions | `docs/solutions/[category]/` | During plan research |
| Implementation plans | `docs/plans/` | During work execution |
| Feature explorations | `docs/brainstorms/` | During planning |
| Review findings | `todos/` | During work prioritization |
| API contracts | `specs/openapi/`, `specs/asyncapi/` | During work and review |

### Compound Step Rules

1. **Never skip it** — even small changes produce learnings
2. Solutions go in `docs/solutions/[category]/` with YAML frontmatter
3. Critical patterns get promoted to `docs/solutions/patterns/critical-patterns.md`
4. Universal rules get promoted to this file (CLAUDE.md)
5. Past learnings MUST be read at the start of every planning phase
6. All solution docs use validated YAML schema (see `.claude/skills/compound-docs/`)

## CTO Strategic Workflow

This project includes a **CTO strategic workflow** for organizational and technical leadership decisions — complementary to the compound engineering workflow.

**Purpose**: Strategic oversight, not daily execution. Think in terms of 6-12 month trajectory, team health, and technical sustainability.

### CTO Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/cto:architecture-review` | Evaluate system architecture from strategic perspective | Before major initiatives, when complexity grows, evaluating vendor solutions |
| `/cto:team-planning` | Plan team capacity, headcount, and organizational structure | Quarterly planning, before major projects, when team is over/under capacity |
| `/cto:tech-debt-assessment` | Assess, prioritize, and plan technical debt remediation | Quarterly debt reviews, when velocity slows, before migrations |
| `/cto:hiring-interview` | Prepare for and conduct technical hiring interviews | Before interview cycles, when debriefing candidates, making hiring decisions |

### CTO Agent

The **cto agent** provides strategic technical leadership:

- **Architecture**: System boundaries, service responsibilities, technical roadmaps
- **Team**: Capacity planning, organizational design, hiring strategy
- **Technical Debt**: Assessment, prioritization, remediation planning
- **Decision-making**: Strategic trade-offs, risk assessment, stakeholder communication

**Boundary**: CTO for strategy and cross-team decisions; directors own their team's execution.

### Interaction with Other Workflows

**CTO + Compound Workflow**:
- Use `/cto:*` commands FIRST for strategic decisions
- Then use `/workflows:plan` for implementation details
- Example: `/cto:architecture-review` → decision → `/workflows:plan` → execute

**CTO + Athena (Personal Chief of Staff)**:
- **Athena**: Personal productivity, morning block protection, daily triage
- **CTO**: Organizational strategy, technical direction, team decisions
- **Complementary**: Athena protects Tom's time; CTO protects the org's technical health

**CTO + Directors**:
- CTO agent supports Tom's thinking, doesn't replace directors
- Directors own execution and operational decisions within their domains
- CTO for strategy and cross-team decisions; directors for their team's work

### Knowledge Locations

| What | Where | When Read |
|------|-------|-----------|
| Architecture decisions | `docs/solutions/architecture/` | During architecture reviews |
| Technical debt inventory | `docs/solutions/technical-debt/` | During debt assessments |
| Team plans | `docs/plans/team/` | During team planning |
| Hiring rubrics | `docs/solutions/hiring/` | During interview preparation |
| Strategic decisions | Tana calendar (daily/, weekly/, monthly/) | For context on past decisions |

## Branching

- `main` — protected, requires PR review
- `feat/<n>` — feature branches
- `fix/<n>` — bug fixes
- Always branch from `main`, always rebase before PR
