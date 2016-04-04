#!/bin/bash
WORKING_PATH="/data/hybris_data/prod/dump/store-001"

cd $WORKING_PATH
echo [$(date +"%Y-%m-%d %T")] Below files are removed
ls -1
# removing all the files in the WORKING_PATH,
# assuming files are already copied over to other machines by another script
yes | rm *
