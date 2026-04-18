# Workflow Learnings

A living document capturing what works and what doesn't in this compound engineering template.
Updated each time we learn something meaningful about the workflow itself.

---

## What Works

### Compound docs as institutional memory
Capturing solutions in `docs/solutions/` with YAML frontmatter makes past fixes findable.
The learnings-researcher agent can surface relevant docs during planning, which means a problem
solved once doesn't need to be re-diagnosed.

### Parallel review agents
Running security-sentinel, performance-oracle, code-simplicity-reviewer, etc. in parallel during
review catches more issues than a single pass and produces structured todos rather than scattered
feedback. The key is each agent staying in its lane — don't let a security agent give UX opinions.

### 80/20 rule: heavy planning, light execution
When the plan is thorough, the work phase is genuinely easy. When planning is rushed, the work
phase expands to fill the gap (and the review phase catches the mess). Investing in plan quality
pays off.

### WWW-Authenticate header for OAuth discovery (MCP-specific)
MCP clients like Claude.ai silently fail to initiate OAuth if the 401 response is missing the
`WWW-Authenticate: Bearer realm="..." resource_metadata="..."` header. This is RFC 6750 — not
optional for any MCP server with OAuth.

### Docker container DNS for inter-service communication
When services run in Docker on the same network, use the container name as the hostname (e.g.,
`charlie-postgres`) not `localhost`. Using `localhost` fails silently because it resolves to the
container's own loopback, not the host.

### PR as an explicit final step
Adding PR as Phase 5 (after Compound) forces the habit: learnings captured before the branch
closes. Without it, compound gets skipped when everyone is eager to merge.

---

## What Doesn't Work

### Skipping compound when the fix was "obvious"
Even simple fixes produce learnings. The ones that felt obvious in the moment are often the
ones that bite again six months later. The bar for "worth documenting" should be: would a new
developer on this project make this mistake?

### Testing through redirecting domains
If a domain redirects (e.g., `charlie.espresso.haus` → `secure.espresso.haus/charlie-mcp`),
test through the final URL, not the redirect source. OAuth flows in particular break silently
when the redirect chain isn't accounted for.

### Sharing credentials across services
Each service should have its own API keys, service accounts, and tokens — even when targeting
the same underlying platform. Reusing atlas-mcp's Firebase API key for charlie-mcp caused
`auth/api-key-not-valid` errors because the client-side web key is project-scoped.

### Application Default Credentials in Docker
`applicationDefault()` (Firebase Admin SDK's ADC) requires GCP credentials mounted into the
container. This works in Cloud Run but not in local Docker. Always use an explicit service account
(`cert(serviceAccount)`) via an env var when deploying to Docker.

### In-memory token storage
OAuth tokens stored in Maps are lost on every container restart, forcing re-authentication.
Persist tokens to the database from the start — retrofitting this later is tedious and the
symptoms (mysterious auth failures after restarts) are confusing to diagnose.

### Closing issues before end-to-end verification
An issue can appear fixed at the server level (health endpoint responds, OAuth endpoints respond)
while still broken at the user level (Google sign-in popup fails). Don't close auth-related issues
until the full flow — including the UI interaction — has been verified.

---

## Open Questions

- Should the `brainstorm` phase be mandatory for all issues, or only for exploratory features?
- How do we prevent `docs/solutions/` from becoming stale as the codebase evolves?
- Should compound step output be linked from the PR description?

---

## Log

| Date | Learning | Category |
|------|----------|----------|
| 2026-04-18 | PR added as explicit Phase 5 after Compound | Workflow |
| 2026-04-18 | WWW-Authenticate header required for MCP OAuth | Integration |
| 2026-04-18 | ADC fails in Docker; use FIREBASE_SERVICE_ACCOUNT_JSON | Deployment |
| 2026-04-18 | In-memory token storage lost on restart; use Postgres | Architecture |
| 2026-04-18 | Test via final URL, not redirect source | Testing |
