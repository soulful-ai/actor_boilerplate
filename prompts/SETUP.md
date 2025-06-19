# [Actor Type] Setup Guide

Quick setup commands for [Actor Type] actor. Max 100 lines.

## Environment Setup

### First Time Setup
```bash
# Clone and enter actor directory
cd packages/[actor-name]

# Auto-detect environment (local vs codespaces)
./scripts/setup-environment.sh

# Install dependencies
npm install
npx nx install

# Copy and configure environment
cp .env.example .env
# Edit .env with your values
```

### Environment Variables
```bash
# Required - Set in .env
ACTOR_NAME=[actor-name]
ACTOR_TYPE=[actor-type]
ACTOR_PORT=900X  # Your assigned port

# Auto-detected by setup script
ACTOR_ROOT=/path/to/packages/[actor-name]
PM_WORKSPACE=/path/to/workspace
SHARED_WORKSPACE=/path/to/.shared-workspace
```

## MCP Server Setup

### Generate MCP Config
```bash
# 1. Ensure environment is configured
source .env

# 2. Generate MCP config for this actor
npx nx run workspace:generate-mcp-config

# 3. Verify .mcp.json was created
ls -la .mcp.json

# 4. Check generated paths are correct
cat .mcp.json | grep -E "(command|args|env)"

# 5. Restart Claude Desktop to pick up changes
```

### MCP Configuration Details
- **Template**: `.mcp.json.template` in actor root
- **Output**: `.mcp.json` in actor directory  
- **Port**: Must match ACTOR_PORT in .env (e.g., 9001)
- **Security**: Inherits from actor's security settings

### Start MCP Server
```bash
# Development mode
npx nx serve

# With environment override
ACTOR_PORT=9005 npx nx serve

# Test mode (bypasses auth)
TEST_MODE=true npx nx serve
```

## Domain-Specific Setup

### [Add your domain setup steps]
```bash
# Example for Coder Actor:
# docker compose up -d  # Start local services
# npx nx seed:db   # Initialize database

# Example for ML Actor:
# docker pull ollama/ollama  # Get ML runtime
# npx nx download:models # Download base models
```

## Verify Setup

### Health Checks
```bash
# Test MCP server
curl http://localhost:900X/health

# Check shared workspace
ls -la $SHARED_WORKSPACE/

# Run tests
npx nx test
```

### Common Issues
- **Port in use**: Change ACTOR_PORT in .env
- **Permission denied**: Check directory ownership
- **Module not found**: Run npm install again

## Next Steps
- Review WORKFLOWS.md for task procedures
- Check TROUBLESHOOTING.md for issues
- Start monitoring tasks from PM Director