#!/usr/bin/env sh
set -e

# Install root dependencies
npm install

# Install uv Python package manager
if ! command -v uv &> /dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Install MCP CLI Use Python package
cd apps/mcp/cli_use
if [ ! -d ".venv" ]; then
  uv venv .venv
fi
. .venv/bin/activate
uv pip install --editable ".[test,dev]"
cd ../../../
