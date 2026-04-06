# Multi-Agent Project Template

A production-ready project template with **compound engineering** — a methodology where
each development cycle makes the next one easier through deliberate knowledge capture.

Inspired by [Every.to's Compound Engineering](https://every.to/p/compound-engineering-how-every-codes-with-agents)
and their [open-source plugin](https://github.com/EveryInc/compound-engineering-plugin).

## Quick Start

```bash
/bootstrap my-project-name
```

Then start building:

```bash
/workflows:brainstorm add user authentication    # Explore WHAT to build
/workflows:plan user auth with JWT tokens        # Create implementation plan
/workflows:work docs/plans/2026-02-09-feat-...   # Execute the plan
/workflows:review                                # Multi-agent code review
/workflows:compound                              # Capture learnings
```

## The Compound Engineering Loop

```
Brainstorm → Plan → Work → Review → Compound
    ↑                                    ↓
    └──── learnings feed back into ──────┘
```

**80/20 Rule**: 80% of effort in Plan + Review, 20% in Work.

### Phase 0: Brainstorm (optional)
Answers **WHAT** to build through collaborative dialogue. Outputs to `docs/brainstorms/`.

### Phase 1: Plan (40% of effort)
Research agents scan the codebase and past learnings **in parallel**, then create a
detailed implementation plan. The plan includes tasks, dependencies, acceptance criteria,
and which past solutions informed the approach.

**Research agents** (run in parallel):
- `repo-research-analyst` — codebase patterns and conventions
- `learnings-researcher` — past solutions from `docs/solutions/`
- `git-history-analyzer` — commit history context
- `best-practices-researcher` — external best practices (conditional)

### Phase 2: Work (20% of effort)
Execute the plan with incremental commits, continuous testing, and spec validation.
If the plan is thorough, this should be the easy part.

**Branch naming**: Use `<type>/<issue-number>-description` format (e.g., `feat/42-user-auth`)
to enable automatic workflow label transitions via GitHub Actions.

### Phase 3: Review (40% of effort)
**Parallel multi-perspective review** using specialized subagents:
- `security-sentinel` — vulnerabilities, injection, auth gaps
- `performance-oracle` — N+1, bottlenecks, scalability
- `code-simplicity-reviewer` — YAGNI, overengineering
- `architecture-strategist` — service boundaries, coupling
- `spec-conformance-reviewer` — API contract drift
- `data-integrity-guardian` — migration safety (conditional)

Findings become structured todos in `todos/` with severity levels (P1/P2/P3).

### Phase 4: Compound (never skip)
Captures what was learned into structured documentation in `docs/solutions/`.
Critical patterns get promoted to Required Reading. Universal rules get added to CLAUDE.md.

**This is the step that makes it compound.** Without it, knowledge stays in conversation
history and disappears.

## Knowledge System

```
docs/solutions/
├── patterns/
│   └── critical-patterns.md    ← Required Reading (always checked)
├── performance-issues/
├── database-issues/
├── security-issues/
├── api-issues/
├── runtime-errors/
├── build-errors/
├── test-failures/
├── integration-issues/
├── logic-errors/
├── developer-experience/
├── workflow-issues/
├── best-practices/
└── documentation-gaps/
```

Every solution has YAML frontmatter with validated enums for problem_type, component,
root_cause, and severity. This makes solutions searchable and categorizable by the
`learnings-researcher` agent.

## Agent Architecture

```
┌──────────────────────────────────────────────────┐
│  compound (orchestrator)                         │
│  Runs the full loop: brainstorm→plan→work→review │
├──────────┬───────────┬───────────┬───────────────┤
│ plan     │ work      │ review    │ spec          │
│ ┌──────┐ │           │ ┌───────┐ │               │
│ │repo  │ │           │ │securi │ │               │
│ │resrch│ │           │ │ty     │ │               │
│ ├──────┤ │           │ ├───────┤ │               │
│ │learn │ │           │ │perfor │ │               │
│ │resrch│ │           │ │mance  │ │               │
│ ├──────┤ │           │ ├───────┤ │               │
│ │git   │ │           │ │simpli │ │               │
│ │hstry │ │           │ │city   │ │               │
│ ├──────┤ │           │ ├───────┤ │               │
│ │best  │ │           │ │archit │ │               │
│ │pract │ │           │ │ecture │ │               │
│ └──────┘ │           │ ├───────┤ │               │
│          │           │ │spec   │ │               │
│          │           │ │conf   │ │               │
│          │           │ ├───────┤ │               │
│          │           │ │data   │ │               │
│          │           │ │integr │ │               │
│          │           │ └───────┘ │               │
└──────────┴───────────┴───────────┴───────────────┘
```

## Skills

| Skill | Purpose |
|-------|---------|
| `compound-docs` | Structured solution capture with YAML schema validation |
| `brainstorming` | Question techniques and approach exploration |
| `file-todos` | Structured review findings with priority/status tracking |
| `git-worktree` | Parallel development with isolated worktrees |
| `spec-writing` | API-first design patterns |

## Tech Stack

| Layer | Technology |
|-------|-----------|
| API Gateway | Node.js 22 + Express 5 (TypeScript) |
| Services | Python 3.12 + FastAPI (Pydantic v2) |
| Database | PostgreSQL 16 (node-pg-migrate) |
| Specs | OpenAPI 3.1 + AsyncAPI 3.0 |
| CI/CD | GitHub Actions (workflow automation) |
| Dev Environment | Docker Compose |

## GitHub Actions Automation

The compound engineering workflow is **automated via GitHub Actions**:

**Setup (one-time)**: Run Actions → Bootstrap Labels to create workflow labels

**Automatic transitions**:
- Branch created → `status:in-progress`
- PR opened → `status:in-review`
- PR merged → closes issue + prompts compound step
- PR closed (no merge) → back to `status:in-progress`

This reduces manual workflow tracking — agents focus on thinking, automation handles labels.

## Customization

This template is opinionated about **workflow** (compound engineering) but flexible
about **technology**. To adapt the tech stack:

1. Replace services in `services/` with your stack
2. Update validation commands in agent prompts
3. Update `docker-compose.yaml` for your services
4. Keep the compound engineering workflow — it works with any stack

## License

MIT
