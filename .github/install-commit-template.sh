#!/bin/bash

# Install commit template for git
# This script sets up the commit template for the current repository

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_PATH="$SCRIPT_DIR/commit-template.txt"

# Check if template file exists
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "Error: Template file not found at $TEMPLATE_PATH"
    exit 1
fi

# Install template for current repository
echo "Installing commit template..."
git config commit.template "$TEMPLATE_PATH"

if [ $? -eq 0 ]; then
    echo "✅ commit template installed successfully!"
    echo "📝 Template location: $TEMPLATE_PATH"
    echo ""
    echo "Usage:"
    echo "  git commit    # Opens editor with template"
    echo "  git commit -m # Still works for quick commits"
    echo ""
    echo "To uninstall:"
    echo "  git config --unset commit.template"
else
    echo "❌ Failed to install commit template"
    exit 1
fi
