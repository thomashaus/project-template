# Technical Debt Assessment

Assess, prioritize, and create remediation plans for technical debt.

## Purpose

Strategic technical debt management — not cataloging every issue, but:
- Understanding debt landscape and categories
- Assessing risk and urgency
- Prioritizing what to fix vs what to accept
- Balancing new features with debt paydown
- Communicating trade-offs to stakeholders

## When to Use

- Quarterly debt review cycles
- Before major initiatives (is debt blocking us?)
- When velocity is consistently slowing
- When considering refactors vs new features
- When preparing migration or modernization plans

## What This Covers

### Debt Categories
- **Code-level**: Complex functions, duplication, poor naming
- **Architectural**: Tight coupling, unclear boundaries, missing abstractions
- **Infrastructure**: Outdated dependencies, security patches, performance
- **Process**: Missing tests, poor docs, manual deployments
- **Knowledge**: Siloed expertise, missing documentation

### Risk Assessment
- **Impact**: How much does this slow us down or create risk?
- **Urgency**: Is this getting worse? Blocking other work?
- **Cost**: How much effort to fix? What's the ROI?
- **Dependencies**: Does fixing this enable other work?

### Prioritization Framework
- **P0 — Fix now**: Security, data loss, blocking critical work
- **P1 — Fix soon**: High friction, performance, scalability blockers
- **P2 — Fix later**: Code quality, maintainability, efficiency
- **P3 — Accept**: Low impact, disproportionate cost to fix

## Process

1. **Debt inventory**
   - Review codebase metrics (complexity, duplication, coverage)
   - Gather team input (what frustrates them daily?)
   - Review past incidents and postmortems
   - Check dependency security alerts and deprecations

2. **Categorization and assessment**
   - Group debt by type and system
   - Assess impact and urgency for each item
   - Estimate remediation effort
   - Identify dependencies and compounding effects

3. **Prioritization**
   - Apply P0/P1/P2/P3 framework
   - Consider quick wins vs strategic bets
   - Balance debt paydown with feature velocity
   - Identify what's acceptable to live with

4. **Remediation planning**
   - Timeline and sequencing (what first?)
   - Resource allocation (who works on this?)
   - Integration with feature work (piggyback or dedicated?)
   - Success metrics (how do we know it's better?)

## Output

Debt assessment with:
- **Inventory** (what we have, by category and system)
- **Prioritized list** (P0/P1/P2/P3 with rationale)
- **Remediation plan** (what to fix when, with effort estimates)
- **Trade-offs** (what we're accepting and why)
- **Metrics** (how to track progress)

## Integration with Workflows

- Use BEFORE quarterly planning to allocate debt paydown capacity
- Feed findings into `/workflows:plan` for specific fix projects
- Track progress in `docs/solutions/technical-debt/`
- Review quarterly with team and stakeholders

## Example

```
User: /cto:tech-debt-assessment — claims processing service has high complexity, low test coverage, and outdated FastAPI version

[Assessment covers:]
- Code complexity: Cyclomatic complexity > 20 in 15 functions (P1)
- Test coverage: 35% coverage, critical paths untested (P0 — data safety)
- Dependencies: FastAPI 0.85 → current 0.104 (P1 — security and performance)
- Architecture: Tight coupling to database schema (P2)
- Recommendation: Fix tests first (P0), upgrade FastAPI (P1), refactor complex functions (P1), accept coupling for now (P3)
- Effort: 2 weeks dedicated + piggyback on feature work
- ROI: Reduce incidents by 60%, enable faster feature development
```

## Notes

- Not all debt needs to be paid off — some is acceptable
- Focus on debt that materially impacts velocity or risk
- Quick wins build momentum and credibility
- Be transparent about trade-offs (accepting debt is a strategic decision)
- Involve the team — they know what's painful
