
printf "Updating and installing apt packages\n"
apt-get update
apt-get install -y git htop ncdu build-essential

printf "Copying cron job files\n"
cp -v ./archive_cron /etc/cron.d/

printf "Copying alias file\n"
cp -v ./00-aliases.sh /etc/profiles.d/

printf "Copying blocklist file\n"
cp -v ./01-blocklist.conf /etc/rsyslog.d/
