---
name: brainstorming
description: Explore requirements and approaches through collaborative dialogue before planning. Use when the WHAT is unclear before the HOW.
---

# Brainstorming Skill

Brainstorming answers **WHAT** to build. Planning answers **HOW** to build it.

## Question Techniques

### Start Broad, Then Narrow
1. **Purpose**: "What problem does this solve for users?"
2. **Users**: "Who uses this? What's their workflow?"
3. **Scope**: "What's the minimum version that's useful?"
4. **Constraints**: "Any performance/security/compatibility requirements?"
5. **Edge cases**: "What happens when X fails? What about empty state?"

### Prefer Multiple Choice
When natural options exist, present 2-4 choices rather than open-ended questions.

### YAGNI Filter
For each proposed capability, ask: "Do we need this now, or is this for a hypothetical future?"

## Approach Exploration

Present 2-3 concrete approaches. For each:
- Brief description (2-3 sentences)
- Pros and cons
- Effort estimate (small/medium/large)
- When it's best suited

Lead with your recommendation and explain why. Prefer simpler solutions.

## Output Format

Write brainstorm to `docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md`:

```markdown
---
topic: [Brief topic description]
date: YYYY-MM-DD
status: decided | exploring
chosen_approach: [Which approach was selected]
---

# Brainstorm: [Topic]

## What We're Building
[Summary of the feature/change]

## Why This Approach
[Rationale for chosen approach]

## Key Decisions
- Decision 1: [Choice made and why]
- Decision 2: [Choice made and why]

## Open Questions
- [ ] Unresolved question 1
- [ ] Unresolved question 2

## Approaches Considered
### Approach A: [Name]
[Description, pros, cons]

### Approach B: [Name]
[Description, pros, cons]
```
