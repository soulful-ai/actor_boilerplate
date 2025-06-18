# [Actor Type] Common Workflows

Step-by-step procedures for [Actor Type] tasks. Max 100 lines.

## Receiving Tasks from PM Director

### 1. Monitor for New Tasks
```bash
# Watch for incoming tasks
watch -n 1 'cat .shared-workspace/tasks/current-task.md 2>/dev/null || echo "No tasks"'

# Or check manually
cat .shared-workspace/tasks/current-task.md
```

### 2. Acknowledge Task
```bash
# Create acknowledgment
cat > .shared-workspace/responses/status.md << EOF
## Task Acknowledged: [Task Title]
**Status**: Starting
**Actor**: [Actor Type]
**Time**: $(date)

Analyzing requirements...
EOF
```

### 3. Implement Solution
```bash
# Your domain-specific implementation
# Update status as you work

echo "**Progress**: 25% - Setting up environment" >> .shared-workspace/responses/status.md
# ... do work ...

echo "**Progress**: 50% - Implementing core logic" >> .shared-workspace/responses/status.md
# ... do work ...

echo "**Progress**: 75% - Running tests" >> .shared-workspace/responses/status.md
# ... do work ...
```

### 4. Deploy Test Environment
```bash
# Deploy to test environment
npx nx deploy:test

# Update with test URL
cat >> .shared-workspace/responses/status.md << EOF

## Test Environment Ready
**URL**: https://test-[feature].example.com
**Status**: Deployed successfully
**Ready for**: User validation
EOF
```

### 5. Complete Task
```bash
# Final status update
cat > .shared-workspace/responses/status.md << EOF
## Task Completed: [Task Title]
**Status**: Complete
**Test URL**: https://test-[feature].example.com
**Documentation**: Updated in /docs/

### Summary:
- Implemented [feature]
- All tests passing
- Deployed to test environment
- Ready for user validation

### Next Steps:
- User validates test environment
- PM Director handles production deployment
EOF
```

## Challenge Escalation

### When Blocked
```bash
# Create challenge file
cat > .shared-workspace/responses/challenge.md << EOF
## CHALLENGE: [Blocker Title]

**Severity**: High
**Blocking**: Yes
**Need**: [Specific requirement]

### Details:
[Clear explanation of the issue]

### Attempted:
- [What you tried]

### Options:
1. [Possible solution 1]
2. [Possible solution 2]

**Waiting for**: PM Director/User input
EOF
```

## Domain-Specific Workflows

### [Add your domain workflows]
```bash
# Example for Coder Actor:
# Frontend deployment workflow
# npx nx build:frontend
# npx nx test:e2e
# npx nx deploy:preview

# Example for ML Actor:
# Model training workflow
# npx nx prepare:dataset
# npx nx train:model
# npx nx evaluate:metrics
```

## Best Practices
1. **Update status every 5-10 minutes**
2. **Include test URLs in all deployments**
3. **Document decisions in responses**
4. **Escalate immediately when blocked**
5. **Clear communication over speed**