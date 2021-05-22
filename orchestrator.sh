#!/bin/bash

# dashy is the only built container
docker-compose --env-file .env \
		-f docker-compose.yaml \
		-f dashy/docker-compose.yaml \
		-f monitoring/docker-compose.yaml \
		-f navidrome/docker-compose.yaml \
		-f plex/docker-compose.yaml \
		up -d --build
