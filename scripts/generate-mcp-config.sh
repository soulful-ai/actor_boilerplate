#!/bin/bash

# Generate .mcp.json from template and environment variables

# Check if .env exists
if [[ ! -f .env ]]; then
    echo "Error: .env file not found. Please copy .env.example to .env and configure it."
    exit 1
fi

# Load environment variables
set -a  # automatically export all variables
source .env
set +a  # turn off automatic export

# Check required variables
if [[ -z "$MCP_CLI_DIR" || -z "$ALLOWED_DIR" ]]; then
    echo "Error: MCP_CLI_DIR and ALLOWED_DIR must be set in .env"
    exit 1
fi

# Generate .mcp.json from template
envsubst < .mcp.json.template > .mcp.json

echo "Generated .mcp.json with paths:"
echo "  MCP_CLI_DIR: $MCP_CLI_DIR"
echo "  ALLOWED_DIR: $ALLOWED_DIR"