# Use the official Metabase image as the base image
FROM metabase/metabase:latest

# Set the environment variables for the PostgreSQL database
ENV MB_DB_TYPE=postgres
ENV MB_DB_DBNAME=gbx_workflow_db
ENV MB_DB_PORT=5432
ENV MB_DB_USER=gbx_workflow_db_user
ENV MB_DB_PASS=pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB
ENV MB_DB_HOST=dpg-c5a663cobjd8sg6lcvkgt

# Install the ClickHouse driver
RUN mkdir -p /plugins && \
    wget -P /plugins https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/$METABASE_CLICKHOUSE_DRIVER_VERSION/clickhouse.metabase-driver.jar

# Expose the Metabase port
EXPOSE 3000

# Start Metabase when the container starts
CMD ["java", "-jar", "/app/metabase.jar"]