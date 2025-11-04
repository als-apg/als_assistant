#!/bin/bash
# MongoDB init startup wrapper - installs framework before initializing database
set -e

echo "=============================================="
echo "Starting MongoDB Database Initialization"
echo "=============================================="

# Install dependencies from requirements.txt (always do this)
echo "Installing dependencies from requirements.txt..."
if [ -f "/app/requirements.txt" ]; then
    pip install --no-cache-dir -r /app/requirements.txt
    echo "✓ Dependencies installed successfully"
else
    echo "ERROR: /app/requirements.txt not found"
    exit 1
fi

# Development mode - override framework with local version
if [ "$DEV_MODE" = "true" ] && [ -d "/app/framework_override" ]; then
    echo "==============================================================="
    echo "🔧 Development mode: Overriding framework with local version..."
    echo "==============================================================="
     
    # Create symlink to override the installed framework
    # The PYTHONPATH order ensures our local version is found first
    ln -sf /app/framework_override /app/framework
    export PYTHONPATH="/app:${PYTHONPATH}"
    echo "✓ Local framework will be used (via PYTHONPATH)"
fi

# Run the database initialization script
echo "Running database initialization..."
exec python /app/init_db.py

