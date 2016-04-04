#!/bin/bash
#create_dump_files_store_001.sh
TCINSTANCEID=$(cat /opt/hybris/bin/platform/tcServer-6.0/TCINSTANCEID/logs/tcserver.pid)
DATE=$(date +"%Y-%m-%d")
WORKING_PATH="/data/hybris_data/prod/heapdump/store-002"

echo [$(date +"%Y-%m-%d %T")] heapdump script started

echo [$(date +"%Y-%m-%d %T")] tcServer PID: $TCINSTANCEID
jmap -dump:file=$WORKING_PATH/heapdump-$DATE.bin $TCINSTANCEID
jstack $TCINSTANCEID >> $WORKING_PATH/threaddumps-$DATE.log
cd $WORKING_PATH
gzip -f heapdump-$DATE.bin threaddumps-$DATE.log
chmod 744 *

echo [$(date +"%Y-%m-%d %T")] heapdump script ended



#!/bin/bash
#remove_dump_files_store_001.sh
WORKING_PATH="/data/hybris_data/prod/heapdump/store-002"

cd $WORKING_PATH
echo [$(date +"%Y-%m-%d %T")] Below files are removed
ls -1
yes | rm *



$ crontab -l
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=yongjun.chee@arvatosystems.com
HOME=/data/hybris_data/prod/heapdump/

0 4 * * * /data/hybris_data/prod/dump/create_dump_files_store_001.sh >> heapdump.log
0 7 * * * /data/hybris_data/prod/dump/remove_dump_files_store_001.sh >> heapdump.log
