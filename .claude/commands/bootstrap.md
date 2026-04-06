---
description: Bootstrap a new project from this template — set up dependencies, database, and dev environment
---

Bootstrap this project for first-time development.

## Project Name
$ARGUMENTS

## Steps

1. **Update CLAUDE.md**: Replace `{{PROJECT_NAME}}` with the actual project name

2. **Initialize Node.js workspace** (api-gateway):
   ```bash
   cd services/api-gateway
   npm init -y
   npm install express@5 pino dotenv
   npm install -D typescript @types/node @types/express eslint prettier
   npm install -D @redocly/cli openapi-typescript
   npx tsc --init --strict --outDir dist --rootDir src
   ```

3. **Initialize Python service** (worker-service):
   ```bash
   cd services/worker-service
   uv init
   uv add fastapi uvicorn asyncpg pydantic structlog
   uv add --dev pytest pytest-asyncio ruff mypy
   ```

4. **Set up database tooling**:
   ```bash
   npm install -D node-pg-migrate pg dotenv
   ```

5. **Create Docker Compose** for local dev:
   - PostgreSQL 16 on port 5432
   - API gateway on port 3000
   - Worker service on port 8000

6. **Set up spec tooling**:
   ```bash
   npm install -D @redocly/cli @asyncapi/cli openapi-typescript
   ```

7. **Add npm scripts** to root package.json:
   - `lint`, `test`, `typecheck`
   - `spec:validate`, `spec:generate`
   - `migrate`, `dev`

8. **Make hook scripts executable**:
   ```bash
   chmod +x .claude/hooks/*.sh
   chmod +x scripts/*.sh
   ```

9. **Initialize git** and create initial commit:
   ```bash
   git init
   git add .
   git commit -m "chore: initial project scaffold"
   ```

10. **Verify compound engineering structure**:
    ```bash
    # Ensure all solution category directories exist
    ls docs/solutions/
    # Verify critical patterns file
    cat docs/solutions/patterns/critical-patterns.md
    # Verify brainstorms and todos directories
    ls docs/brainstorms/ todos/
    ```

11. **Report**: Summarize what was set up and suggest:
    - Run `/workflows:brainstorm` to explore what to build
    - Run `/workflows:plan` to create an implementation plan
    - Run `/workflows:work` to start building
    - Run `/workflows:review` before merging
    - Run `/workflows:compound` after fixing problems to capture learnings
