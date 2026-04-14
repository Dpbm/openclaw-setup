#!/usr/bin/env bash

set -eo pipefail
export OPENCLAW_IMAGE="ghcr.io/openclaw/openclaw:latest"

export OPENCLAW_HOME="/home/node/.openclaw"
export LOCAL_FOLDER="./claw"

export LOCAL_SHARED_FOLDER="./shared"
export SHARED_FOLDER="/home/node/shared"

export LOCAL_BINS="./bins"
export IMAGE_BINS="/home/node/bins"

export USER_CLAW_ID=1000
export USER_CLAW_GID=1000

export PORT_WS=18789

OPENCLAW_TOKEN="${1:-default}"


create_folder() {
  local FOLDER="$1"

  if [ ! -d "$FOLDER" ]; then
    echo "--------------------"
    echo "Creating $FOLDER..."
    mkdir -p "$FOLDER"

    echo "Giving correct ownership..."
    sudo chown -R $USER_CLAW_ID:$USER_CLAW_GID "$FOLDER"
  fi

}

run_command() {
  local COMMAND="$1"
  echo "Running docker command: $COMMAND"

  docker run --rm \
    \
    --name "openclaw" \
    -e OPENCLAW_TOKEN="$OPENCLAW_TOKEN" \
    -u "$USER_CLAW_ID:$USER_CLAW_GID" \
    -p "$PORT_WS:$PORT_WS" \
    -v "$LOCAL_FOLDER:$OPENCLAW_HOME" \
    -v "$LOCAL_SHARED_FOLDER:$SHARED_FOLDER" \
    -v "$LOCAL_BINS:$IMAGE_BINS:ro" \
    -it $OPENCLAW_IMAGE \
    "$COMMAND" #--network host \
}
