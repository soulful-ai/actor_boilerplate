# Actor Boilerplate

A production-ready template for creating specialized AI actors that integrate with director orchestration systems. This boilerplate provides a complete foundation for building domain-specific actors with MCP (Model Context Protocol) support, task management, and proper communication patterns.

## Overview

This boilerplate includes:
- **MCP Server Integration** - Pre-configured CLI server for PM Director communication
- **Nx Monorepo Structure** - Organized apps/, libs/, tools/, docs/ folders
- **Environment Flexibility** - Dual support for local and GitHub Codespaces
- **PM Director Patterns** - Task delegation, progress reporting, challenge escalation
- **Testing Framework** - TEST_MODE authentication bypass for easy testing
- **Git Workflow** - Submodule best practices and PR management
- **Documentation Templates** - Structured prompts/ folder with workflow guides

## Quick Start

### 1. Create New Actor from Boilerplate

```bash
# Clone the boilerplate
git clone https://github.com/soulful-ai/actor_boilerplate my-actor
cd my-actor

# Remove boilerplate git history
rm -rf .git
git init

# Create your repository
gh repo create [your-org]/my-actor --private
git remote add origin https://github.com/[your-org]/my-actor.git
```

### 2. Customize for Your Actor

```bash
# Setup environment (auto-detects local vs codespaces)
./scripts/setup-environment.sh

# Install dependencies
npm install

# Start customizing:
# 1. Update CLAUDE.md with your actor role
# 2. Edit package.json and project.json names
# 3. Configure .env with your actor settings
# 4. Add domain-specific apps to apps/
# 5. Create shared libraries in libs/
```

### 3. Configure and Test

```bash
# Copy and configure environment
cp .env.example .env
# Edit .env with your actor settings (name, type, port)

# Generate MCP configuration
npx nx run workspace:generate-mcp-config

# Run tests
npx nx test

# Start MCP server
npx nx serve
```

See [prompts/SETUP.md](prompts/SETUP.md) for detailed MCP setup instructions.

### 4. Add to Director

```bash
# For flat structure (actors as siblings)
cd ../director
git submodule add https://github.com/[your-org]/my-actor ../my-actor

# For nested structure (packages directory)
# cd director
# git submodule add https://github.com/[your-org]/my-actor packages/my-actor

# Update director configuration
# - Add actor paths to .env
# - Update project.json if needed
```

## Architecture

```
Director (Port 9000)
    ├── Shared Workspace Communication
    ├── Task Delegation via .shared-workspace/
    └── Actor Management
         ├── Actor 1 (Port 9001)
         ├── Actor 2 (Port 9002)
         ├── Actor 3 (Port 9003)
         └── [Your Actor] (Port 900X)
```

## Key Features

### 1. Director Integration
- **Task Reception** - Monitor shared workspace for delegations
- **Progress Reporting** - Real-time status updates
- **Challenge Escalation** - Immediate blocker communication
- **Test Deployment** - Focus on user-testable environments

### 2. Environment Support
- **Auto-Detection** - Scripts detect local vs GitHub Codespaces
- **Flexible Paths** - Environment variables for all paths
- **Shared Workspace** - Automatic setup of communication directories

### 3. Development Tools
- **Nx Commands** - Direct usage with `npx nx`
- **TEST_MODE** - Bypass authentication in tests
- **Port Convention** - 900X series for actor assignments
- **Git Workflow** - Submodule-aware PR process

### 4. Documentation
- **CLAUDE.md** - Comprehensive actor instructions
- **prompts/** - Concise workflow guides (100 lines max)
- **Response Templates** - Structured communication formats

## File Structure

```
actor-boilerplate/
├── CLAUDE.md                 # Actor role and PM integration guide
├── README.md                 # This file - architecture overview
├── package.json             # Node dependencies and nx script
├── project.json             # Nx targets and commands
├── .env.example             # Environment template with examples
├── .mcp.json.template       # MCP config template
├── prompts/                 # Workflow documentation
│   ├── README.md           # Quick reference
│   ├── SETUP.md            # Environment setup
│   ├── WORKFLOWS.md        # Common procedures
│   └── TROUBLESHOOTING.md  # Known issues
├── scripts/                 # Automation scripts
│   ├── setup-environment.sh # Auto-detect environment
│   └── generate-mcp-config.sh
├── apps/                    # Actor applications
│   └── mcp/
│       └── cli_use/        # MCP server implementation
├── libs/                    # Shared libraries
├── tools/                   # Actor-specific tools
└── .github/
    └── workflows/
        └── ci.yaml         # CI with TEST_MODE

```

## Customization Checklist

When creating a new actor from this boilerplate:

- [ ] Clone and rename repository
- [ ] Update `CLAUDE.md` with actor role and specialization
- [ ] Set actor name in `package.json` and `project.json`
- [ ] Assign port number (900X series)
- [ ] Configure `.env.example` with domain variables
- [ ] Add specialized apps to `apps/`
- [ ] Create shared libraries in `libs/`
- [ ] Update prompts documentation
- [ ] Add domain-specific commands to `project.json`
- [ ] Create GitHub repository
- [ ] Configure as PM Director submodule
- [ ] Update PM Director environment files
- [ ] Test MCP communication
- [ ] Verify shared workspace access

## Best Practices

### Communication
- Always acknowledge tasks immediately
- Update progress every 5-10 minutes
- Escalate blockers without delay
- Provide test URLs for validation

### Development
- Stay on main branch for normal work
- Create feature branches for PRs
- Test with TEST_MODE=true
- Document all decisions

### Integration
- Follow port convention (900X)
- Use environment variables
- Maintain clean git history
- Keep documentation current

## Success Example

The Marketing Actor was created using this exact boilerplate process:
1. Cloned boilerplate to `packages/mercatoria`
2. Customized for marketing intelligence role
3. Added marketing-specific apps and tools
4. Configured as git submodule
5. Integrated with PM Director orchestration
6. Successfully handles marketing tasks via delegation

## Support

For issues or questions:
1. Check `prompts/TROUBLESHOOTING.md`
2. Review PM Director documentation
3. Examine existing actors for patterns
4. Escalate to PM Director with details

Remember: This boilerplate provides the foundation. Your actor's unique value comes from the domain-specific functionality you add!