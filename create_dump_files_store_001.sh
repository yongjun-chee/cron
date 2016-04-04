#!/bin/bash
TCINSTANCEID=$(cat /opt/hybris/bin/platform/tcServer-6.0/TCINSTANCEID/logs/tcserver.pid)
DATE=$(date +"%Y-%m-%d")
WORKING_PATH="/data/hybris_data/prod/dump/store-001"

echo [$(date +"%Y-%m-%d %T")] dump script started
echo [$(date +"%Y-%m-%d %T")] tcServer PID: $TCINSTANCEID

# Create heap dump
jmap -dump:file=$WORKING_PATH/heapdump-$DATE.bin $TCINSTANCEID

# Create thread dump
jstack $TCINSTANCEID >> $WORKING_PATH/threaddumps-$DATE.log

cd $WORKING_PATH
gzip -f heapdump-$DATE.bin threaddumps-$DATE.log
chmod 744 *

echo [$(date +"%Y-%m-%d %T")] dump script ended
