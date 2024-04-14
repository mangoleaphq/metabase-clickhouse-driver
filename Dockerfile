FROM metabase/metabase:v0.41.3

# Add any custom plugins here
# RUN mkdir -p /plugins && \
#     wget -P /plugins https://github.com/metabase/custom-plugin/releases/download/v1.0.0/custom-plugin.jar

EXPOSE 3000

CMD ["java", "-jar", "metabase.jar"]