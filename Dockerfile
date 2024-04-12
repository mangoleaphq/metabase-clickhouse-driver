# Use an Alpine Linux base image
FROM alpine:latest

# Install Docker Compose
RUN apk add --no-cache docker-compose

# Create a new directory for the Docker Compose file
RUN mkdir -p /app

# Copy the Docker Compose file to the new directory
COPY docker-compose.yml /app/

# Set the working directory to /app
WORKDIR /app

# Run Docker Compose to start the services
CMD ["docker-compose", "up", "-d"]
