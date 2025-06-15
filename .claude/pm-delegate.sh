#!/bin/bash

# PM Claude Delegation Script
# This script handles communication from PM to Coder Claude

# Function to delegate task to coder
delegate_to_coder() {
    local task_description="$1"
    local priority="${2:-normal}"
    local roadmap_ref="${3:-}"
    
    echo "🔄 Delegating task to Coder Claude..."
    echo "Task: $task_description"
    echo "Priority: $priority"
    
    # Change to coder's directory
    cd /workspaces/platforma || exit 1
    
    # Construct the prompt with context
    local prompt="Task Assignment from PM:

$task_description

Priority: $priority"
    
    # Add roadmap reference if provided
    if [ -n "$roadmap_ref" ]; then
        prompt="$prompt
Roadmap Reference: $roadmap_ref"
    fi
    
    # Add execution context
    prompt="$prompt

Please implement this task following the conventions in CLAUDE.md. Ensure:
1. Code follows project standards
2. Tests are written/updated
3. Documentation is updated if needed
4. Solution is deployment-ready

Report back with:
- Implementation summary
- Files changed
- Test results
- Any blockers or issues"
    
    # Execute with Claude in headless mode, preserving history
    claude -c -p "$prompt"
}

# Function to review coder's work
review_coder_work() {
    echo "📋 Reviewing coder's implementation..."
    
    # Check git status
    cd /workspaces/platforma || exit 1
    git status --short
    
    # Check for test results
    if [ -f "test-results.txt" ]; then
        echo "Test Results:"
        cat test-results.txt
    fi
    
    # Return to PM directory
    cd /workspaces
}

# Function to create PR
create_pr() {
    local pr_title="$1"
    local pr_body="$2"
    
    echo "🔧 Creating Pull Request..."
    
    cd /workspaces/platforma || exit 1
    
    # Create branch if needed
    local branch_name="pm-task-$(date +%Y%m%d-%H%M%S)"
    git checkout -b "$branch_name"
    
    # Add and commit changes
    git add -A
    git commit -m "$pr_title"
    
    # Push and create PR
    git push -u origin "$branch_name"
    gh pr create --title "$pr_title" --body "$pr_body"
}

# Main execution
case "$1" in
    delegate)
        delegate_to_coder "$2" "$3" "$4"
        ;;
    review)
        review_coder_work
        ;;
    pr)
        create_pr "$2" "$3"
        ;;
    *)
        echo "Usage: $0 {delegate|review|pr} [args...]"
        exit 1
        ;;
esac