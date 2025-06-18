# Actor Boilerplate - PM Director Actor Template

A comprehensive boilerplate for creating specialized Claude actors within the PM Director orchestration system. This template provides everything needed to quickly create new actors (Coder, Infrastructure, ML, Marketing, Support, etc.) that integrate seamlessly with PM Director.

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
# From PM Director workspace packages/ directory
git clone https://github.com/soulful-ai/boilerplate.git my-actor-name
cd my-actor-name

# Remove boilerplate git history
rm -rf .git
git init

# Create new repository
gh repo create soulful-ai/my-actor-name --private
git remote add origin https://github.com/soulful-ai/my-actor-name.git
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
# Generate MCP configuration
npx nx generate-mcp-config

# Run tests
npx nx test

# Start MCP server
npx nx serve
```

### 4. Add to PM Director

```bash
# From PM Director workspace
cd packages/
git submodule add https://github.com/soulful-ai/my-actor-name.git

# Update PM Director configuration
# - Add to .env
# - Update detect-environment.sh
# - Add to project.json orchestration commands
```

## Architecture

```
PM Director (Port 9000)
    ├── Shared Workspace Communication
    ├── Task Delegation via .shared-workspace/
    └── Actor Management
         ├── Coder Actor (Port 9001)
         ├── Infrastructure Actor (Port 9002)
         ├── ML Actor (Port 9003)
         ├── Marketing Actor (Port 9004)
         └── [Your Actor] (Port 900X)
```

## Key Features

### 1. PM Director Integration
- **Task Reception** - Monitor `.shared-workspace/tasks/` for delegations
- **Progress Reporting** - Real-time updates to `.shared-workspace/responses/`
- **Challenge Escalation** - Immediate blocker communication patterns
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