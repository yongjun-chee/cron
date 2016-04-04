#!/bin/bash
echo [$(date +"%Y-%m-%d %T")] $1 stopping...
sudo service hybris stop
sleep 30
sudo service hybris start
echo [$(date +"%Y-%m-%d %T")] $1 started

# $ crontab -l
# SHELL=/bin/bash
# PATH=/sbin:/bin:/usr/sbin:/usr/bin
# MAILTO=yongjun.chee@email.com
# HOME=/data/hybris_data/prod-000
#
# 20 23 * * * /data/hybris_data/prod-000/restart_hybris.sh store-001 >> restart.log
