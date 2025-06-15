# PM Claude Workspace

Project Manager Claude orchestration workspace for managing and scaling multiple repositories.

## Architecture

- **PM Claude** (Master) - Orchestrates tasks, manages workflows, creates PRs
- **Coder Claude** (Slave) - Implements solutions in individual repositories

## Setup

1. PM Claude runs from `/workspaces` with orchestration scripts
2. Coder Claude operates in nested repositories like `/workspaces/platforma`
3. External users connect via CLI server on port 8005

## Usage

Send commands through port 8005:
```bash
claude -c -p "your task description"
```

PM will delegate to appropriate Coder instances and manage the complete workflow from request to PR.

## Scripts

- `.claude/pm-orchestrator.sh` - Main workflow controller
- `.claude/pm-delegate.sh` - Task delegation
- `.claude/pm-response.sh` - User communication
- `.claude/env-manager.sh` - Environment management