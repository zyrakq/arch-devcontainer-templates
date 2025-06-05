#!/bin/bash

set -e

echo "🚀 Setting up container environment..."

# Update package database
echo "📦 Updating package database..."
sudo pacman -Sy --noconfirm

# Install additional packages if needed
# echo "📦 Installing additional packages..."
# sudo pacman -S --noconfirm <package-name>

# Set up Git configuration (if not already configured)
if [ -z "$(git config --global user.name)" ]; then
    echo "🔧 Setting up Git configuration..."
    echo "Please configure Git:"
    echo "git config --global user.name 'Your Name'"
    echo "git config --global user.email 'your.email@example.com'"
fi

# Create workspace directory if it doesn't exist
if [ ! -d "$WORKSPACE_FOLDER" ]; then
    echo "📁 Creating workspace directory..."
    sudo mkdir -p "$WORKSPACE_FOLDER"
    sudo chown vscode:vscode "$WORKSPACE_FOLDER"
fi

echo "✅ Container setup completed!"
