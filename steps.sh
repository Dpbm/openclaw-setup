#!/usr/bin/env bash

export OPENCLAW_IMAGE="ghcr.io/openclaw/openclaw:latest"
export OPENCLAW_HOME="/home/node/.openclaw"
export LOCAL_FOLDER="./claw"

#docker pull $OPENCLAW_IMAGE

if [ ! -d $LOCAL_FOLDER ]; then
  echo "Creating $LOCAL_FOLDER..."
  mkdir $LOCAL_FOLDER
  echo "Giving correct ownership..."
  sudo chown -R 1000:1000 $LOCAL_FOLDER
fi

docker run -e OPENCLAW_TOKEN="$1" -u "1000:1000" -v "$LOCAL_FOLDER:$OPENCLAW_HOME" -it $OPENCLAW_IMAGE openclaw onboard
