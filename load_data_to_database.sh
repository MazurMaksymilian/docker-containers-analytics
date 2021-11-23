#!/bin/bash

export $(grep -v '^#' .env | xargs)
psql "postgresql://$APP_DB_USER:$APP_DB_PASS@localhost/$APP_DB_NAME" -f "./copy_database_data.sql"
