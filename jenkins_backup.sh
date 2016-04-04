#!/bin/bash
# Part 1 of 2 - This script should be scheduled on a jenkins server
cd /u02/jenkins
DATE=$(date +"%Y-%m-%d")
sudo rm -rf /u02/jenkins_backup
sudo mkdir -p /u02/jenkins_backup
sudo chown jenkins:jenkins /u02/jenkins_backup
tar czvf ../jenkins_backup/jenkins_backup_$DATE.tgz ./ --exclude='workspace' --exclude='monitoring' --exclude='tools' --exclude='.sonar' --exclude='jobs/*/builds'
ls -alh ../jenkins_backup


#!/bin/bash
# Part 2 of 2 - This script should be scheduled on a backup server
DATE=$(date +"%Y-%m-%d")
REMOTE_SERVER=10.xxx.xxx.xxx # jenkins server's IP address
REMOTE_SERVER_PATH=/u02/jenkins_backup
LOCAL_PATH=/home/support/jenkins_backup

echo [$(date +"%Y-%m-%d %T")] Get jenkins_backup started

rm -f $LOCAL_PATH/*

scp -c arcfour hybris@$REMOTE_SERVER:$REMOTE_SERVER_PATH/jenkins_backup_$DATE.tgz $LOCAL_PATH/

echo [$(date +"%Y-%m-%d %T")] Get jenkins_backup finished
