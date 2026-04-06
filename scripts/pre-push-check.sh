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

# 2. TypeScript type checking (if applicable)
if [ -f "package.json" ] && grep -q "typecheck" package.json; then
  echo ""
  echo "📋 Running TypeScript type check..."
  if npm run typecheck > /dev/null 2>&1; then
    echo -e "${GREEN}✓ TypeScript type check passed${NC}"
  else
    echo -e "${YELLOW}⚠ TypeScript type check failed (blocking for TypeScript projects)${NC}"
    # Only count as failure for api-gateway
    if [ -f "services/api-gateway/package.json" ]; then
      FAILURES=$((FAILURES + 1))
    fi
  fi
fi

# 3. Linting
if [ -f "package.json" ] && grep -q "lint" package.json; then
  echo ""
  echo "📋 Running linter..."
  if npm run lint > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Linting passed${NC}"
  else
    echo -e "${YELLOW}⚠ Linting found issues${NC}"
    echo "  Consider running 'npm run lint' to review"
  fi
fi

# 4. Tests (if configured)
if [ -f "package.json" ] && grep -q "test" package.json; then
  echo ""
  echo "📋 Running tests..."
  if npm run test > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Tests passed${NC}"
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
