# Git Commit Template

This directory contains a git commit template and installation script for maintaining consistent commit message formatting.

## Template Structure

The commit template includes:
- **Subject line**: Max 50 characters, starts with imperative verb (Add, Fix, Update, etc.)
- **What was done**: Description block with max 72 characters per line
- **Why was this done**: Reasoning block with max 72 characters per line  
- **Issue link**: Reference to related issue/task

## Installation

To install the commit template for your repository:

```bash
./.github/install-commit-template.sh
```

This will configure git to use the template when you run `git commit` (without `-m` flag).

## Usage

After installation:

```bash
# Opens editor with template
git commit

# Quick commits still work
git commit -m "Quick fix"
```

## Uninstall

To remove the commit template:

```bash
git config --unset commit.template
```

## Example Commit

```
Add user authentication middleware

Implement JWT-based authentication for protecting API routes.
Added middleware to verify tokens and extract user information.

Middleware validates tokens, handles expired tokens, and sets
user context for downstream handlers.

Issue: [123](https://github.com/user/repo/issues/123)
