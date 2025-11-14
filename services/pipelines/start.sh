#!/bin/bash
# Pipelines startup wrapper - installs framework before starting server
set -e

echo "=============================================="
echo "Starting Pipelines Container"
echo "=============================================="

# Install project dependencies (including framework)
if [ -f "/pipelines/repo_src/requirements.txt" ]; then
    echo "Installing project dependencies from requirements.txt..."
    pip install --no-cache-dir -r /pipelines/repo_src/requirements.txt
    echo "✓ Project dependencies installed successfully"
else
    echo "WARNING: /pipelines/repo_src/requirements.txt not found"
    echo "Installing framework directly as fallback..."
    pip install osprey-framework>=0.8.0
fi

# Development mode override - install local osprey AFTER everything else
if [ "$DEV_MODE" = "true" ] && [ -d "/pipelines/osprey_override" ]; then
    echo "🔧 Development mode: Overriding osprey with local version..."

    # Create a temporary setup.py for the override
    cat > /pipelines/osprey_override/setup.py << 'EOF'
from setuptools import setup, find_packages
setup(
    name="osprey",
    version="dev-override",
    packages=find_packages(),
    install_requires=[],  # Dependencies already installed from requirements.txt
)
EOF

    # Install the local osprey (this will override the PyPI version)
    pip install --no-cache-dir -e /pipelines/osprey_override
    echo "✓ Osprey overridden with local development version"
else
    echo "📦 Using PyPI osprey version"
fi

# Verify pipeline interface files exist
if [ -n "$PIPELINES_DIR" ] && [ -f "$PIPELINES_DIR/main.py" ]; then
    echo "✓ Pipeline interface found at $PIPELINES_DIR/main.py"
    ls -la "$PIPELINES_DIR"
else
    echo "WARNING: Pipeline interface not found at $PIPELINES_DIR"
    echo "Make sure main.py was copied during project initialization"
fi

# Call the original pipelines start script
echo "Starting pipelines server..."
cd /app
exec bash start.sh

