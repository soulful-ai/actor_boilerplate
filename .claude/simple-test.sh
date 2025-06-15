#!/bin/bash

# Simple PM-Coder test script

echo "🧪 Testing PM-Coder delegation..."

# Test direct coder command
echo "📤 Delegating to Coder: Create and delete test file"

cd /workspaces/platforma || exit 1

# Run the coder command directly
claude -c -p "Please create a file called 'coder-test.txt' with content 'Hello from Coder!', then immediately delete it. Confirm both operations worked."

echo "✅ Delegation complete"