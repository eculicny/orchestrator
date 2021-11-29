#!/bin/bash

printf "Importing orchestrator env vars\n"
set -o allexport
source /opt/orchestrator/.env
printf "Importing backup env vars\n"
source /opt/orchestrator/setup/cron_jobs/archive_env
set +o allexport

printf "Setting exit on error\n"
set -e

BACKUP_DIR=/mnt/backups
ARCHIVING_DIR=/opt/service_data/backups_temp
DATETIME=$(date -u +'%Y%m%d_%H%M%S')

printf "Creating ${ARCHIVING_DIR} if not exists\n"
mkdir -vp $ARCHIVING_DIR

##### navidrome #####
# tar data directory
BACKUP_FILE=$ARCHIVING_DIR/navidrome_$DATETIME.tar.gz
printf "Creating tarball for navidrome data ${BACKUP_FILE} from ${NAVIDROME_DATA_DIR}\n"
tar -czf $BACKUP_FILE $NAVIDROME_DATA_DIR
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/navidrome/
mv -v $BACKUP_FILE $BACKUP_DIR/navidrome/

##### plex #####
# tar data directory (exclude Cache)
BACKUP_FILE=$ARCHIVING_DIR/plex_$DATETIME.tar.gz
printf "Creating tarball for plex data ${BACKUP_FILE} from ${PLEX_DATA_DIR}\n"
tar -czf $BACKUP_FILE --exclude='**/Cache/**' --exclude='**/Sessions/**' $PLEX_DATA_DIR
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/plex/
mv -v $BACKUP_FILE $BACKUP_DIR/plex/

##### traefik #####
# tar data directory
BACKUP_FILE=$ARCHIVING_DIR/traefik_$DATETIME.tar.gz
printf "Creating tarball for traefik data ${BACKUP_FILE} from /opt/service_data/traefik\n"
tar -czf $BACKUP_FILE /opt/service_data/traefik
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/traefik/
mv -v $BACKUP_FILE $BACKUP_DIR/traefik/

##### gotify #####
# tar data directory
BACKUP_FILE=$ARCHIVING_DIR/gotify_$DATETIME.tar.gz
printf "Creating tarball for gotify data ${BACKUP_FILE} from ${GOTIFY_DATA_DIR}\n"
tar -czf $BACKUP_FILE $GOTIFY_DATA_DIR
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/gotify/
mv -v $BACKUP_FILE $BACKUP_DIR/gotify/

##### secrets/credentials #####
# g0-t0 and secrets
BACKUP_FILE=$ARCHIVING_DIR/configs_$DATETIME.tar.gz
printf "Creating tarball for machine configs\n"
tar -cvzf $ARCHIVING_DIR/configs_$DATETIME.tar.gz /etc/fstab /opt/orchestrator/.secrets/ /opt/g0-t0-credentials
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/configs/
mv -v $BACKUP_FILE $BACKUP_DIR/configs/

##### photoprism #####
# https://docs.photoprism.org/user-guide/advanced/backups/
# docker-compose exec photoprism photoprism backup -a --albums-path PATH -i --index-path PATH [FILENAME]

##### dndtools #####
# tar 5etools source
printf "Fetching latest 5etools source\n"
cd /opt/orchestrator/dndtools/dndtools-source
git fetch
git pull

printf "Unsetting exit on error\n"
set +e
printf "Finished back up process\n"

