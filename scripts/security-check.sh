#!/bin/bash
# Security check script
# Run comprehensive security validation

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}🔒 Security Check${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ISSUES=0

# Check for gitleaks
if ! command -v gitleaks &> /dev/null; then
    echo -e "${YELLOW}⚠ Warning: gitleaks not installed${NC}"
    echo "Install: https://github.com/gitleaks/gitleaks"
else
    echo -e "${BLUE}Scanning for secrets...${NC}"
    if [ -f ".gitleaks.toml" ]; then
        if gitleaks detect --config .gitleaks.toml --no-banner 2>&1; then
            echo -e "${GREEN}✓ No secrets detected by gitleaks${NC}"
        else
            echo -e "${RED}✗ Potential secrets detected!${NC}"
            ((ISSUES++))
        fi
    else
        if gitleaks detect --no-banner 2>&1; then
            echo -e "${GREEN}✓ No secrets detected by gitleaks${NC}"
        else
            echo -e "${RED}✗ Potential secrets detected!${NC}"
            ((ISSUES++))
        fi
    fi
fi

echo ""

# Check .env files
echo -e "${BLUE}Checking .env files...${NC}"
if [ -f ".env" ]; then
    if git check-ignore .env 2>/dev/null; then
        echo -e "${GREEN}✓ .env is gitignored${NC}"
    else
        echo -e "${RED}✗ .env is NOT in .gitignore!${NC}"
        ((ISSUES++))
    fi
fi

# Check for sensitive files
echo ""
echo -e "${BLUE}Checking sensitive file patterns...${NC}"
SENSITIVE_FILES=$(find . -type f \( -name "*secret*" -o -name "*credential*" -o -name "*key*.pem" -o -name "*firebase*.json" \) -not -path "./node_modules/*" -not -path "./.git/*" 2>/dev/null | head -5 || true)
if [ -n "$SENSITIVE_FILES" ]; then
    echo -e "${YELLOW}⚠ Suspicious files found:${NC}"
    echo "$SENSITIVE_FILES"
else
    echo -e "${GREEN}✓ No suspicious files found${NC}"
fi

# Check for common secret patterns in code
echo ""
echo -e "${BLUE}Scanning for secret patterns in code...${NC}"
SECRET_PATTERNS=$(grep -r --include="*.ts" --include="*.js" --include="*.py" --include="*.env*" \
    -e "password\s*=\s*['\"][^'\"]+['\"]" \
    -e "api_key\s*=\s*['\"][^'\"]+['\"]" \
    -e "secret\s*=\s*['\"][^'\"]+['\"]" \
    -e "token\s*=\s*['\"][^'\"]+['\"]" \
    . 2>/dev/null | grep -v "node_modules" | grep -v ".env.example" | grep -v "your-" | grep -v "CHANGE_ME" | grep -v "REPLACE_ME" | head -5 || true)

if [ -n "$SECRET_PATTERNS" ]; then
    echo -e "${YELLOW}⚠ Potential hardcoded secrets:${NC}"
    echo "$SECRET_PATTERNS"
    ((ISSUES++))
else
    echo -e "${GREEN}✓ No hardcoded secrets found${NC}"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ISSUES -gt 0 ]; then
    echo -e "${RED}✗ $ISSUES security issue(s) found${NC}"
    echo ""
    echo "Please review and fix before committing."
    exit 1
else
    echo -e "${GREEN}✓ Security check passed${NC}"
fi
