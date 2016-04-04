#!/bin/bash
DATE=$(date +"%Y-%m-%d")
ENV="prod-000"
WORKBENCH_HOST=10.xxx.xxx.xxx
WORKBENCH_PORT=8006
ENDECA_APP="/opt/software/endeca/apps/site"
ENDECA_BIN="/opt/software/endeca/PlatformServices/6.1.3/bin"
NEXUS_URL="https://prod-nexus.site.com"

echo [$(date +"%Y-%m-%d %T")] Endeca backup script started

cd $ENDECA_APP/config;rm -r wsconfig;mkdir wsconfig

$ENDECA_BIN/emgr_update --host $WORKBENCH_HOST:$WORKBENCH_PORT --action get_all_settings --prefix site --dir $ENDECA_APP/config/wsconfig --app_name site

yes | $ENDECA_BIN/emgr_update --host $WORKBENCH_HOST:$WORKBENCH_PORT --action get_post_forge_dims --prefix site --dir $ENDECA_APP/config/wsconfig --app_name site

cd $ENDECA_APP;tar -zcvf ~/$ENV-$DATE.tgz config/wsconfig data/state;cd ~

curl -v -F r=releases -F hasPom=false -F e=zip -F g=com.site -F a=endeca_backup -F v=$ENV-$DATE -F p=zip -F file=@$ENV-$DATE.tgz -u jenkins-upload:xxxxx! $NEXUS_URL:8081/nexus/service/local/artifact/maven/content

echo [$(date +"%Y-%m-%d %T")] Endeca backup script completed
