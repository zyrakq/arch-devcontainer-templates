#!/bin/bash

set -e

echo "🔄 Repository cloning script started..."

# Check if REPO_URL is set and not empty
if [ -n "$REPO_URL" ] && [ "$REPO_URL" != "" ]; then
    echo "📥 Repository URL found: $REPO_URL"
    
    # Check if workspace is empty (excluding hidden files)
    if [ -z "$(ls -A "$WORKSPACE_FOLDER" 2>/dev/null | grep -v '^\\.')" ]; then
        echo "📁 Workspace is empty, cloning repository..."
        
        # Clone the repository to a temporary directory first
        echo "🔄 Cloning repository..."
        git clone "$REPO_URL" /tmp/repo-clone
        
        # Move contents to workspace (preserving hidden files)
        echo "📋 Moving files to workspace..."
        mv /tmp/repo-clone/* "$WORKSPACE_FOLDER"/ 2>/dev/null || true
        mv /tmp/repo-clone/.[^.]* "$WORKSPACE_FOLDER"/ 2>/dev/null || true
        
        # Clean up temporary directory
        rm -rf /tmp/repo-clone
        
        # Set proper ownership
        sudo chown -R vscode:vscode "$WORKSPACE_FOLDER"
        
        echo "✅ Repository cloned successfully!"
    else
        echo "📁 Workspace is not empty, skipping repository clone"
        echo "💡 To force clone, clear the workspace first"
    fi
else
    echo "ℹ️  No repository URL provided, skipping clone"
    echo "💡 Set REPO_URL environment variable to clone a repository"
fi

echo "✅ Clone script completed!"
