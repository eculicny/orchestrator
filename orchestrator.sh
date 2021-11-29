#!/bin/bash

set -o allexport
source .secrets/secret_vars
set +o allexport

# dashy is currently the only built container
docker-compose --env-file .env \
		-f docker-compose.traefik.yaml \
		-f dashy/docker-compose.yaml \
		-f navidrome/docker-compose.yaml \
		-f plex/docker-compose.yaml \
		-f tiddlywiki/docker-compose.yaml \
		-f dozzle/docker-compose.yaml \
		-f gotify/docker-compose.yaml \
		-f uptime-kuma/docker-compose.yaml \
		-f foundry/docker-compose.yaml \
		-f dndtools/docker-compose.yaml \
		-f vpnnetwork/docker-compose.yaml \
		-f photoprism/docker-compose.yaml \
		up -d
