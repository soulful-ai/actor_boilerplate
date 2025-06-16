# PM Claude - Master Orchestrator

Project Manager Claude orchestration workspace for managing and scaling multiple repositories. This is an Nx monorepo that manages Claude actors as git submodules in the `packages/` folder.

## File Structure

```
workspace/
├── .mcp.json.template     # MCP configuration template
├── .mcp.json             # Generated MCP configuration  
├── .env.example          # Environment variables template
├── CLAUDE.md            # PM instructions and guidelines
├── project.json         # Root Nx project configuration
├── nx.json              # Nx workspace configuration
├── scripts/             # Automation scripts
│   └── generate-mcp-config.sh
├── apps/                # Nx applications
│   └── mcp/
│       └── cli_use/     # CLI MCP server implementation
├── packages/            # Git submodules (Claude actors)
├── docs/                # Documentation
└── infra/               # Infrastructure configuration
```

## Architecture

```
User (External Client)
    ↓ (Port 8005 - SSE/MCP)
PM Claude (Master Orchestrator)
    ↓ (Headless Claude Commands)
Coder Claude (Implementation Actors)
    ↓ (Code Changes)
Pull Request → User
```

### Components

- **PM Claude** (Master) - Orchestrates tasks, manages workflows, creates PRs
- **Coder Claude** (Implementation) - Handles coding in individual repositories
- **Nx Monorepo** - Manages multiple projects and shared dependencies
- **Git Submodules** - Claude actors located in `packages/` folder

## Setup

1. Clone with submodules:
   ```bash
   git clone --recursive <repo-url>
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Configure environment from `.env.example`:
   - `PM_HOME` - PM Claude workspace directory
   - `CODER_HOME` - Coder Claude working directory
   - `MCP_CLI_DIR` - Path to MCP CLI server directory
   - `ALLOWED_DIR` - Directory allowed for CLI operations
   
4. Generate MCP configuration:
   ```bash
   # Using Nx command
   nx generate-mcp-config
   
   # Or directly
   ./scripts/generate-mcp-config.sh
   ```

## Usage

### External Commands

Send commands through port 8005:

```bash
claude -c -p "your task description"
```

### Nx Commands

```bash
# Build all projects
nx run-many --target=build

# Test specific project
nx test <project-name>

# Lint all projects  
nx run-many --target=lint
```

## Workflow

1. **User Request** → PM receives via port 8005
2. **Analysis** → PM analyzes requirements and context
3. **Delegation** → PM delegates to appropriate Coder Claude
4. **Implementation** → Coder implements in target repository
5. **Review** → PM reviews and validates solution
6. **PR Creation** → PM creates pull request
7. **Response** → PM sends PR link and summary to user

## Key Features

- **Strategic Management** - PM focuses on orchestration, not implementation
- **Quality Control** - All solutions reviewed before PR creation
- **Scalable Architecture** - Nx monorepo supports multiple projects
- **Modular Actors** - Git submodules enable independent Claude instances
- **Automated Workflows** - End-to-end task delegation and completion
- **Dynamic Configuration** - User-specific MCP settings via environment variables
- **Template-Based Setup** - Reproducible configuration across environments

## Technical Architecture

### MCP Server Integration
- **Port 8005** - SSE/MCP communication endpoint
- **Dynamic Paths** - User-configurable via `.env` variables
- **Template System** - `.mcp.json.template` with variable substitution
- **Auto-Generation** - Nx command for seamless setup
- **CLI Implementation** - Located in `apps/mcp/cli_use/` with Python/uv setup
