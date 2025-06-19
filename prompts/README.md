# Actor Prompts Documentation

Quick reference guides for actor operations. Each file is limited to 100 lines for quick access.

## Available Prompts

### Core Documentation
- **[README.md](README.md)** - This index file listing all prompts
- **[SETUP.md](SETUP.md)** - Environment setup and MCP configuration
- **[WORKFLOWS.md](WORKFLOWS.md)** - Common actor workflows and patterns
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Solutions for common issues

## Quick Start

### 1. Environment Setup
```bash
# Copy and configure environment
cp .env.example .env
vi .env  # Set ACTOR_ROOT and other variables

# Run setup script
./scripts/setup-environment.sh
```

### 2. Generate MCP Configuration
```bash
# Generate .mcp.json from template
npx nx run workspace:generate-mcp-config

# Restart Claude to pick up new configuration
```

### 3. Start Actor
```bash
# Start MCP server on configured port
npx nx serve
```

## Communication with Director

### Monitor Tasks
```bash
# Watch for new tasks from director
watch -n 1 cat ../.shared-workspace/tasks/current-task.md
```

### Update Status
```bash
# Report progress to director
echo "Task 60% complete..." > ../.shared-workspace/responses/status.md
```

### Escalate Challenges
```bash
# Alert director to blockers
cat > ../.shared-workspace/responses/challenge.md << EOF
## CHALLENGE: Missing API Key
**Blocking**: Yes
**Need**: OPENAI_API_KEY environment variable
EOF
```

## Task Response Template

```markdown
## Task Received: [Task Title]

**Status**: In Progress
**Actor**: [Your Actor Type]
**Started**: $(date)

### Understanding:
- [What you understand about the task]

### Approach:
1. [Your planned steps]

### Challenges:
- [Any blockers or dependencies]

**Updates**: Streaming to .shared-workspace/responses/
```

## Best Practices

1. **Acknowledge immediately** - Respond within 30 seconds
2. **Update frequently** - Every 5-10 minutes
3. **Escalate blockers** - Don't wait, alert immediately
4. **Test before completion** - Always provide test links
5. **Document decisions** - Explain technical choices

## Customization

When customizing this boilerplate:
1. Update actor type throughout documentation
2. Add domain-specific prompts
3. Configure appropriate port (900X series)
4. Set up specialized tools
5. Define communication patterns

Remember: Clear communication enables smooth orchestration!