# Use the base image for ClickHouse
FROM clickhouse/clickhouse-server:24.1-alpine

# Set ulimits
RUN ulimit -n 262144

# Copy ClickHouse configuration files
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports for ClickHouse
EXPOSE 8123 9000