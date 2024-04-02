# Use clickhouse base images
FROM clickhouse/clickhouse-server:24.1-alpine AS clickhouse_base
RUN mkdir -p /etc/clickhouse-server/
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Set ulimits
RUN ulimit -n 262144

# Expose ports for clickhouse service
EXPOSE 8123 9000

# Build clickhouse_tls service
FROM clickhouse/clickhouse-server:24.1-alpine AS clickhouse_tls
RUN mkdir -p /etc/clickhouse-server/
COPY ./.docker/clickhouse/single_node_tls/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node_tls/users.xml /etc/clickhouse-server/users.xml

# Set ulimits
RUN ulimit -n 262144

# Expose ports for clickhouse_tls service
EXPOSE 8443 9440

# Build metabase service
FROM metabase/metabase:v0.49.0-RC2 AS metabase
ENV MB_HTTP_TIMEOUT=5000
ENV JAVA_TIMEZONE=UTC

# Expose ports for metabase service
EXPOSE 3000

# Copy necessary files for metabase service
COPY ../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt

# Start the services
CMD ["sh", "-c", "clickhouse server & metabase"]
