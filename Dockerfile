# Set environment variables
ENV METABASE_DOCKER_VERSION=v0.47.2
ENV METABASE_CLICKHOUSE_DRIVER_VERSION=1.2.2

# Create directories and download ClickHouse driver
RUN mkdir -p mb/plugins && cd mb \
    && curl -L -o plugins/ch.jar https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/$METABASE_CLICKHOUSE_DRIVER_VERSION/clickhouse.metabase-driver.jar

# Run Metabase container with ClickHouse driver
CMD docker run -d -p 3000:3000 \
    --mount type=bind,source=$PWD/plugins/ch.jar,destination=/plugins/clickhouse.jar \
    metabase/metabase:$METABASE_DOCKER_VERSION



# Define the Metabase service
FROM metabase/metabase:v0.49.0-RC2 as metabase

# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000

Copy Metabase plugins
COPY ../../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt
