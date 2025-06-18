#!/bin/bash

# Actor Environment Setup Script
# Sources PM Director's .env configuration

set -e

echo "🔍 Actor Environment Setup"
echo "========================"

# Find PM Director's .env file
# Try common locations based on flat structure
if [[ -f "../pm/.env" ]]; then
    PM_ENV_FILE="../pm/.env"
    echo "✅ Found PM Director's .env at ../pm/.env"
elif [[ -f "../../pm/.env" ]]; then
    PM_ENV_FILE="../../pm/.env"
    echo "✅ Found PM Director's .env at ../../pm/.env"
else
    echo "❌ Error: Cannot find PM Director's .env file"
    echo "Make sure PM Director is set up first with setup-environment.sh"
    exit 1
fi

# Source PM's environment
source "$PM_ENV_FILE"
echo "✅ Sourced PM Director's environment configuration"

# Get actor directory name
ACTOR_DIR=$(basename $(pwd))
export ACTOR_NAME="$ACTOR_DIR"

echo ""
echo "📍 Actor Configuration:"
echo "   ACTOR_NAME: $ACTOR_NAME"
echo "   WORKSPACE_ROOT: $WORKSPACE_ROOT"
echo "   SHARED_WORKSPACE: $SHARED_WORKSPACE_PATH"

# Verify shared workspace exists
if [[ ! -d "$SHARED_WORKSPACE_PATH" ]]; then
    echo ""
    echo "⚠️  Shared workspace not found at: $SHARED_WORKSPACE_PATH"
    echo "   PM Director will create it when needed"
fi

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

echo ""
echo "🎉 Actor environment setup complete!"
echo ""
echo "✅ Configuration sourced from: $PM_ENV_FILE"
echo "✅ No separate .env file needed - actors use PM Director's configuration"
echo ""
echo "🎯 Next steps:"
echo "1. Run: npm install (or yarn install)"
echo "2. Start actor: npx nx serve"
echo ""
echo "💡 To use environment in your shell:"
echo "   source $PM_ENV_FILE"