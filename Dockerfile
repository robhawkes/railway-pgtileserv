# Make sure PostGIS extension is installed
FROM alpine:3.16.2 AS check_postgis
ARG DATABASE_URL
RUN apk add --no-cache postgresql13-client
RUN psql -d ${DATABASE_URL} -c 'CREATE EXTENSION IF NOT EXISTS postgis;'

# Set up pg_tileserv
# TODO: Find an alternative to COPY step as it's only there to force Dockerfile to wait for previous step
FROM pramsey/pg_tileserv
ARG DATABASE_URL
COPY --from=check_postgis . .
