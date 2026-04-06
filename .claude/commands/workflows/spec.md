---
name: workflows:spec
description: Define or update an API specification (OpenAPI/AsyncAPI)
argument-hint: "[endpoint or event to define]"
---

Use the **spec** agent to handle this specification task.

## Context
$ARGUMENTS

## Instructions
1. Determine if this is a REST endpoint (OpenAPI) or event/message (AsyncAPI)
2. Check for existing specs in `specs/openapi/` or `specs/asyncapi/`
3. Create or update the spec following project conventions in CLAUDE.md
4. Validate the spec: `npm run spec:validate`
5. Generate types if validation passes: `npm run spec:generate`
6. Summarize what was created/changed
