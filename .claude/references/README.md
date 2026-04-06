# External References

This directory contains optional references to external implementations and plugins for comparison and learning purposes.

## Purpose

These references are for **validation and learning only**, not for direct replacement of existing functionality.

## EveryInc Compound Engineering Plugin

The official EveryInc/compound-engineering-plugin implementation can be cloned here for reference:

```bash
# Clone for optional reference (not required)
git clone https://github.com/EveryInc/compound-engineering-plugin.git official
```

**Usage notes:**
- Compare agent prompts and workflow design
- Validate that custom implementation follows best practices
- Learn from official patterns and conventions
- **DO NOT replace** existing `/workflows:*` commands

## What to Keep vs Reference

### Keep (Custom Implementation)
- ✅ Custom `/workflows:*` compound workflow
- ✅ Project-specific agents (compound, plan, work, review, spec)
- ✅ TanaChat-specific knowledge and patterns
- ✅ Custom skill definitions

### Reference (Learn From Official)
- 📖 Official agent prompt structures
- 📖 Workflow loop patterns
- 📖 Documentation formatting
- 📖 Naming conventions

## Comparison Guide

When comparing custom vs official implementation:

| Aspect | Custom (`/workflows:*`) | Official (`/ce:*`) | Decision |
|--------|-------------------------|-------------------|----------|
| Namespace | Project-specific | Generic | **Keep custom** |
| Agents | Tailored to architecture | Generic | **Keep custom** |
| Prompts | Domain-specific (3-tier, spec-first) | Universal | **Keep custom** |
| Documentation | TanaChat-specific | Universal | **Keep custom** |
| Workflow loop | Same pattern | Same pattern | **Validate alignment** |
| Review subagents | Custom agents | Official agents | **Compare and enhance** |

## Adding New References

To add a new reference implementation:

1. Create directory: `.claude/references/<name>/`
2. Clone or symlink external repo
3. Add README explaining purpose and usage
4. Document comparison points

## Notes

- References are **optional** - project works without them
- References are **read-only** - don't modify external code
- References are **for learning** - not for direct copying
- When in doubt, keep custom implementation and enhance it
