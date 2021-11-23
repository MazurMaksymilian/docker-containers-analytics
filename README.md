# Analytical Container Data Load.

This project is a PoC for a framework used for analyzing video rating.

## Database schema justification

Database schema is very simple - it's basically an import of existing csv files. It's not in 3NF as it is lacking primary keys (though, it doesn't impact performance). 

The columns could go through some changes as well - the identifier of movies table should just be id, and "timestamp" columns should be in TIMESTAMP format instead of integer format (epoch time).

This could be done by doing the client-side copy to temporary tables, and then performing INSERT INTO ... SELECT ... query.

The tables also don't use any additional indexes apart from the ones created with PKs or FKs - the performance was good enough that they weren't really justifiable.

## Usage

1. run ./download_data.sh
2. docker-compose build
3. docker-compose up
4. login into jupyter notebook
5. from jupyter notebook terminal execute python -m pip install psycopg2-binary
6. open Queries notebook and run the code