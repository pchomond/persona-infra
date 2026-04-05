#!/bin/bash
set -e

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock 2>/dev/null)

if [ -n "$DOCKER_GID" ]; then
    echo "Detected Docker socket GID: $DOCKER_GID"

    EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)

    if [ -n "$EXISTING_GROUP" ]; then
        echo "Adding jenkins user to existing group: $EXISTING_GROUP"
        usermod -aG "$EXISTING_GROUP" jenkins
    else
        echo "Creating group 'docker_host' with GID $DOCKER_GID"
        groupadd -g "$DOCKER_GID" docker_host
        usermod -aG docker_host jenkins
    fi
else
    echo "Warning: Docker socket not found at /var/run/docker.sock"
fi

exec "$@"