---
name: workflows:compound
description: Document a recently solved problem to compound team knowledge
argument-hint: "[optional: brief context about the fix]"
---

# /workflows:compound

Capture a recently solved problem as structured documentation. Each documented
solution compounds knowledge — the first fix takes research, the next takes minutes.

## Context

<context_hint> $ARGUMENTS </context_hint>

## Purpose

**Why "compound"?** Each documented solution makes future work easier.
The first time you solve a problem takes research. Document it, and
the next occurrence takes minutes. Knowledge compounds.

## Preconditions

- Problem has been solved (not in-progress)
- Solution has been verified working
- Non-trivial problem (not a simple typo)

## Execution: Two-Phase Orchestration

**Only ONE file gets written — the final documentation.**

Phase 1 subagents return TEXT DATA to the orchestrator. They do NOT create files.

### Phase 1: Parallel Research

Launch these subagents **in parallel**. Each returns text data.

#### 1. Context Analyzer
- Extract problem type, module, symptoms from conversation history
- Validate against YAML schema enums
- Return: YAML frontmatter skeleton

#### 2. Solution Extractor
- Analyze all investigation steps
- Identify root cause
- Extract working solution with code examples
- Return: Solution content block

#### 3. Related Docs Finder
- Search `docs/solutions/` for related documentation
- Identify cross-references and links
- Return: Links and relationships

#### 4. Prevention Strategist
- Develop prevention strategies
- Create rules for future agents
- Suggest tests if applicable
- Return: Prevention/testing content

#### 5. Category Classifier
- Determine `docs/solutions/` category from problem_type
- Validate against schema
- Suggest filename
- Return: Final path and filename

### Phase 2: Assembly & Write

**WAIT for all Phase 1 subagents to complete.**

1. Collect all text results from Phase 1
2. Assemble complete markdown file using `compound-docs` skill
3. Validate YAML frontmatter against schema (BLOCK if invalid)
4. Create directory: `mkdir -p docs/solutions/[category]/`
5. Write the SINGLE final file

### Phase 3: Optional Enhancement

Based on problem type, optionally invoke review agents:
- **performance_issue** → Task performance-oracle(review documentation)
- **security_issue** → Task security-sentinel(review documentation)
- **database_issue** → Task data-integrity-guardian(review documentation)

## What It Captures

- **Problem symptom**: Exact error messages, observable behavior
- **Investigation steps**: What didn't work and why
- **Root cause analysis**: Technical explanation
- **Working solution**: Step-by-step fix with code examples
- **Prevention strategies**: How to avoid in future
- **Rules for future agents**: Actionable "when X, always Y" statements
- **Cross-references**: Links to related docs

## Decision Menu After Capture

```
✓ Solution documented: docs/solutions/[category]/[filename].md

What's next?
1. Create PR — run /workflows:pr (recommended if work is complete)
2. Add to Required Reading — promote to critical-patterns.md
3. Link related issues
4. Update CLAUDE.md with new project rule
5. View documentation
6. Other
```

**Option 2: Add to Required Reading**

When a pattern is critical (3+ occurrences, non-obvious, foundational):
1. Extract pattern from the documentation
2. Format as ❌ WRONG vs ✅ CORRECT with code examples
3. Add to `docs/solutions/patterns/critical-patterns.md`
4. All agents will see this pattern before code generation

**Option 4: Update CLAUDE.md**

When a learning applies project-wide:
1. Add rule to CLAUDE.md under appropriate section
2. Every agent reads CLAUDE.md first — this makes the rule universal

## Auto-Invoke Triggers

Trigger phrases:
- "that worked"
- "it's fixed"
- "working now"
- "problem solved"

Or invoke manually: `/workflows:compound [context]`

## The Compounding Philosophy

```
Plan → Work → Review → Compound → PR → Repeat
  ↑                                        ↓
  └──────── learnings feed back into ──────┘
```

Each unit of engineering work should make subsequent units easier — not harder.
