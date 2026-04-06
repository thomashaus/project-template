# Security Review

Perform a comprehensive security review of the codebase.

## What This Does

- Scans for exposed credentials, API keys, tokens, and secrets
- Validates .gitignore includes sensitive files
- Checks environment variable usage (no hardcoded secrets)
- Runs gitleaks security scan
- Reviews authentication and authorization patterns
- Identifies potential injection vulnerabilities (SQL, XSS, command injection)
- Checks for insecure dependencies

## Usage

Invoke this skill before committing code, especially when:
- Adding new API integrations
- Modifying authentication logic
- Working with environment variables
- Setting up external service connections

## Process

1. **Credential Scan**
   - Run: `gitleaks detect --no-banner --source .`
   - Check for false positives in .env.example, docs, test files
   - Verify no real credentials in committed code

2. **File Safety Check**
   - Ensure `.env.local` is in .gitignore
   - Check for files with "secret", "credential", "password" in names
   - Verify no `.env` files with real values

3. **Code Review**
   - Look for hardcoded API keys, tokens, passwords
   - Validate environment variables are used: `process.env.VAR_NAME`
   - Check for secrets in logs or error messages
   - Review database queries for SQL injection risks
   - Check user input validation for XSS vulnerabilities

4. **Dependency Check**
   - Review `package.json` for vulnerable dependencies
   - Check requirements.txt for outdated Python packages
   - Run: `npm audit` or `uv pip check`

## Output

Report findings with:
- Severity (Critical/High/Medium/Low)
- File locations and line numbers
- Remediation steps
- False positive notes (if any)

## Remediation

If issues found:
1. **Rotate exposed credentials** immediately
2. **Remove secrets** from code
3. **Add to .gitignore** if file should be excluded
4. **Add pattern** to gitleaks allowlist if safe (document why)
5. **Re-scan** after fixes

## References

- CLAUDE.md Security Rules section
- `.gitleaks/config.toml` for pattern definitions
- `.claude/hooks/pre-tool-use.mjs` for automated blocking
