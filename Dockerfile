# Use the official Metabase image as the base image
FROM metabase/metabase:latest

export METABASE_DOCKER_VERSION=v0.47.2
export METABASE_CLICKHOUSE_DRIVER_VERSION=1.2.2

mkdir -p mb/plugins && cd mb
curl -L -o plugins/ch.jar https://github.com/ClickHouse/metabase-clickhouse-driver/releases/download/$METABASE_CLICKHOUSE_DRIVER_VERSION/clickhouse.metabase-driver.jar
docker run -d -p 3000:3000 \
  --mount type=bind,source=$PWD/plugins/ch.jar,destination=/plugins/clickhouse.jar \
  metabase/metabase:$METABASE_DOCKER_VERSION

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