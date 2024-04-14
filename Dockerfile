# Define the Metabase service
FROM metabase/metabase:v0.49.0-RC2 as metabase

ENV MB_DB_TYPE=postgres
ENV MB_DB_DBNAME=gbx_workflow_db
ENV MB_DB_PORT=5432
ENV MB_DB_USER=gbx_workflow_db_user
ENV MB_DB_PASS=pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB
ENV MB_DB_HOST=dpg-c5a663cobjd8sg6lcvkgt

# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000
