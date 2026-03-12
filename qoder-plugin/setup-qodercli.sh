#!/usr/bin/env bash
# Register cli-anything plugin for Qodercli
#
# Usage:
#   bash setup-qodercli.sh              # Auto-detect plugin path
#   bash setup-qodercli.sh /custom/path # Use custom plugin path

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Determine plugin path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Default to cli-anything-plugin relative to qoder-plugin directory
PLUGIN_DIR="${1:-$(cd "${SCRIPT_DIR}/../cli-anything-plugin" && pwd)}"

# Validate plugin directory
if [ ! -f "${PLUGIN_DIR}/.claude-plugin/plugin.json" ]; then
    echo -e "${YELLOW}Error: plugin.json not found at ${PLUGIN_DIR}/.claude-plugin/${NC}"
    exit 1
fi

# Qodercli config file
QODER_CONFIG="${QODER_HOME:-$HOME}/.qoder.json"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  cli-anything Plugin for Qodercli${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Plugin path: ${PLUGIN_DIR}"
echo "Config file: ${QODER_CONFIG}"
echo ""

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}jq not found. Please install jq or manually add to ${QODER_CONFIG}:${NC}"
    echo ""
    echo '{'
    echo '  "plugins": {'
    echo '    "sources": {'
    echo '      "local": [{"path": "'"${PLUGIN_DIR}"'"}]'
    echo '    }'
    echo '  }'
    echo '}'
    echo ""
    exit 1
fi

# Create or update config
if [ -f "${QODER_CONFIG}" ]; then
    # Check if plugin already registered
    if jq -e ".plugins.sources.local[]? | select(.path == \"${PLUGIN_DIR}\")" "${QODER_CONFIG}" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Plugin already registered in ${QODER_CONFIG}${NC}"
    else
        # Add plugin to existing config
        TMP_CONFIG=$(mktemp)
        jq --arg path "${PLUGIN_DIR}" '
            .plugins //= {} |
            .plugins.sources //= {} |
            .plugins.sources.local //= [] |
            .plugins.sources.local += [{"path": $path}]
        ' "${QODER_CONFIG}" > "${TMP_CONFIG}"
        mv "${TMP_CONFIG}" "${QODER_CONFIG}"
        echo -e "${GREEN}✓ Plugin added to ${QODER_CONFIG}${NC}"
    fi
else
    # Create new config
    cat > "${QODER_CONFIG}" << EOF
{
  "plugins": {
    "sources": {
      "local": [{"path": "${PLUGIN_DIR}"}]
    }
  }
}
EOF
    echo -e "${GREEN}✓ Created ${QODER_CONFIG} with plugin registered${NC}"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Start a new Qodercli session to use the plugin."
echo ""
echo "Available commands:"
echo ""
echo -e "  ${BLUE}/cli-anything:cli-anything${NC} <path>    - Build complete CLI harness"
echo -e "  ${BLUE}/cli-anything:refine${NC} <path> [focus]  - Refine existing harness"
echo -e "  ${BLUE}/cli-anything:test${NC} <path>            - Run tests"
echo -e "  ${BLUE}/cli-anything:validate${NC} <path>        - Validate harness"
echo -e "  ${BLUE}/cli-anything:list${NC}                   - List CLI tools"
echo ""
