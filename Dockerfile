# Use the official Metabase image as the base image
FROM metabase/metabase:latest

# Set environment variables for the PostgreSQL database connection
ENV MB_DB_TYPE=postgres
ENV MB_DB_DBNAME=gbx_workflow_db
ENV MB_DB_PORT=5432
ENV MB_DB_USER=gbx_workflow_db_user
ENV MB_DB_PASS=pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB
ENV MB_DB_HOST=dpg-c5a663cobjd8sg6lcvkgt

# Set environment variables for Metabase settings
ENV MB_HTTP_TIMEOUT=5000
ENV JAVA_TIMEZONE=UTC

# Expose port 3000 (default Metabase port)
EXPOSE 3000

# Create a directory for Metabase plugins and download ClickHouse driver
RUN mkdir -p /plugins \
    && curl -L -o /plugins/clickhouse.jar https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/1.2.2/clickhouse.metabase-driver.jar

# Copy additional Metabase plugins and ClickHouse TLS certificates
COPY ../../../resources/modules/clickhouse.metabase-driver.jar /plugins/clickhouse.jar
COPY ./.docker/clickhouse/single_node_tls/certificates/ca.crt /certs/ca.crt

# Start the Metabase service
CMD ["java", "-jar", "/app/metabase.jar"]
