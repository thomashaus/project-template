#!/bin/bash
# Setup script for new projects
# Copies git hooks and configures the repository

set -e

echo "🛠️  Setting up project template..."
echo ""

# Install git hooks
echo "📦 Installing git hooks..."
if [ -d ".hooks" ]; then
    cp .hooks/* .git/hooks/ 2>/dev/null || mkdir -p .git/hooks && cp .hooks/* .git/hooks/
    chmod +x .git/hooks/*
    echo "✓ Git hooks installed"
else
    echo "⚠ No .hooks directory found"
fi

# Check for required files
echo ""
echo "🔍 Checking required files..."
REQUIRED_FILES=("CLAUDE.md" ".gitignore" ".gitleaks.toml" ".github/pull_request_template.md")
MISSING=0

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file exists"
    else
        echo "✗ $file missing"
        ((MISSING++))
    fi
done

# Check for .env.example
if [ ! -f ".env.example" ]; then
    echo ""
    echo "💡 Tip: Create .env.example to document required environment variables"
fi

# Summary
echo ""
if [ $MISSING -gt 0 ]; then
    echo "⚠ $MISSING file(s) missing"
else
    echo "✓ All required files present"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Review and customize CLAUDE.md for your project"
echo "  2. Add .env and .env.example with your environment variables"
echo "  3. Update package.json with your dependencies"
echo "  4. Start coding! 🚀"
