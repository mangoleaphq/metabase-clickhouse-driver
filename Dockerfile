# Use the base image for ClickHouse
FROM clickhouse/clickhouse-server:24.1-alpine

# Set ulimits
RUN ulimit -n 262144

# Copy ClickHouse configuration files
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse
EXPOSE 8123 9000

# Create a second stage for the older version of ClickHouse
FROM clickhouse/clickhouse-server:23.3-alpine as clickhouse_older_version

# Set ulimits for the older version
RUN ulimit -n 262144

# Copy configuration files for the older version
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports for the older version of ClickHouse
EXPOSE 8124 9001

# Create a third stage for ClickHouse with TLS
FROM base_image_for_tls_setup as clickhouse_tls

# Copy TLS configuration files
COPY ./.docker/clickhouse/single_node_tls/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node_tls/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse with TLS
EXPOSE 8443 9440

# Set the hostname for ClickHouse with TLS
ENV HOSTNAME server.clickhouseconnect.test

# Define the Metabase service
FROM metabase/metabase:v0.49.0-RC2 as metabase

# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000

# Copy Metabase plugins
COPY ../../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt
