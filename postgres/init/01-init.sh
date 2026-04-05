#!/usr/bin/env bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE DATABASE persona_dev;

  REVOKE ALL ON DATABASE persona_dev FROM PUBLIC;

  REVOKE CREATE ON SCHEMA public FROM PUBLIC;

  CREATE ROLE ddl_custom_role;

  GRANT
      CONNECT
      ON DATABASE persona_dev TO ddl_custom_role;

  GRANT
      TEMPORARY
      ON DATABASE persona_dev TO ddl_custom_role;

  CREATE ROLE dml_custom_role;

  GRANT
      CONNECT
      ON DATABASE persona_dev TO dml_custom_role;

  GRANT
      TEMPORARY
      ON DATABASE persona_dev TO dml_custom_role;
EOSQL