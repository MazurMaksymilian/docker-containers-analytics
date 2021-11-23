#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;

        CREATE TABLE IF NOT EXISTS movies (
          movie_id INTEGER,
          title VARCHAR(200),
          genre VARCHAR(200),
          constraint pk_movie_id primary key (movie_id)
        );


        CREATE TABLE IF NOT EXISTS tags (
          user_id INTEGER,
          movie_id INTEGER,
          tag VARCHAR(100),
          timestamp INTEGER,
          constraint fk_movie_id foreign key (movie_id) REFERENCES movies (movie_id)
        );

        CREATE TABLE IF NOT EXISTS ratings (
          user_id INTEGER,
          movie_id INTEGER,
          rating FLOAT,
          timestamp INTEGER,
          constraint fk_movie_id foreign key (movie_id) REFERENCES movies (movie_id)
        );

        CREATE TABLE IF NOT EXISTS links (
          movie_id INTEGER,
          imdb_id CHAR(7),
          tmdb_id INTEGER,
          constraint fk_movie_id foreign key (movie_id) REFERENCES movies (movie_id)
        );
  COMMIT;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$APP_DB_NAME" -c "\copy movies FROM '/docker-entrypoint-initdb.d/ml-latest-small/movies.csv' DELIMITER ',' CSV HEADER;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$APP_DB_NAME" -c "\copy links FROM '/docker-entrypoint-initdb.d/ml-latest-small/links.csv' DELIMITER ',' CSV HEADER;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$APP_DB_NAME" -c "\copy ratings FROM '/docker-entrypoint-initdb.d/ml-latest-small/ratings.csv' DELIMITER ',' CSV HEADER;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$APP_DB_NAME" -c "\copy tags FROM '/docker-entrypoint-initdb.d/ml-latest-small/tags.csv' DELIMITER ',' CSV HEADER;"

