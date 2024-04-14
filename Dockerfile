FROM metabase/metabase:v0.41.3

# Create a new user and group for Metabase
RUN groupadd -r metabase && useradd -r -g metabase metabase

# Change ownership of the Metabase directory to the new user
RUN chown -R metabase:metabase /metabase

# Add any custom plugins here
# RUN mkdir -p /plugins && \
#     wget -P /plugins https://github.com/metabase/custom-plugin/releases/download/v1.0.0/custom-plugin.jar

EXPOSE 3000

USER metabase
CMD ["java", "-jar", "metabase.jar"]