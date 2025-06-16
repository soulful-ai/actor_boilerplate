# Claude Actor Boilerplate

A comprehensive boilerplate for creating individual Claude actors (Coder, Marketing, Support). This Nx monorepo template is designed to be used as a git submodule in the PM Claude orchestrator's `packages/` folder.

## File Structure

```
claude-actor/
├── .mcp.json.template     # MCP configuration template
├── .mcp.json             # Generated MCP configuration  
├── .env.example          # Environment variables template
├── CLAUDE.md            # Actor-specific instructions and guidelines
├── project.json         # Root Nx project configuration
├── nx.json              # Nx workspace configuration
├── scripts/             # Automation scripts
│   └── generate-mcp-config.sh
├── apps/                # Nx applications
│   └── mcp/
│       └── cli_use/     # CLI MCP server implementation
├── libs/                # Shared libraries for this actor
├── docs/                # Actor documentation
└── tools/               # Actor-specific tooling
```

## Architecture

```
PM Claude (Orchestrator)
    ↓ (Headless Claude Commands)
Claude Actor (This Repository)
    ↓ (Specialized Implementation)
Target Repository/Service
    ↓ (Changes/Output)
Results → PM Claude → User
```

### Actor Types

This boilerplate can be customized for different Claude actor types:

- **Coder Actor** - Handles coding, testing, implementation, and technical tasks
- **Marketing Actor** - Content creation, campaign management, analytics, and brand strategy
- **Support Actor** - Customer support, documentation, troubleshooting, and user assistance

### Components

- **MCP Server** - Communication interface with PM Claude
- **Nx Monorepo** - Manages actor-specific applications and libraries
- **Dynamic Configuration** - Environment-driven setup
- **Specialized Apps** - Actor-specific implementations in `apps/`
- **Shared Libraries** - Common utilities in `libs/`

## Usage as Boilerplate

### Creating a New Claude Actor

1. **Create from template**:
   ```bash
   # In your orchestrator's packages/ directory
   git submodule add https://github.com/soulful-ai/boilerplate.git my-actor-name
   cd my-actor-name
   ```

2. **Customize for your actor type**:
   ```bash
   # Install dependencies
   npm install
   
   # Update CLAUDE.md with actor-specific instructions
   # Modify apps/ to add actor-specific applications
   # Update .env.example with required variables
   ```

3. **Configure environment**:
   ```bash
   cp .env.example .env
   # Edit .env with your specific paths and configurations
   ```

4. **Generate MCP configuration**:
   ```bash
   nx generate-mcp-config
   ```

### Integration with PM Claude

This actor will be managed as a git submodule in the PM Claude orchestrator:

```
orchestrator/
├── packages/
│   ├── coder-actor/          # This boilerplate customized for coding
│   ├── marketing-actor/      # This boilerplate customized for marketing
│   └── support-actor/        # This boilerplate customized for support
```

## Development

### Nx Commands

```bash
# Build all projects
nx run-many --target=build

# Test specific project
nx test <project-name>

# Lint all projects  
nx run-many --target=lint

# Generate MCP configuration
nx generate-mcp-config
```

### Adding Actor-Specific Applications

```bash
# Generate a new application
nx g @nx/node:application my-actor-app

# Generate a new library
nx g @nx/node:library my-shared-lib
```

## Actor Workflow

1. **PM Delegation** → Receives task from PM Claude via MCP
2. **Task Analysis** → Actor analyzes requirements within its domain
3. **Implementation** → Actor executes specialized functionality
4. **Result Processing** → Actor processes and formats results
5. **Response** → Actor returns results to PM Claude
6. **Integration** → PM Claude integrates results into overall workflow

## Key Features

- **Specialized Focus** - Each actor handles specific domain expertise
- **Modular Architecture** - Nx monorepo for organized development
- **MCP Communication** - Seamless integration with PM Claude orchestrator
- **Dynamic Configuration** - Environment-driven setup and customization
- **Template-Based** - Rapid deployment of new actor types
- **Scalable Structure** - Support for complex actor-specific applications
- **Shared Libraries** - Reusable components across actor projects

## Technical Architecture

### MCP Server Integration
- **Dynamic Port** - Configurable communication endpoint
- **Environment Variables** - User-configurable via `.env` variables
- **Template System** - `.mcp.json.template` with variable substitution
- **Auto-Generation** - Nx command for seamless setup
- **CLI Implementation** - Located in `apps/mcp/cli_use/` with Python/uv setup

### Actor Customization
- **Domain-Specific Apps** - Add applications for your actor's specialty
- **Shared Libraries** - Common utilities in `libs/` folder
- **Custom Tooling** - Actor-specific tools and scripts
- **Flexible Configuration** - Adapt MCP settings for your use case
