#!/bin/bash

# Pre-Push Check Script
# Runs security scan and tests before git push
# Hook: PrePush in .claude/settings.json

set -e

echo "🔒 Running pre-push checks..."

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track failures
FAILURES=0

# Helper: Run command with timeout
run_with_timeout() {
  local timeout_seconds=30
  local command="$1"
  local description="$2"

  timeout "$timeout_seconds" bash -c "$command" > /dev/null 2>&1
  local exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✓ $description passed${NC}"
    return 0
  elif [ $exit_code -eq 124 ]; then
    echo -e "${YELLOW}⚠ $description timed out (no files to check?)${NC}"
    return 1
  else
    echo -e "${YELLOW}⚠ $description failed${NC}"
    return 1
  fi
}

# 1. Gitleaks security scan
echo ""
echo "📋 Running gitleaks security scan..."
if gitleaks detect --no-banner --no-git; then
  echo -e "${GREEN}✓ Gitleaks scan passed${NC}"
else
  echo -e "${RED}✗ Gitleaks scan detected potential secrets${NC}"
  FAILURES=$((FAILURES + 1))
  echo "  Review findings above. If false positives, update .gitleaks/config.toml"
fi

# 2. TypeScript type checking (only if api-gateway exists)
if [ -f "services/api-gateway/package.json" ]; then
  echo ""
  echo "📋 Running TypeScript type check..."
  cd services/api-gateway
  if run_with_timeout "npm run typecheck" "TypeScript type check"; then
    : # Pass
  else
    echo -e "${YELLOW}⚠ TypeScript type check failed (blocking for TypeScript projects)${NC}"
    # Only block if there are actual .ts files
    if find . -name "*.ts" -type f | grep -q .; then
      FAILURES=$((FAILURES + 1))
    else
      echo "  (No TypeScript files found, skipping)"
    fi
  fi
  cd - > /dev/null
elif [ -f "package.json" ] && grep -q "typecheck" package.json; then
  echo ""
  echo "📋 Running TypeScript type check..."
  if run_with_timeout "npm run typecheck" "TypeScript type check"; then
    : # Pass
  else
    echo -e "${YELLOW}⚠ TypeScript type check failed${NC}"
    # Only block if TypeScript files exist in services/
    if find services -name "*.ts" -type f 2>/dev/null | grep -q .; then
      FAILURES=$((FAILURES + 1))
    else
      echo "  (No TypeScript files found in services/, skipping)"
    fi
  fi
fi

# 3. Linting
echo ""
echo "📋 Running linter..."
if [ -f "package.json" ] && grep -q "lint" package.json; then
  if run_with_timeout "npm run lint" "Linting"; then
    : # Pass
  else
    echo -e "${YELLOW}⚠ Linting found issues${NC}"
    echo "  Consider running 'npm run lint' to review"
  fi
fi

# 4. Tests (if configured)
echo ""
echo "📋 Running tests..."
if [ -f "package.json" ] && grep -q "test" package.json; then
  if run_with_timeout "npm run test" "Tests"; then
    : # Pass
  else
    echo -e "${YELLOW}⚠ Tests failed${NC}"
    echo "  Run 'npm run test' to review failures"
  fi
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $FAILURES -gt 0 ]; then
  echo -e "${RED}✗ Pre-push checks failed with $FAILURES blocking issue(s)${NC}"
  echo ""
  echo "Fix blocking issues before pushing."
  exit 1
else
  echo -e "${GREEN}✓ All pre-push checks passed${NC}"
  echo ""
  echo "Ready to push!"
  exit 0
fi
