#!/bin/bash

# PM Claude Response Handler
# Manages responses back to users after task completion

RESPONSE_LOG="/workspaces/.claude/responses.log"

# Function to send success response
send_success_response() {
    local pr_url="$1"
    local summary="$2"
    local task_id="${3:-unknown}"
    
    local response="✅ Task completed successfully!

PR Created: $pr_url
Summary: $summary

Task ID: $task_id
Timestamp: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
    
    echo "$response"
    echo "---" >> "$RESPONSE_LOG"
    echo "$response" >> "$RESPONSE_LOG"
}

# Function to send failure response
send_failure_response() {
    local error_msg="$1"
    local task_id="${2:-unknown}"
    local retry_count="${3:-0}"
    
    local response="❌ Task failed

Error: $error_msg
Task ID: $task_id
Retry Count: $retry_count

Please provide additional information or adjust requirements if needed."
    
    echo "$response"
    echo "---" >> "$RESPONSE_LOG"
    echo "$response" >> "$RESPONSE_LOG"
}

# Function to send clarification request
send_clarification_request() {
    local questions="$1"
    local context="${2:-}"
    
    local response="❓ Clarification needed before proceeding:

$questions"
    
    if [ -n "$context" ]; then
        response="$response

Context: $context"
    fi
    
    response="$response

Please provide the requested information to continue."
    
    echo "$response"
}

# Function to send progress update
send_progress_update() {
    local status="$1"
    local current_step="$2"
    local total_steps="${3:-unknown}"
    
    local response="⏳ Task in progress...

Status: $status
Current Step: $current_step / $total_steps

This is an automated progress update. Full response will follow upon completion."
    
    echo "$response"
}

# Function to format PR summary
format_pr_summary() {
    local changes_file="$1"
    
    if [ ! -f "$changes_file" ]; then
        echo "No detailed changes available"
        return
    fi
    
    # Extract key information
    local files_changed=$(grep -c "modified:" "$changes_file" 2>/dev/null || echo "0")
    local additions=$(grep -E "^\+" "$changes_file" | wc -l 2>/dev/null || echo "0")
    local deletions=$(grep -E "^\-" "$changes_file" | wc -l 2>/dev/null || echo "0")
    
    echo "Files changed: $files_changed | +$additions -$deletions lines"
}

# Main execution
case "$1" in
    success)
        send_success_response "$2" "$3" "$4"
        ;;
    failure)
        send_failure_response "$2" "$3" "$4"
        ;;
    clarify)
        send_clarification_request "$2" "$3"
        ;;
    progress)
        send_progress_update "$2" "$3" "$4"
        ;;
    format-pr)
        format_pr_summary "$2"
        ;;
    *)
        echo "Usage: $0 {success|failure|clarify|progress|format-pr} [args...]"
        exit 1
        ;;
esac