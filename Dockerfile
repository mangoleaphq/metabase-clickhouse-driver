# Use the clickhouse base image
FROM clickhouse/clickhouse-server:24.1-alpine

# Set ulimits
RUN ulimit -n 262144

# Copy configuration files
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports
EXPOSE 8123 9000

# Use the clickhouse base image
FROM clickhouse/clickhouse-server:23.3-alpine

# Set ulimits
RUN ulimit -n 262144

# Copy configuration files
COPY ./.docker/clickhouse/single_node/config.xml /etc/clickhouse-server/config.xml
COPY ./.docker/clickhouse/single_node/users.xml /etc/clickhouse-server/users.xml

# Expose ports
EXPOSE 8124 9001
