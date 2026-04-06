#!/bin/bash
# ============================================================
# setup-project.sh — Bootstrap this template into a new project
# ============================================================
# Usage: Run from the project-template repo root, pointing at
#        the target project directory.
#
#   ./scripts/setup-project.sh /path/to/my-new-project
#
# Copies workflow files without overwriting existing ones.
# For Claude Code users, /bootstrap is preferred.

set -euo pipefail

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${1:-.}"

if [ "$TARGET_DIR" = "." ]; then
  echo "Usage: $0 /path/to/target-project"
  echo ""
  echo "This copies the workflow template files into your project."
  echo "Existing files are never overwritten."
  exit 1
fi

TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo "╔══════════════════════════════════════════════╗"
echo "║  Project Template Setup                      ║"
echo "║  From: $TEMPLATE_DIR"
echo "║  To:   $TARGET_DIR"
echo "╚══════════════════════════════════════════════╝"
echo ""

safe_copy() {
  local src="$1"
  local dest="$2"
  if [ -f "$dest" ]; then
    echo "  ⏭  SKIP (exists): ${dest#$TARGET_DIR/}"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  ✅ CREATED: ${dest#$TARGET_DIR/}"
  fi
}

safe_copy_dir() {
  local src_dir="$1"
  local dest_dir="$2"
  if [ -d "$src_dir" ]; then
    find "$src_dir" -type f | while read -r src_file; do
      local rel="${src_file#$src_dir/}"
      safe_copy "$src_file" "$dest_dir/$rel"
    done
  fi
}

# Core files
echo "📄 Core files..."
safe_copy "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
safe_copy "$TEMPLATE_DIR/.pre-commit-config.yaml" "$TARGET_DIR/.pre-commit-config.yaml"
safe_copy "$TEMPLATE_DIR/docker-compose.yaml" "$TARGET_DIR/docker-compose.yaml"
safe_copy "$TEMPLATE_DIR/package.json" "$TARGET_DIR/package.json"

# Claude Code configuration
echo ""
echo "🤖 Claude Code config..."
safe_copy_dir "$TEMPLATE_DIR/.claude" "$TARGET_DIR/.claude"

# GitHub templates and workflows
echo ""
echo "⚙️  GitHub config..."
safe_copy_dir "$TEMPLATE_DIR/.github" "$TARGET_DIR/.github"

# Docs
echo ""
echo "📚 Documentation..."
safe_copy_dir "$TEMPLATE_DIR/docs" "$TARGET_DIR/docs"

# Specs
echo ""
echo "📋 API Specs..."
safe_copy_dir "$TEMPLATE_DIR/specs" "$TARGET_DIR/specs"

# Scripts
echo ""
echo "🔧 Scripts..."
safe_copy_dir "$TEMPLATE_DIR/scripts" "$TARGET_DIR/scripts"

# Directory structure
echo ""
echo "📁 Directory structure..."
for dir in db/migrations db/seeds services/api-gateway services/worker-service todos; do
  mkdir -p "$TARGET_DIR/$dir"
  echo "  ✅ DIR: $dir/"
done

# Pre-commit
echo ""
echo "🪝 Pre-commit hooks..."
if command -v pre-commit &> /dev/null; then
  cd "$TARGET_DIR" && pre-commit install 2>/dev/null && echo "  ✅ Hooks installed" || echo "  ⚠️  Not a git repo yet — run 'pre-commit install' after git init"
else
  echo "  ⚠️  pre-commit not found. Install: pip install pre-commit && pre-commit install"
fi

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  ✅ Setup complete!                          ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — replace {{PROJECT_NAME}} and update stack details"
echo "  2. Rename test.yml → ci.yml if using the upgraded CI workflow"
echo "  3. Run: pre-commit install"
echo "  4. Open Claude Code and run /workflows:brainstorm to start your first cycle"
echo ""
