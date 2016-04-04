#!/bin/bash
DATE=$(date +"%Y-%m-%d")
REMOTE_SERVER=prod-000-store-001.site.com
REMOTE_SERVER_PATH=/data/hybris_data/prod/dump/store-001
LOCAL_PATH=/home/support/prod/store-001

echo [$(date +"%Y-%m-%d %T")] get dump files started

# assuming you already have setup SSH key from the remote server
scp -c arcfour user@$REMOTE_SERVER:$REMOTE_SERVER_PATH/heapdump-$DATE.bin.gz $LOCAL_PATH/
scp -c arcfour user@$REMOTE_SERVER:$REMOTE_SERVER_PATH/threaddump-$DATE.log.gz $LOCAL_PATH/

echo [$(date +"%Y-%m-%d %T")] get dump files finished
