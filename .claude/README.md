# PM Claude - Master Orchestrator

This is the Project Manager (PM) Claude instance that orchestrates and manages the workspace repositories.

## Architecture Overview

```
User (External Client)
    ↓ (Port 8005 - SSE/MCP)
PM Claude (Master)
    ↓ (Headless Claude Commands)
Coder Claude (Slave)
    ↓ (Implementation)
Pull Request → User
```

## Key Components

### 1. Communication
- **Inbound**: CLI commands via MCP server on port 8005
- **Outbound**: Responses with PR links and summaries
- **Internal**: Headless Claude commands to Coder

### 2. Scripts
- `pm-orchestrator.sh` - Main orchestration logic
- `pm-delegate.sh` - Handles delegation to Coder
- `pm-response.sh` - Manages user responses
- `env-manager.sh` - Environment variable management

### 3. Configuration
- `claude.md` - PM instructions and guidelines
- `.mcp.json` - MCP server configuration
- `settings.json` - Permissions and behavior settings

## Usage

### Starting PM Claude
```bash
cd /workspaces
claude
```

### External Access
Users can connect via:
```bash
# Using the MCP CLI client
mcp-cli connect --host <workspace-url> --port 8005 --token <auth-token>

# Send command
mcp-cli send "Create a new feature for user authentication"
```

### Manual Testing
```bash
# Test delegation
/workspaces/.claude/pm-delegate.sh delegate "Add dark mode toggle to settings"

# Test response
/workspaces/.claude/pm-response.sh success "https://github.com/..." "Added dark mode"
```

## Environment Variables

Create `/workspaces/.env` from `.env.example` and populate:
- `GITHUB_TOKEN` - Required for PR creation
- `CLI_USE_AUTH_TOKEN` - For secure external access
- Additional service tokens as needed

## Workflow

1. **User Request** → PM receives via port 8005
2. **Analysis** → PM checks for clarity and requirements
3. **Delegation** → PM delegates to Coder with context
4. **Iteration** → PM/Coder iterate until solution works
5. **PR Creation** → PM creates PR with changes
6. **Response** → PM sends PR link and summary to user

## Important Notes

- PM never codes directly - always delegates to Coder
- All responses are one-shot (no back-and-forth)
- History preservation is critical (`-c` flag)
- PM has overview access to monitor changes
- Coder handles all implementation details