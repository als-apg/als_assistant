import os
import sys

print(f"Starting AO database initialization...")
print(f"CONFIG_FILE: {os.environ.get('CONFIG_FILE', 'NOT SET')}")

# Validate configuration is loadable
try:
    from osprey.utils.config import get_config_value
    
    # Verify required database configuration exists
    db_config = get_config_value("database.ao_db", None)
    if db_config is None or not isinstance(db_config, dict) or not db_config.get("database_name"):
        print("ERROR: Database configuration is missing or invalid!")
        print("Expected: database.ao_db.database_name to be set in config.yml")
        sys.exit(1)
    
    print(f"✓ Database config validated: {db_config.get('database_name')}")
    
except Exception as e:
    print(f"ERROR loading config: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

from als_assistant.database.ao.ao_database import get_collection as get_ao_collection
# Note: logbook functionality may need to be reviewed/updated
# from als_assistant.database.logbook.logbook_database import get_collection as get_logbook_collection

get_ao_collection(auto_load=True, hard_reset=True, validate=True)
print("AO DB initialization complete.")
     
# Note: logbook functionality commented out - needs review
# get_logbook_collection(auto_load=True, hard_reset=False)
# print("Logbook DB initialization complete.")