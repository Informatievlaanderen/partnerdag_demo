FROM postgis/postgis

COPY init_db.sql /docker-entrypoint-initdb.d/01-init_db.sql
COPY geomobility.sql /docker-entrypoint-initdb.d/02-geomobility.sql
