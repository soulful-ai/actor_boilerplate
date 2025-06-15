#!/bin/bash

# Environment Variable Manager for PM Claude
# Handles sharing environment variables between PM and Coder

ENV_FILE="/workspaces/.env"
CODER_ENV_FILE="/workspaces/platforma/.env"

# Function to sync environment variables to coder
sync_env_to_coder() {
    echo "🔄 Syncing environment variables to Coder..."
    
    # Ensure .env exists
    if [ ! -f "$ENV_FILE" ]; then
        echo "⚠️  No .env file found. Creating from template..."
        cp /workspaces/.env.example "$ENV_FILE"
        echo "Please update $ENV_FILE with actual values"
        return 1
    fi
    
    # Copy selected variables to coder
    # Only copy non-sensitive operational variables by default
    grep -E "^(GITHUB_TOKEN|OPENAI_API_KEY|ANTHROPIC_API_KEY|DATABASE_URL|DEPLOY_ENV)" "$ENV_FILE" > "$CODER_ENV_FILE.tmp"
    
    # Merge with existing coder env if exists
    if [ -f "$CODER_ENV_FILE" ]; then
        # Keep coder-specific variables
        grep -v -E "^(GITHUB_TOKEN|OPENAI_API_KEY|ANTHROPIC_API_KEY|DATABASE_URL|DEPLOY_ENV)" "$CODER_ENV_FILE" >> "$CODER_ENV_FILE.tmp"
    fi
    
    # Replace coder env file
    mv "$CODER_ENV_FILE.tmp" "$CODER_ENV_FILE"
    echo "✅ Environment variables synced to Coder"
}

# Function to request env var from user
request_env_var() {
    local var_name="$1"
    local var_description="$2"
    
    echo "🔑 Environment variable needed: $var_name"
    echo "Description: $var_description"
    echo "Please provide this value to PM Claude via the CLI interface"
}

# Function to update env var
update_env_var() {
    local var_name="$1"
    local var_value="$2"
    
    # Ensure .env exists
    if [ ! -f "$ENV_FILE" ]; then
        cp /workspaces/.env.example "$ENV_FILE"
    fi
    
    # Update or add the variable
    if grep -q "^$var_name=" "$ENV_FILE"; then
        # Update existing
        sed -i "s|^$var_name=.*|$var_name=$var_value|" "$ENV_FILE"
    else
        # Add new
        echo "$var_name=$var_value" >> "$ENV_FILE"
    fi
    
    echo "✅ Updated $var_name in environment"
    
    # Auto-sync to coder if it's a shared variable
    if echo "$var_name" | grep -E "(GITHUB_TOKEN|OPENAI_API_KEY|ANTHROPIC_API_KEY|DATABASE_URL|DEPLOY_ENV)"; then
        sync_env_to_coder
    fi
}

# Function to list current env vars (without values for security)
list_env_vars() {
    echo "📋 Current environment variables:"
    if [ -f "$ENV_FILE" ]; then
        grep -E "^[A-Z_]+=" "$ENV_FILE" | cut -d= -f1 | sort
    else
        echo "No .env file found"
    fi
}

# Main execution
case "$1" in
    sync)
        sync_env_to_coder
        ;;
    request)
        request_env_var "$2" "$3"
        ;;
    update)
        update_env_var "$2" "$3"
        ;;
    list)
        list_env_vars
        ;;
    *)
        echo "Usage: $0 {sync|request|update|list} [args...]"
        exit 1
        ;;
esac