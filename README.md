# Analytical Container Data Load.

This project is a PoC for a framework used for analyzing video rating.

## Database schema justification

Database schema is very simple - it's basically an import of existing csv files. It's not in 3NF as it is lacking primary keys (though, it doesn't impact performance). 

The columns could go through some changes as well - the identifier of movies table should just be id, and "timestamp" columns should be in TIMESTAMP format instead of integer format (epoch time).

This could be done by doing the client-side copy to temporary tables, and then performing INSERT INTO ... SELECT ... query.

The tables also don't use any additional indexes apart from the ones created with PKs or FKs - the performance was good enough that they weren't really justifiable.

## Usage

1. set the following environment variables in .env file: POSTGRES_USER, POSTGRES_PASSWORD, APP_DB_USER, APP_DB_PASS, APP_DB_NAME
2. docker-compose build
3. docker-compose up 
4. run ./01-download_data.sh
5. run ./02-load_data_to_database.sh
6. log into jupyter notebook
7. from jupyter notebook terminal execute "python -m pip install psycopg2-binary"
8. open Queries notebook and run the code