#!/bin/bash

# Actor Environment Setup Script
# Detects environment (local vs GitHub Codespaces) and configures paths

set -e

echo "🔍 Detecting environment..."

# Detect if we're in GitHub Codespaces
if [ -n "$CODESPACES" ]; then
    echo "📍 GitHub Codespaces environment detected"
    WORKSPACE_BASE="/workspaces"
else
    echo "📍 Local development environment detected"
    WORKSPACE_BASE="/Users/$USER/Workspace"
fi

# Get actor directory name from current path
ACTOR_DIR=$(basename $(pwd))

# Set paths based on environment
export ACTOR_ROOT=$(pwd)
export PM_WORKSPACE=$(dirname $(dirname $ACTOR_ROOT))
export SHARED_WORKSPACE="$PM_WORKSPACE/.shared-workspace"

# Create .env.detected file
cat > .env.detected << EOF
# Auto-detected environment variables
# Generated on: $(date)
# Environment: $([ -n "$CODESPACES" ] && echo "GitHub Codespaces" || echo "Local Development")

export ACTOR_ROOT="$ACTOR_ROOT"
export PM_WORKSPACE="$PM_WORKSPACE"
export SHARED_WORKSPACE="$SHARED_WORKSPACE"
export MCP_CLI_DIR="$ACTOR_ROOT/apps/mcp/cli_use"
export ALLOWED_DIR="$ACTOR_ROOT"

# Actor-specific paths
export ACTOR_NAME="$ACTOR_DIR"
EOF

echo "✅ Environment detected and configured:"
echo "   ACTOR_ROOT: $ACTOR_ROOT"
echo "   PM_WORKSPACE: $PM_WORKSPACE"
echo "   SHARED_WORKSPACE: $SHARED_WORKSPACE"

# Create shared workspace structure if it doesn't exist
if [ ! -d "$SHARED_WORKSPACE" ]; then
    echo "📁 Creating shared workspace structure..."
    mkdir -p "$SHARED_WORKSPACE"/{tasks,responses,context,logs}
    echo "✅ Shared workspace created"
fi

# Check if .env exists, if not copy from example
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        echo "📝 Creating .env from .env.example..."
        cp .env.example .env
        # Update paths in .env with detected values
        if [ "$(uname)" = "Darwin" ]; then
            # macOS
            sed -i '' "s|ACTOR_ROOT=.*|ACTOR_ROOT=$ACTOR_ROOT|" .env
            sed -i '' "s|PM_WORKSPACE=.*|PM_WORKSPACE=$PM_WORKSPACE|" .env
            sed -i '' "s|SHARED_WORKSPACE=.*|SHARED_WORKSPACE=$SHARED_WORKSPACE|" .env
        else
            # Linux
            sed -i "s|ACTOR_ROOT=.*|ACTOR_ROOT=$ACTOR_ROOT|" .env
            sed -i "s|PM_WORKSPACE=.*|PM_WORKSPACE=$PM_WORKSPACE|" .env
            sed -i "s|SHARED_WORKSPACE=.*|SHARED_WORKSPACE=$SHARED_WORKSPACE|" .env
        fi
        echo "✅ .env file created with detected paths"
        echo "⚠️  Please edit .env to add your actor-specific configuration"
    else
        echo "⚠️  No .env.example found, please create .env manually"
    fi
fi

echo ""
echo "🎯 Next steps:"
echo "1. Source the environment: source .env.detected"
echo "2. Edit .env to configure actor-specific settings"
echo "3. Run: npm install"
echo "4. Run: npm run nx serve"

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

echo ""
echo "✨ Environment setup complete!"