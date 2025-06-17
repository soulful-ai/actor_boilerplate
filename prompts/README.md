# [Actor Type] Actor Prompts

Quick reference for common [Actor Type] workflows and commands. Max 100 lines per file.

## Quick Reference

### Start Actor
```bash
# From actor root directory
npm run nx setup-environment  # First time setup
npm run nx serve             # Start MCP server on port 900X
```

### PM Director Communication
```bash
# Monitor for tasks
watch -n 1 cat .shared-workspace/tasks/current-task.md

# Update status
echo "Task received, starting implementation..." > .shared-workspace/responses/status.md
```

### Common Operations
```bash
# [Add your actor-specific common commands]
# Example for Coder Actor:
# npm run nx build:frontend
# npm run nx test:integration
# npm run nx deploy:staging

# Example for Marketing Actor:
# npm run nx analyze:competitors
# npm run nx generate:campaign
# npm run nx export:analytics
```

## Task Response Template

When receiving a task from PM Director:

```markdown
## Task Received: [Task Title]

**Status**: In Progress
**Actor**: [Actor Type]
**Started**: [timestamp]

### Understanding:
- [What you understand about the task]

### Approach:
1. [Your planned steps]

### Challenges:
- [Any blockers or dependencies]

**Updates**: Will stream to .shared-workspace/responses/
```

## Challenge Escalation Template

For immediate PM Director attention:

```markdown
## CHALLENGE: [Issue]

**Severity**: High
**Blocking**: Yes

### Issue:
[Clear description]

### Need:
[What you need from PM Director/User]

### Impact:
[What's blocked without resolution]
```

## Available Documentation

- **SETUP.md** - Environment and dependency setup procedures
- **WORKFLOWS.md** - Step-by-step guides for common tasks
- **TROUBLESHOOTING.md** - Solutions for known issues
- **[DOMAIN].md** - Domain-specific procedures

## Best Practices

1. **Always acknowledge tasks** immediately
2. **Update status frequently** (every 5-10 minutes)
3. **Escalate blockers immediately** don't wait
4. **Provide test links** when deploying
5. **Document decisions** in responses

Remember: Clear communication with PM Director ensures smooth orchestration.