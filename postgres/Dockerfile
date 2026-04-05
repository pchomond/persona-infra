FROM postgres:17-alpine

# Copy the init script to the special directory
# Files in this folder are executed in alphabetical order on first run
COPY ./init /docker-entrypoint-initdb.d

RUN chmod +x -R /docker-entrypoint-initdb.d

# Optional: Set timezone to UTC
ENV TZ=UTC