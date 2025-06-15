#!/bin/bash

# PM Claude Main Orchestrator
# Handles the complete flow from user request to PR creation

set -e

# Configuration
PM_DIR="/workspaces/.claude"
CODER_DIR="/workspaces/platforma"
MAX_RETRIES=3

# Source helper scripts
source "$PM_DIR/pm-delegate.sh"
source "$PM_DIR/pm-response.sh"
source "$PM_DIR/env-manager.sh"

# Function to process user request
process_user_request() {
    local request="$1"
    local task_id="task-$(date +%s)"
    
    echo "📥 Processing request: $request"
    echo "Task ID: $task_id"
    
    # Step 1: Analyze request for missing information
    if needs_clarification "$request"; then
        local questions=$(generate_clarification_questions "$request")
        send_clarification_request "$questions" "Task ID: $task_id"
        return 1
    fi
    
    # Step 2: Check environment variables
    check_required_env_vars || {
        echo "Missing required environment variables"
        return 1
    }
    
    # Step 3: Delegate to coder
    local retry_count=0
    local success=false
    
    while [ $retry_count -lt $MAX_RETRIES ] && [ "$success" = "false" ]; do
        send_progress_update "Delegating to Coder" $((retry_count + 1)) $MAX_RETRIES
        
        # Delegate task
        delegate_to_coder "$request" "high" "$task_id"
        
        # Wait for coder to complete (simulate with sleep for now)
        sleep 5
        
        # Review work
        if review_coder_work; then
            success=true
        else
            retry_count=$((retry_count + 1))
            echo "Retry $retry_count/$MAX_RETRIES"
        fi
    done
    
    # Step 4: Create PR if successful
    if [ "$success" = "true" ]; then
        local pr_title="feat: $request"
        local pr_body="Automated implementation of user request

Task ID: $task_id
Request: $request

This PR was automatically created by PM Claude after successful implementation and review."
        
        local pr_url=$(create_pr "$pr_title" "$pr_body" | grep -o 'https://github.com/[^ ]*' | head -1)
        
        # Send success response
        local summary=$(format_pr_summary "/tmp/changes.diff")
        send_success_response "$pr_url" "$summary" "$task_id"
    else
        send_failure_response "Failed after $MAX_RETRIES attempts" "$task_id" $retry_count
    fi
}

# Function to check if request needs clarification
needs_clarification() {
    local request="$1"
    
    # Check for vague terms
    if echo "$request" | grep -qiE "(something|stuff|thing|fix|update)" && ! echo "$request" | grep -qiE "(specific|exactly|precise)"; then
        return 0
    fi
    
    # Check if it references undefined items
    if echo "$request" | grep -qiE "(the bug|the issue|the problem)" && ! echo "$request" | grep -qiE "(where|which|what)"; then
        return 0
    fi
    
    return 1
}

# Function to generate clarification questions
generate_clarification_questions() {
    local request="$1"
    
    echo "To better understand your request, please clarify:"
    echo ""
    
    if echo "$request" | grep -qi "fix"; then
        echo "- What specific issue needs to be fixed?"
        echo "- Where is the issue located (file/component)?"
        echo "- What is the expected behavior?"
    fi
    
    if echo "$request" | grep -qi "feature"; then
        echo "- What exactly should this feature do?"
        echo "- Who will use this feature?"
        echo "- Are there any specific requirements or constraints?"
    fi
    
    if echo "$request" | grep -qi "deploy"; then
        echo "- Which environment (staging/production)?"
        echo "- Any specific deployment configuration needed?"
    fi
}

# Function to check required environment variables
check_required_env_vars() {
    local required_vars="GITHUB_TOKEN"
    
    for var in $required_vars; do
        if [ -z "${!var}" ]; then
            echo "Missing required environment variable: $var"
            request_env_var "$var" "Required for GitHub operations"
            return 1
        fi
    done
    
    return 0
}

# Main entry point
if [ $# -eq 0 ]; then
    echo "PM Claude Orchestrator Ready"
    echo "Waiting for user requests via CLI interface on port 8005..."
else
    # Process direct command
    process_user_request "$*"
fi