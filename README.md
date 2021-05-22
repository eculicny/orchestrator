# orchestrator
Primary homeserver repo

## Setup
1. Add network mounts to `/etc/fstab`
	*. `//<host>/<fileshare>   /mnt/<fileshare>      cifs    credentials=<host_credentials>,file_mode=0755,dir_mode=0755 0       0`
	*. Credentials file with `username`, `password`, and `domain`
2. Make root data dir 0777
3. Apt setup script `/setup/setup.sh`
4. Adjust `.env` as necessary

## Running
Runs `docker-compose` with multiple files.
```
./orchestrator.sh
```

