# Team Planning

Plan engineering team capacity, headcount, and organizational structure.

## Purpose

Strategic workforce planning — not sprint planning, but:
- Team capacity vs upcoming workload
- Headcount needs (justification and timing)
- Organizational structure and reporting lines
- Skill gaps and development plans
- Onboarding and knowledge transfer

## When to Use

- Quarterly planning cycles
- Before major new initiatives
- When team is consistently over/under capacity
- When considering org structure changes
- When preparing headcount requests

## What This Covers

### Capacity Planning
- Current team size and skills
- Upcoming workload (projects, maintenance, support)
- Capacity gaps (too much work, wrong skills)
- Buffer for unplanned work and velocity variance

### Headcount Strategy
- Justification for new roles (business impact)
- Timing (when do they need to start)
- Profile (seniority, skills, domain knowledge)
- Trade-offs: hire vs contract vs redirect vs defer

### Organizational Design
- Reporting structure (who reports to whom)
- Team boundaries (what work belongs where)
- Collaboration patterns (how teams coordinate)
- Decision-making authority

### Risk Assessment
- Single points of dependency (bus factor)
- Knowledge silos and documentation gaps
- On-ramp difficulty for new engineers
- Retention risks (burnout, growth blockers)

## Process

1. **Current state assessment**
   - Team size, roles, and skills matrix
   - Current workload and projects
   - Known pain points and bottlenecks
   - Recent velocity data

2. **Workload analysis**
   - Projects in pipeline (size, skills needed, timeline)
   - Ongoing maintenance and support burden
   - Strategic initiatives vs keeping the lights on
   - Unplanned work buffer (typically 20-30%)

3. **Gap analysis**
   - Where is capacity insufficient?
   - Where are skill mismatches?
   - What's at risk if we don't add capacity?
   - What can we defer, drop, or simplify?

4. **Recommendations**
   - Headcount requests with business justification
   - Org structure changes (if needed)
   - Development plans for existing team
   - Risk mitigation strategies

## Output

Team plan with:
- **Current state** (who we have, what we're doing)
- **Workload forecast** (what's coming, skills needed)
- **Capacity gaps** (where we're short)
- **Recommendations** (hire, redirect, defer, with rationale)
- **Risks** (what happens if we don't act)

## Integration with Workflows

- Use BEFORE committing to major project roadmaps
- Feeds into OKR and Rocks planning
- Separate from `/workflows:plan` (technical execution)
- Results logged to `docs/plans/team/` or Tana calendar

## Example

```
User: /cto:team-planning — Q3 roadmap includes claims modernization, member portal redesign, and 24/7 support coverage

[Review covers:]
- Current team: 12 engineers across 3 domains
- Workload: claims (6 months), portal (4 months), support (ongoing)
- Gap: Need 3 senior engineers to hit timeline, or defer portal
- Risk: Current team has zero buffer for unplanned work
- Recommendation: Hire 2 seniors, defer portal by 1 quarter, build buffer
```

## Notes

- Focus on STRATEGIC capacity, not sprint-level planning
- Consider team health and sustainability (burnout risk)
- Be honest about what the team can realistically deliver
- Over-optimism is a disservice to the team and the business
