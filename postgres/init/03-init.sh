#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "liquibase_user" --dbname "$POSTGRES_DB_NAME" <<-EOSQL
  ALTER DEFAULT PRIVILEGES IN SCHEMA persona_schema
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dml_custom_role;
EOSQL