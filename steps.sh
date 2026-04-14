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

create_folder "$LOCAL_FOLDER"
create_folder "$LOCAL_SHARED_FOLDER"
create_folder "$LOCAL_BINS"

# docker pull $OPENCLAW_IMAGE
# run_command "openclaw onboard"
# run_command "/bin/sh"

# docker compose down
# OPENCLAW_TOKEN=test docker compose up -d

# ----- MODELS OLLAMA ----------------------------------------
# ollama run gemma4:e2b
# docker exec -it ollama ollama pull gemma4:e2b
# docker exec -it ollama ollama pull gemma4:e4b
# docker exec -it ollama ollama pull granite4:3b
# docker exec -it ollama ollama pull minimax-m2.7:cloud
# docker exec -it ollama ollama pull glm-5.1:cloud
# docker exec -it ollama ollama pull kimi-k2.5:cloud
# docker exec -it ollama ollama pull gemini-3-flash-preview:cloud
#
# docker exec -it ollama ollama run minimax-m2.7:cloud
#
#
# -------- UPDATE CLAW ---------------------------------------
# docker exec -it openclaw openclaw onboard
# docker exec -it openclaw /bin/sh
# 
curl -LO https://github.com/fullstorydev/grpcurl/releases/download/v1.9.3/grpcurl_1.9.3_linux_x86_64.tar.gz && \ 
  tar -xvf grpcurl_1.9.3_linux_x86_64.tar.gz && \
  rm -rf LICENSE grpcurl_1.9.3_linux_x86_64.tar.gz && \
  mv grpcurl ./bins

# ---------- ANSIBLE STUFF ------------------------------------
#
# ########test connection##########################
# ansible -i inventory.ini raspberrypi -m ping
#
# ########setup####################################
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/raspberry_pi_claw
# ansible-playbook -i inventory.ini config-pi.yml --ask-become-pass
