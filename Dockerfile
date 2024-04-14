# Define the Metabase service
FROM metabase/metabase:latest as metabase

# Set environment variables
# ENV METABASE_DOCKER_VERSION=v0.47.2
# ENV METABASE_CLICKHOUSE_DRIVER_VERSION=1.2.2

# Set the environment variables for the PostgreSQL database
ENV MB_DB_TYPE=postgres
ENV MB_DB_DBNAME=gbx_workflow_db
ENV MB_DB_PORT=5432
ENV MB_DB_USER=gbx_workflow_db_user
ENV MB_DB_PASS=pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB
ENV MB_DB_HOST=dpg-c5a663cobjd8sg6lcvkgt


# Create directories and download ClickHouse driver
RUN mkdir -p mb/plugins && cd mb \
    && curl -L -o plugins/ch.jar https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/$METABASE_CLICKHOUSE_DRIVER_VERSION/clickhouse.metabase-driver.jar

# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000

Copy Metabase plugins
COPY ../../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt

# Run Metabase container with ClickHouse driver
CMD docker run -d -p 3000:3000 \
    --mount type=bind,source=$PWD/plugins/ch.jar,destination=/plugins/clickhouse.jar \
    metabase/metabase:$METABASE_DOCKER_VERSION