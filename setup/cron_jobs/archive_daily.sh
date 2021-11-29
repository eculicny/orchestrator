#!/bin/bash

printf "Importing orchestrator env vars\n"
set -o allexport
source /opt/orchestrator/.env
printf "Importing archive env vars\n"
source /opt/orchestrator/setup/cron_jobs/archive_env
set +o allexport

printf "Setting exit on error\n"
set -e

##### foundry #####
# tar data directory
BACKUP_FILE=$ARCHIVING_DIR/foundry_$DATETIME.tar.gz
printf "Creating tarball for foundry data ${BACKUP_FILE} from ${FOUNDRY_DATA_DIR}\n"
tar -czf $BACKUP_FILE $FOUNDRY_DATA_DIR
printf "Moving ${BACKUP_FILE} to ${BACKUP_DIR}\n"
mkdir -vp $BACKUP_DIR/foundry/
mv -v $BACKUP_FILE $BACKUP_DIR/foundry/

##### photoprism #####
# https://docs.photoprism.org/user-guide/advanced/backups/
# docker-compose exec photoprism photoprism backup -a --albums-path PATH -i --index-path PATH [FILENAME]

printf "Unsetting exit on error\n"
set +e
printf "Finished back up process\n"

