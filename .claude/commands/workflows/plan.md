---
name: workflows:plan
description: Transform feature descriptions into well-structured implementation plans with research
argument-hint: "[feature description, brainstorm file, or bug report]"
---

# Create an Implementation Plan

**This is 40% of the effort.** A thorough plan makes execution easy.

## Feature Description

<feature_description> $ARGUMENTS </feature_description>

**If empty, ask:** "What would you like to plan? Describe the feature, bug fix, or improvement."

### 0. Check for Brainstorm

Before asking questions, check for relevant brainstorm documents:

```bash
ls -la docs/brainstorms/*.md 2>/dev/null | head -10
```

If a relevant brainstorm exists (matching topic, < 14 days old):
1. Read it
2. Use its decisions as input — skip idea refinement
3. Note: "Using brainstorm from [date]: [topic]"

If no brainstorm, do brief idea refinement:
- Ask 2-3 clarifying questions
- Focus on: purpose, constraints, success criteria
- User can say "proceed" to skip ahead

## Main Tasks

### 1. Local Research (Parallel — Always Runs)

Run these agents **in parallel**:

- Task repo-research-analyst(feature_description)
- Task learnings-researcher(feature_description)
- Task git-history-analyzer(feature_description)

**What to look for:**
- Existing patterns to follow
- CLAUDE.md guidance
- Documented solutions in `docs/solutions/` (gotchas, patterns)
- Recent changes to related code

### 1.5. Research Decision

Based on signals from Step 0 and findings from Step 1:

**Always research if:** Security, external APIs, database schema design, payments
**Skip external research if:** Strong local patterns exist, user knows what they want
**Research if uncertain:** New technology, no codebase examples, open-ended approach

### 1.5b. External Research (Conditional)

Only if Step 1.5 says yes:

- Task best-practices-researcher(feature_description)

### 1.6. Consolidate Research

- Document relevant file paths (e.g., `services/api-gateway/src/routes/example.ts:42`)
- Include institutional learnings from `docs/solutions/`
- Note external best practices (if researched)
- List CLAUDE.md conventions that apply

### 2. Plan Structure

**Filename:** `docs/plans/YYYY-MM-DD-<type>-<descriptive-name>-plan.md`

Examples:
- `docs/plans/2026-02-09-feat-user-authentication-plan.md`
- `docs/plans/2026-02-09-fix-event-processing-timeout-plan.md`

### 3. Choose Detail Level

#### 📄 MINIMAL (Quick — simple bugs, clear features)

```markdown
---
title: [Title]
type: feat|fix|refactor
date: YYYY-MM-DD
---

# [Title]

[Brief description]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Context
[Critical info, relevant specs, file references]

## Learnings Applied
[Which docs/solutions/ entries informed this plan]
```

#### 📋 STANDARD (Most features)

Adds: Overview, Proposed Solution, Technical Considerations,
Success Metrics, Dependencies & Risks, Implementation Tasks with
file references and acceptance criteria per task.

#### 📚 COMPREHENSIVE (Major features, architecture changes)

Adds: Detailed phased implementation, Alternative approaches considered,
Risk analysis & mitigation, Non-functional requirements (performance,
security, accessibility), Documentation plan.

### 4. Write the Plan

Include in every plan:
- **Tasks with file references**: Which files to create/modify
- **Task dependencies**: What must complete first
- **Acceptance criteria per task**: How to verify done
- **Learnings Applied section**: Which past solutions informed this plan
- **Testing strategy**: How to test end-to-end
- **Spec references**: Links to OpenAPI/AsyncAPI contracts

### 5. Post-Generation Options

After writing the plan:

1. **Start `/workflows:work`** — Begin implementing this plan
2. **Run `/workflows:review`** — Get technical feedback on the plan
3. **Refine** — Improve specific sections
4. **Create git branch** — Set up feature branch from the plan

NEVER CODE during planning. Only research and write the plan.
