#!/usr/bin/env bash

set -eo pipefail

export OPENCLAW_IMAGE="ghcr.io/openclaw/openclaw:latest"

export OPENCLAW_HOME="/home/node/.openclaw"
export LOCAL_FOLDER="./claw"

export LOCAL_SHARED_FOLDER="./shared"
export SHARED_FOLDER="/home/node/shared"

export USER_CLAW_ID=1000
export USER_CLAW_GID=1000

export PORT_WS=18789

OPENCLAW_TOKEN="${1:-default}"

#docker pull $OPENCLAW_IMAGE

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
    -it $OPENCLAW_IMAGE \
    "$COMMAND" #--network host \
}

create_folder "$LOCAL_FOLDER"
create_folder "$LOCAL_SHARED_FOLDER"

# run_command "openclaw onboard"
run_command "/bin/sh"


# ANSIBLE STUFF
#
# ------test connection-----
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/raspberry_pi_claw
# ansible -i inventory.ini raspberrypi -m ping
# ansible-playbook -i inventory.ini config-pi.yml --ask-become-pass
