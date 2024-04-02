# Dockerfile for setting up ClickHouse and Metabase

# Base image for ClickHouse
FROM clickhouse/clickhouse-server:24.1-alpine AS clickhouse

# Set up ClickHouse configuration
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse
EXPOSE 8123 9000

# Define ulimits for ClickHouse
RUN ulimit -n 262144

# Base image for ClickHouse older version
FROM clickhouse/clickhouse-server:23.3-alpine AS clickhouse_older_version

# Set up ClickHouse older version configuration
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse older version
EXPOSE 8124 9001

# Define ulimits for ClickHouse older version
RUN ulimit -n 262144

# Base image for ClickHouse with TLS
FROM clickhouse/clickhouse-server:latest AS clickhouse_tls

# Set up ClickHouse with TLS configuration
COPY ./.docker/clickhouse/single_node_tls/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node_tls/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse with TLS
EXPOSE 8443 9440

# Define ulimits for ClickHouse with TLS
RUN ulimit -n 262144

# Base image for Metabase
FROM metabase/metabase:v0.49.0-RC2 AS metabase

# Set up Metabase environment variables
ENV MB_HTTP_TIMEOUT=5000
ENV JAVA_TIMEZONE=UTC

# Expose port for Metabase
EXPOSE 3000

# Set up Metabase volumes
COPY ../../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt
