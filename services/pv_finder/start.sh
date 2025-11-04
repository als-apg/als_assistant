#!/bin/bash
# PV Finder startup wrapper - installs framework override in dev mode
set -e

echo "=============================================="
echo "Starting PV Finder MCP Server"
echo "=============================================="

# Development mode - override framework with local version
if [ "$DEV_MODE" = "true" ] && [ -d "/pv_finder/framework_override" ]; then
    echo "==============================================================="
    echo "🔧 Development mode: Overriding framework with local version..."
    echo "==============================================================="
     
    # Create symlink to override the installed framework
    # The PYTHONPATH order ensures our local version is found first
    ln -sf /pv_finder/framework_override /pv_finder/framework
    export PYTHONPATH="/pv_finder:${PYTHONPATH}"
    echo "✓ Local framework will be used (via PYTHONPATH)"
else
    echo "📦 Using PyPI framework version"
fi

# Print configuration info for debugging
echo ""
echo "Configuration:"
echo "  CONFIG_FILE: ${CONFIG_FILE}"
echo "  PYTHONPATH: ${PYTHONPATH}"
echo "  REPO_SRC: ${REPO_SRC}"
echo ""

# Run the PV Finder MCP server
echo "Starting PV Finder server..."
exec python /pv_finder/src/main.py

