#!/bin/bash
# shellcheck disable=SC2164
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

# Resolve to absolute path and validate
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# Path validation: prevent path traversal attacks
# Target must be within user's home directory or /tmp
ALLOWED_PARENTS=("$HOME" "/tmp" "/Users")
IS_ALLOWED=0
for parent in "${ALLOWED_PARENTS[@]}"; do
  case "$TARGET_DIR" in
    "$parent"*)
      IS_ALLOWED=1
      break
      ;;
  esac
done

if [ "$IS_ALLOWED" -eq 0 ]; then
  echo "Error: Target directory must be within home directory or /tmp"
  echo "Got: $TARGET_DIR"
  exit 1
fi

# Check for path traversal attempts
if [[ "$TARGET_DIR" == *".."* ]]; then
  echo "Error: Target directory cannot contain '..' components"
  exit 1
fi

echo "==================================="
echo "  Project Template Setup"
echo "  From: $TEMPLATE_DIR"
echo "  To:   $TARGET_DIR"
echo "==================================="
echo ""

# Simple copy function - skip if exists
copy_if_missing() {
  local src="$1"
  local dest="$2"
  if [ -f "$dest" ]; then
    echo "  SKIP (exists): ${dest#$TARGET_DIR/}"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  CREATED: ${dest#$TARGET_DIR/}"
  fi
}

# Copy directory recursively, skipping existing files
copy_dir_if_missing() {
  local src_dir="$1"
  local dest_dir="$2"
  if [ -d "$src_dir" ]; then
    # Use find with -print0 and read -d '' for safe handling of filenames
    while IFS= read -r -d '' src_file; do
      local rel="${src_file#$src_dir/}"
      copy_if_missing "$src_file" "$dest_dir/$rel"
    done < <(find "$src_dir" -type f -print0)
  fi
}

# Core files
echo "Core files..."
copy_if_missing "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
copy_if_missing "$TEMPLATE_DIR/.pre-commit-config.yaml" "$TARGET_DIR/.pre-commit-config.yaml"
copy_if_missing "$TEMPLATE_DIR/docker-compose.yaml" "$TARGET_DIR/docker-compose.yaml"
copy_if_missing "$TEMPLATE_DIR/package.json" "$TARGET_DIR/package.json"

# Claude Code configuration
echo ""
echo "Claude Code config..."
copy_dir_if_missing "$TEMPLATE_DIR/.claude" "$TARGET_DIR/.claude"

# GitHub templates and workflows
echo ""
echo "GitHub config..."
copy_dir_if_missing "$TEMPLATE_DIR/.github" "$TARGET_DIR/.github"

# Docs
echo ""
echo "Documentation..."
copy_dir_if_missing "$TEMPLATE_DIR/docs" "$TARGET_DIR/docs"

# Specs
echo ""
echo "API Specs..."
copy_dir_if_missing "$TEMPLATE_DIR/specs" "$TARGET_DIR/specs"

# Scripts
echo ""
echo "Scripts..."
copy_dir_if_missing "$TEMPLATE_DIR/scripts" "$TARGET_DIR/scripts"

# Directory structure
echo ""
echo "Directory structure..."
for dir in db/migrations db/seeds services/api-gateway services/worker-service todos; do
  mkdir -p "$TARGET_DIR/$dir"
  echo "  DIR: $dir/"
done

# Pre-commit - auto-install if git repo
echo ""
echo "Pre-commit hooks..."
if [ -d "$TARGET_DIR/.git" ]; then
  cd "$TARGET_DIR"
  if command -v pre-commit &> /dev/null; then
    pre-commit install && echo "  Hooks installed automatically" || echo "  Warning: pre-commit install failed"
  else
    echo "  pre-commit not found. Install: pip install pre-commit"
  fi
else
  echo "  Not a git repo yet - run 'pre-commit install' after git init"
fi

echo ""
echo "==================================="
echo "  Setup complete!"
echo "==================================="
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md - replace {{PROJECT_NAME}} and update stack details"
echo "  2. Run: pre-commit install"
echo "  3. Open Claude Code and run /workflows:brainstorm to start your first cycle"
echo ""
