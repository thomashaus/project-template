# Architecture Review

Conduct a strategic architecture review for a system, service, or initiative.

## Purpose

Evaluate architectural decisions from a CTO/VP perspective — not implementation details, but:
- System boundaries and service responsibilities
- Integration patterns and coupling risks
- Scalability and sustainability
- Trade-offs between speed and robustness
- Alignment with business goals
- Technical debt implications

## When to Use

- Before starting major new initiatives
- When evaluating vendor solutions vs build vs buy
- When system complexity is growing (alert moment)
- When considering refactors or migrations
- When service boundaries feel unclear

## What This Reviews

### System Design
- Service boundaries and responsibilities
- Data flow and integration patterns
- Synchronous vs asynchronous communication
- State management strategy
- Failure modes and resilience

### Scalability
- Current bottlenecks
- Growth projections (1-2 years)
- Cost vs complexity trade-offs
- When to scale vertically vs horizontally

### Maintainability
- Coupling and cohesion
- Team cognitive load
- On-ramp difficulty for new engineers
- Testing and observability strategy

### Risk Assessment
- Single points of failure
- Vendor lock-in
- Migration difficulty
- Team dependency risks

## Process

1. **Context gathering**
   - Review current architecture diagrams
   - Understand business requirements
   - Identify stakeholder concerns
   - Review past decisions (git history, docs)

2. **Evaluation**
   - Assess against architectural principles
   - Identify coupling and complexity risks
   - Evaluate scalability projections
   - Check alignment with tech stack direction

3. **Recommendations**
   - What's working well (keep doing)
   - What needs attention (soon vs later)
   - What's at risk (mitigate now)
   - Strategic questions to resolve

## Output

Structured review with:
- **Executive summary** (3-5 bullets)
- **Current state** (what we have)
- **Concerns** (what's risky)
- **Recommendations** (what to do, in priority order)
- **Open questions** (what needs more info)

## Integration with Workflows

- Use BEFORE `/workflows:plan` for major initiatives
- Separate from `/workflows:review` (which focuses on code quality)
- Complements Athena (personal chief of staff) by focusing on technical strategy
- Results feed into `docs/solutions/architecture/`

## Example

```
User: /cto:architecture-review — we're considering adding a message queue for claims processing

[Review focuses on:]
- Service boundary: Should claims processing be its own service?
- Coupling risk: Does this create tight dependency on queue infrastructure?
- Scalability: Current volume vs projected growth
- Team impact: Who owns this? What's the on-call burden?
- Alternatives: Database polling, event sourcing, keep it simple
```

## Notes

- This is STRATEGIC review, not implementation planning
- Don't get into code details — that's for `/workflows:plan`
- Focus on decisions that affect 6-12 month trajectory
- Consider team health and sustainability, not just technology
