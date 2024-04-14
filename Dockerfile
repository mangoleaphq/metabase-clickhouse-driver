# Define the Metabase service
FROM metabase/metabase:v0.49.0-RC2 as metabase

# Set environment variables for Metabase
ENV MB_HTTP_TIMEOUT 5000
ENV JAVA_TIMEZONE UTC

# Expose ports for Metabase
EXPOSE 3000
