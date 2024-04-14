# Use the official Metabase image as the base image
FROM metabase/metabase:latest

# Install the ClickHouse driver
RUN mkdir -p /opt/metabase/plugins && \
    wget -P /opt/metabase/plugins https://github.com/metabase/clickhouse-driver/releases/download/v1.2.2/clickhouse-driver-1.2.2.jar

# Set the environment variables for the PostgreSQL database
ENV MB_DB_TYPE=postgres
ENV MB_DB_DBNAME=gbx_workflow_db
ENV MB_DB_PORT=5432
ENV MB_DB_USER=gbx_workflow_db_user
ENV MB_DB_PASS=pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB
ENV MB_DB_HOST=dpg-c5a663cobjd8sg6lcvkgt

# Expose the Metabase port
EXPOSE 3000

# Start Metabase when the container starts
CMD ["java", "-jar", "/app/metabase.jar"]