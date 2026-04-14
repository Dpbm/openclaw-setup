
```bash
source ./steps.sh

# Setup local folders
create_folder "$LOCAL_FOLDER"
create_folder "$LOCAL_SHARED_FOLDER"
create_folder "$LOCAL_BINS"

```

```bash
# Docke commands

# single command setup
run_command "openclaw onboard"
run_command "/bin/sh"

# Compose setup
docker compose down
OPENCLAW_TOKEN=test docker compose up -d
```

```bash
# ----- MODELS OLLAMA ----------------------------------------

# Local setup (no docker)
ollama run gemma4:e2b

# Docker ollama 
docker exec -it ollama ollama pull gemma4:e2b
docker exec -it ollama ollama pull gemma4:e4b
docker exec -it ollama ollama pull granite4:3b
docker exec -it ollama ollama pull minimax-m2.7:cloud
docker exec -it ollama ollama pull glm-5.1:cloud
docker exec -it ollama ollama pull kimi-k2.5:cloud
docker exec -it ollama ollama pull gemini-3-flash-preview:cloud

# docker exec -it ollama ollama run minimax-m2.7:cloud
```


```bash
# TOOLS


#
# -------- UPDATE CLAW ---------------------------------------
# docker exec -it openclaw openclaw onboard
# docker exec -it openclaw /bin/sh

# get local GRPCURL
curl -LO https://github.com/fullstorydev/grpcurl/releases/download/v1.9.3/grpcurl_1.9.3_linux_x86_64.tar.gz && \ 
  tar -xvf grpcurl_1.9.3_linux_x86_64.tar.gz && \
  rm -rf LICENSE grpcurl_1.9.3_linux_x86_64.tar.gz && \
  mv grpcurl ./bins

# ---------- ANSIBLE STUFF ------------------------------------
#
# ########test connection##########################
# will be disabled later via uwf
# ansible -i inventory.ini raspberrypi -m ping

# ########setup####################################
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/raspberry_pi_claw
ansible-playbook -i inventory.ini config-pi.yml --ask-become-pass
ansible-playbook -i inventory.ini config-picoclaw.yml --ask-become-pass

scp config-picoclaw.json pi@192.168.0.4:/home/pi/.picoclaw/config.json
scp pi@192.168.0.4:/home/pi/.picoclaw/config.json ./config-picoclaw.json
```
