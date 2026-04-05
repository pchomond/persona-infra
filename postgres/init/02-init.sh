#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 \
    --username "$POSTGRES_USER" \
    --dbname "$POSTGRES_DB_NAME" \
    --set RW_USER_PW=\'$(<"$LIQUIBASE_USER_PASSWORD_FILE")\' \
    --set RO_USER_PW=\'$(<"$DEV_USER_PASSWORD_FILE")\' <<-EOSQL
  REVOKE CREATE ON SCHEMA public FROM PUBLIC;
  CREATE SCHEMA IF NOT EXISTS persona_schema;

  CREATE USER app_user WITH ENCRYPTED PASSWORD :RO_USER_PW;
  CREATE USER liquibase_user WITH ENCRYPTED PASSWORD :RW_USER_PW;

  GRANT
      USAGE,
      CREATE
      ON SCHEMA persona_schema TO ddl_custom_role;
  GRANT
      ALL
      ON ALL SEQUENCES IN SCHEMA persona_schema TO ddl_custom_role;

  GRANT
      USAGE
      ON SCHEMA persona_schema TO dml_custom_role;
  GRANT
      USAGE,
      SELECT
      ON ALL SEQUENCES IN SCHEMA persona_schema TO dml_custom_role;

  GRANT ddl_custom_role TO liquibase_user;
  GRANT dml_custom_role TO app_user;
EOSQL