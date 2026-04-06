---
name: workflows:brainstorm
description: Explore requirements and approaches through collaborative dialogue before planning
argument-hint: "[feature idea or problem to explore]"
---

# Brainstorm a Feature or Improvement

Brainstorming answers **WHAT** to build. It precedes `/workflows:plan`, which answers **HOW**.

## Feature Description

<feature_description> $ARGUMENTS </feature_description>

**If empty, ask:** "What would you like to explore? Describe the feature, problem, or improvement."

## Execution Flow

### Phase 0: Assess Requirements Clarity

Check if brainstorming is even needed:
- Specific acceptance criteria already provided? → offer to skip to `/workflows:plan`
- Referenced existing patterns? → requirements may be clear enough
- Well-defined scope? → might not need exploration

### Phase 1: Research & Understand

#### 1.1 Quick Repo Scan (Parallel)

- Task repo-research-analyst("Understand existing patterns related to: <feature_description>")
- Task learnings-researcher("Search for relevant learnings about: <feature_description>")

#### 1.2 Collaborative Dialogue

Ask questions **one at a time**. Load the `brainstorming` skill for techniques.

- Start broad: "What problem does this solve?"
- Then narrow: "What's the minimum useful version?"
- Validate: "So the core requirement is X — is that right?"
- Prefer multiple choice when natural options exist

**Exit when:** Idea is clear OR user says "proceed"

### Phase 2: Explore Approaches

Propose **2-3 concrete approaches** based on research and conversation.

For each:
- Brief description (2-3 sentences)
- Pros and cons
- Effort: small/medium/large
- When it's best suited

Lead with your recommendation. Apply YAGNI — prefer simpler solutions.

### Phase 3: Capture the Design

Write to `docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md`.

```markdown
---
topic: [Brief topic]
date: YYYY-MM-DD
status: decided
chosen_approach: [Selected approach]
---

# Brainstorm: [Topic]

## What We're Building
## Why This Approach
## Key Decisions
## Open Questions
## Approaches Considered
```

### Phase 4: Next Steps

Offer:
1. **Start planning** → `/workflows:plan <brainstorm_file>`
2. **Refine further** → Continue dialogue
3. **Park it** → Save and revisit later

NEVER CODE. Only explore and document.
