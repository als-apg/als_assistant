# ALS Assistant

Advanced Light Source Accelerator Assistant - Osprey Agent Application

## Overview

The ALS Assistant is a specialized agentic application for the Advanced Light Source (ALS) accelerator facility at Lawrence Berkeley National Laboratory. It provides intelligent assistance for accelerator operations, diagnostics, data analysis, and monitoring.

## Features

- **PV Address Finding**: Intelligent search for EPICS Process Variable addresses
- **Live Data Retrieval**: Real-time access to accelerator control system data
- **Historical Data Analysis**: Query and analyze archiver data
- **Data Visualization**: Create plots and visualizations of accelerator data
- **Machine Operations**: Monitor and control accelerator operations
- **Live Monitoring**: Launch Phoebus Data Browser for real-time PV monitoring
- **Custom Knowledge Base**: ALS-specific knowledge including AO database, experiment database

## Quick Start

```bash
# Setup environment
cp .env.example .env
# Edit .env with your API keys and configuration

# Start services
cd /home/als3/acct/thellert/projects/als_assistant
osprey deploy up

# Run CLI interface
osprey chat
```

## Project Structure

```
als_assistant/
├── src/
│   └── als_assistant/           # Application code
│       ├── registry.py           # Component registry
│       ├── capabilities/         # ALS-specific capabilities
│       ├── context_classes.py    # Context definitions
│       ├── services/             # Launcher, PV Finder services
│       ├── database/             # AO, knowledge, PV databases
│       ├── framework_prompts/    # Custom prompts
│       └── utils/                # Helpers
├── services/                     # Docker services
│   ├── framework/               # Framework services (Jupyter, OpenWebUI, Pipelines)
│   └── als_assistant/           # ALS-specific services (PV Finder, MongoDB, Langfuse)
├── config.yml                    # Project configuration
├── pyproject.toml               # Dependencies
└── README.md                    # This file
```

## Development

Edit files in `src/als_assistant/` to add functionality. Changes are reflected immediately - no reinstall needed.

### Key Components

**Capabilities:**
- `pv_address_finding`: Find PV addresses from descriptions
- `pv_value_retrieval`: Get current PV values
- `get_archiver_data`: Retrieve historical data
- `data_analysis`: Statistical and numerical analysis
- `data_visualization`: Create plots and visualizations
- `machine_operations`: Monitor and control operations
- `live_monitoring`: Launch Phoebus Data Browser

**Services:**
- `pv_finder`: Specialized service for PV address search (port 8051)
- `mongo`: MongoDB database for AO and experiment data (port 27017)
- `langfuse`: Observability and monitoring (configured in langfuse service)

**Databases:**
- AO Database: Accelerator Object database with PV mappings
- Experiment Database: Beamline and experiment information
- PV Names List: Comprehensive list of all available PVs

## Requirements

- Python >=3.11
- Framework dependencies (osprey-framework)
- EPICS (pyepics) for accelerator control
- MongoDB for databases
- API keys for AI models (CBORG, OpenAI, etc.)

## Configuration

All configuration is in `config.yml`. Key sections:

- **Models**: 8 framework models + ALS-specific models
- **Services**: Framework services + ALS-specific services (PV Finder, MongoDB, Langfuse)
- **Safety Controls**: EPICS write protection, approval workflows
- **Execution**: EPICS gateway configuration for read/write access
- **Logging**: Component-specific logging colors

## Safety

**IMPORTANT**: EPICS writes are **disabled by default** (`execution_control.epics.writes_enabled: false`). Only enable for production hardware control with proper authorization.

## Documentation

- Framework: https://als-apg.github.io/osprey/
- ALS Assistant specific documentation: See individual capability files

## License

BSD-3-Clause (same as framework)

