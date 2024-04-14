# Define the Metabase service
FROM metabase/metabase:v0.49.0-RC2 as metabase

ENV MB_DB_CONNECTION_URI=postgres://gbx_workflow_db_user:pk3dm3vXFKm39TiiYLCaG2WI5SKQaVCB@dpg-c5a663cobjd8sg6lcvkg.oregon-postgres.render.com/gbx_workflow_db


# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000
