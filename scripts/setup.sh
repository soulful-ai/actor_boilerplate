#!/bin/bash

# Actor Setup Script
# Simple setup for independent actors

set -e

echo "🎭 Actor Setup"
echo "============="

# Get actor name from directory
ACTOR_NAME=$(basename $(pwd))
echo "Actor: $ACTOR_NAME"

# Make scripts executable
chmod +x scripts/*.sh 2>/dev/null || true

# Check if dependencies need installation
if [[ ! -d "node_modules" ]]; then
    echo ""
    echo "📦 Dependencies not installed"
    echo "Run: npm install (or yarn install)"
fi

echo ""
echo "✅ Actor setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Install dependencies if needed"
echo "2. Configure any actor-specific settings"  
echo "3. Start actor: npx nx serve"
echo ""

# Note: Actors are independent and don't require
# environment detection or external configuration