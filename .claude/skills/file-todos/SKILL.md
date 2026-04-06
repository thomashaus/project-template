---
name: file-todos
description: Structured todo files for tracking review findings, bugs, and action items. Use for code review findings and work tracking.
---

# File-Todos Skill

Track findings and action items as structured markdown files in `todos/`.

## Naming Convention

```
{issue_id}-{status}-{priority}-{description}.md
```

**Examples:**
- `001-pending-p1-sql-injection-user-search.md`
- `002-pending-p2-missing-index-events-table.md`
- `003-ready-p3-cleanup-unused-middleware.md`

## Status Values

| Status | Meaning |
|--------|---------|
| `pending` | New finding, needs triage |
| `ready` | Approved, ready to work |
| `complete` | Work finished |

## Priority Values

| Priority | Meaning |
|----------|---------|
| `p1` | Critical — blocks merge, security/data issues |
| `p2` | Important — should fix, architecture/performance |
| `p3` | Nice-to-have — enhancements, cleanup |

## Template

Use [todo-template.md](./assets/todo-template.md) for all new todos.

## Usage in Review

After review synthesis:
1. Create todo files for ALL findings immediately
2. Group by severity (P1/P2/P3)
3. For large reviews (15+ findings), use parallel subagents
4. Present summary to user after creation
