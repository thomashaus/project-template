---
name: compound-docs
description: Capture solved problems as categorized documentation with YAML frontmatter for fast lookup. Use after confirming a fix works.
allowed-tools:
  - Read
  - Write
  - Bash
  - Grep
---

# compound-docs Skill

Automatically document solved problems to build searchable institutional knowledge
with category-based organization and enum-validated YAML frontmatter.

## Organization

Single-file architecture: each problem is one markdown file in its category directory.

```
docs/solutions/
├── patterns/
│   └── critical-patterns.md    # Required Reading — always checked
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

## 7-Step Process

### Step 1: Detect Confirmation

Auto-invoke after: "that worked", "it's fixed", "working now", "problem solved"

**Document when:** Multiple investigation attempts needed, non-obvious solution,
future sessions would benefit.

**Skip when:** Simple typos, obvious syntax errors, trivial fixes.

### Step 2: Gather Context

Extract from conversation:
- **Module name**: Which system had the problem
- **Symptom**: Exact error messages or observable behavior
- **Investigation**: What didn't work and why
- **Root cause**: Technical explanation
- **Solution**: Code/config changes that fixed it
- **Prevention**: How to avoid in future

If critical context is missing, ask and wait before proceeding.

### Step 3: Check Existing Docs

```bash
grep -r "keyword" docs/solutions/ --include="*.md"
```

If similar issue found, offer: (1) create new with cross-reference, (2) update existing.

### Step 4: Generate Filename

Format: `[sanitized-symptom]-[module]-[YYYYMMDD].md`
- Lowercase, hyphens, no special characters, < 80 chars

### Step 5: Validate YAML Schema

All frontmatter must validate against [yaml-schema.md](./references/yaml-schema.md).
**BLOCK** if validation fails — show specific errors and retry.

### Step 6: Create Documentation

Use template from [resolution-template.md](./assets/resolution-template.md).

```bash
mkdir -p "docs/solutions/${CATEGORY}"
# Write file using template populated with gathered context
```

### Step 7: Cross-Reference & Critical Pattern Detection

If similar issues found, add cross-references to both docs.

If this represents a recurring pattern (3+ similar issues), add to
`docs/solutions/patterns/critical-patterns.md` using the
[critical-pattern-template.md](./assets/critical-pattern-template.md).

## Decision Menu After Capture

```
✓ Solution documented: docs/solutions/[category]/[filename].md

What's next?
1. Continue workflow (recommended)
2. Add to Required Reading (promote to critical-patterns.md)
3. Link related issues
4. Update CLAUDE.md with new project rule
5. View documentation
6. Other
```

## Quality Guidelines

**Good documentation has:**
- Exact error messages (copy-paste)
- Specific file:line references
- Failed attempts documented (helps avoid wrong paths)
- Technical "why", not just "what"
- Code examples (before/after)
- Prevention guidance

**Avoid:**
- Vague descriptions ("something was wrong")
- Missing technical details ("fixed the code")
- No prevention guidance
- No cross-references
