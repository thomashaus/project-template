---
title: "[Descriptive title of the problem]"
module: "[Module or system affected]"
date: YYYY-MM-DD
problem_type: "[enum from schema]"
component: "[enum from schema]"
symptoms:
  - "[Observable symptom 1]"
  - "[Observable symptom 2]"
root_cause: "[enum from schema]"
severity: "[critical|high|medium|low]"
tags: [keyword1, keyword2, keyword3]
related_specs: []
related_plans: []
---

# [Title]

## Problem

### Symptom
[What was observed — exact error messages, observable behavior]

### Context
[When/where this occurred — which endpoint, which service, what operation]

## Investigation

### What We Tried
1. [First attempt — what was tried and why it didn't work]
2. [Second attempt — what was tried and why it didn't work]

### Root Cause
[Technical explanation of why this happened]

## Solution

### Fix Applied
```
[Code changes with file:line references]
```

### Why This Works
[Explanation connecting the fix to the root cause]

## Prevention

### Rules for Future Agents
- When doing [X], always [Y] because [Z]
- Never [A] without first checking [B]

### How to Detect Early
- [What to look for in code review]
- [What tests to write]

## Related
- [Links to related solutions, specs, or plans]
