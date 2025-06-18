# [Actor Type] Troubleshooting Guide

Common issues and solutions for [Actor Type] actor. Max 100 lines.

## MCP Server Issues

### Server Won't Start
```bash
# Check port availability
lsof -i :900X

# Kill existing process
kill -9 $(lsof -t -i:900X)

# Try different port
ACTOR_PORT=9006 npx nx serve
```

### Connection Refused
```bash
# Verify environment variables
env | grep -E "(ACTOR|MCP|ALLOWED)"

# Check server logs
npx nx serve --verbose

# Test with curl
curl -v http://localhost:900X/health
```

## Shared Workspace Issues

### Permission Denied
```bash
# Fix permissions
chmod -R 755 .shared-workspace/
chmod -R 755 $SHARED_WORKSPACE/

# Verify paths
echo "Actor: $ACTOR_ROOT"
echo "PM: $PM_WORKSPACE"
echo "Shared: $SHARED_WORKSPACE"
```

### Tasks Not Appearing
```bash
# Check workspace structure
find .shared-workspace -type f -name "*.md"

# Monitor directory changes
fswatch -r .shared-workspace/tasks/

# Verify PM Director connection
ls -la $PM_WORKSPACE/.shared-workspace/
```

## Environment Issues

### Missing Dependencies
```bash
# Reinstall all dependencies
rm -rf node_modules package-lock.json
npm install

# Check for missing packages
npm ls

# Update nx
npm update nx
```

### Path Resolution Errors
```bash
# Re-run environment setup
./scripts/setup-environment.sh

# Source detected environment
source .env.detected

# Manually set if needed
export ACTOR_ROOT=$(pwd)
export PM_WORKSPACE=$(dirname $(dirname $ACTOR_ROOT))
```

## Domain-Specific Issues

### [Add domain-specific troubleshooting]
```bash
# Example for Coder Actor:
# Build failures
# npx nx reset
# npx nx build --skip-cache

# Example for ML Actor:
# GPU not detected
# nvidia-smi
# docker run --gpus all nvidia/cuda:11.0-base nvidia-smi
```

## Testing Issues

### Tests Failing
```bash
# Run with TEST_MODE
TEST_MODE=true npx nx test

# Run specific test
TEST_MODE=true npx nx test -- --testNamePattern="test_name"

# Debug mode
TEST_MODE=true DEBUG=* npx nx test
```

## Quick Diagnostics

### Health Check Script
```bash
# Create diagnostic script
cat > diagnose.sh << 'EOF'
#!/bin/bash
echo "=== Actor Diagnostics ==="
echo "Actor Root: $ACTOR_ROOT"
echo "PM Workspace: $PM_WORKSPACE"
echo "Port: $ACTOR_PORT"
echo ""
echo "=== Checking Services ==="
curl -s http://localhost:$ACTOR_PORT/health || echo "MCP server not responding"
echo ""
echo "=== Workspace Structure ==="
find .shared-workspace -type d | head -10
EOF

chmod +x diagnose.sh
./diagnose.sh
```

## Getting Help
1. Check PM Director logs
2. Review .shared-workspace/logs/
3. Escalate to PM Director with details
4. Include diagnostic output in reports