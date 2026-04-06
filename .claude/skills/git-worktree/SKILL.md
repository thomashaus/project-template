---
name: git-worktree
description: Use git worktrees for isolated parallel development. Recommended when working on multiple features simultaneously.
---

# Git Worktree Skill

Git worktrees let you have multiple branches checked out simultaneously
in separate directories, without cloning the repo multiple times.

## When to Use

- Working on multiple features in parallel
- Want to keep main branch clean while experimenting
- Need to switch between branches frequently
- Running long tests on one branch while coding on another

## Creating a Worktree

```bash
# Create worktree for a new feature branch
git worktree add ../project-feat-name -b feat/feature-name

# Create worktree from existing branch
git worktree add ../project-feat-name feat/existing-branch
```

## Listing Worktrees

```bash
git worktree list
```

## Removing a Worktree

```bash
# After merging, clean up
git worktree remove ../project-feat-name

# Force remove if branch has uncommitted changes
git worktree remove --force ../project-feat-name
```

## Best Practices

- Name worktree directories descriptively: `../project-feat-auth`
- Always create from latest main: `git fetch origin && git worktree add ../dir -b feat/name origin/main`
- Clean up worktrees after merging PRs
- Each worktree has its own node_modules/venv — run `npm install` or `uv sync` after creating
