# YAML Frontmatter Schema for docs/solutions/

All solution documents MUST have validated YAML frontmatter.

## Required Fields

```yaml
title: string          # Descriptive title of the problem/solution
module: string         # Which module or system was affected
date: YYYY-MM-DD       # Date the solution was documented
problem_type: enum     # Category (see below)
component: enum        # Technical component (see below)
symptoms:              # Array of 1-5 observable symptoms
  - string
root_cause: enum       # What caused the issue (see below)
severity: enum         # critical | high | medium | low
tags: [string]         # Searchable keywords (2-8 tags)
```

## Optional Fields

```yaml
related_specs: [string]   # OpenAPI/AsyncAPI spec paths affected
related_plans: [string]   # Plan documents that led to discovery
environment: string       # node | python | database | docker | infra
```

## Enum Values

### problem_type → category directory mapping

| problem_type          | Directory                          |
|-----------------------|------------------------------------|
| build_error           | docs/solutions/build-errors/       |
| test_failure          | docs/solutions/test-failures/      |
| runtime_error         | docs/solutions/runtime-errors/     |
| performance_issue     | docs/solutions/performance-issues/ |
| database_issue        | docs/solutions/database-issues/    |
| security_issue        | docs/solutions/security-issues/    |
| api_issue             | docs/solutions/api-issues/         |
| integration_issue     | docs/solutions/integration-issues/ |
| logic_error           | docs/solutions/logic-errors/       |
| developer_experience  | docs/solutions/developer-experience/ |
| workflow_issue        | docs/solutions/workflow-issues/    |
| best_practice         | docs/solutions/best-practices/     |
| documentation_gap     | docs/solutions/documentation-gaps/ |

### component values

- api_gateway, api_route, api_middleware
- worker_service, background_job, event_handler
- database, migration, query, index
- openapi_spec, asyncapi_spec
- docker, infrastructure, ci_cd
- authentication, authorization
- testing_framework, development_workflow
- documentation, tooling

### root_cause values

- missing_validation, missing_index, missing_migration
- wrong_api, wrong_type, wrong_config
- race_condition, async_timing, deadlock
- memory_leak, n_plus_one, unbounded_query
- auth_gap, injection, secret_exposure
- logic_error, scope_issue, off_by_one
- missing_error_handling, swallowed_error
- test_isolation, flaky_test
- spec_drift, undocumented_behavior
- missing_dependency, version_conflict

### severity levels

- **critical**: Data loss, security breach, system down
- **high**: Feature broken, significant performance degradation
- **medium**: Partial functionality, workaround exists
- **low**: Minor inconvenience, cosmetic issue
