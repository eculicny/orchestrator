#!/bin/bash

export NAMECHEAP_API_KEY=$(cat ./.secrets/namecheap_api_key)
export NAMECHEAP_API_USER=$(cat ./.secrets/namecheap_api_user)
export DOMAIN=$(cat ./.secrets/domain)
export DOMAIN_EMAIL=$(cat ./.secrets/domain_email)
export WIKI_ADMIN=$(cat ./.secrets/wikiadmin)

# dashy is currently the only built container
docker-compose --env-file .env \
		-f docker-compose.traefik.yaml \
		-f dashy/docker-compose.yaml \
		-f monitoring/docker-compose.yaml \
		-f navidrome/docker-compose.yaml \
		-f plex/docker-compose.yaml \
		-f tiddlywiki/docker-compose.yaml \
		up -d
