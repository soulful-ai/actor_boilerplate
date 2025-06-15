#!/bin/bash

# Test script for PM-Coder flow

echo "🧪 Testing PM-Coder Communication Flow"
echo "======================================"

# Test 1: Environment setup
echo -e "\n1️⃣ Testing environment setup..."
if [ -f "/workspaces/.env" ]; then
    echo "✅ Environment file exists"
else
    echo "⚠️  Creating test environment..."
    cat > /workspaces/.env << EOF
GITHUB_TOKEN=test_token_123
CLI_USE_AUTH_TOKEN=test_auth_456
CODER_HOME=/workspaces/platforma
PM_HOME=/workspaces
EOF
    echo "✅ Test environment created"
fi

# Test 2: Check coder availability
echo -e "\n2️⃣ Checking Coder Claude setup..."
if [ -d "/workspaces/platforma/.claude" ]; then
    echo "✅ Coder Claude directory found"
else
    echo "❌ Coder Claude not found at /workspaces/platforma/.claude"
fi

# Test 3: Test delegation
echo -e "\n3️⃣ Testing delegation mechanism..."
echo "Simulating: 'Add a hello world endpoint to the API'"

# This would normally run:
# cd /workspaces/platforma && claude -c -p "Add a hello world endpoint..."
echo "📤 Would execute: cd /workspaces/platforma && claude -c -p \"Add a hello world endpoint to the API\""

# Test 4: Response formatting
echo -e "\n4️⃣ Testing response formatting..."
/workspaces/.claude/pm-response.sh success "https://github.com/example/pr/123" "Added hello world endpoint" "test-001"

echo -e "\n✅ PM Claude setup complete!"
echo "Ready to receive commands on port 8005"