#!/bin/bash
set -e
echo "*****    Installing Tomcat    *****"
apt update -y
apt install -y tomcat9

systemctl enable --now tomcat9

echo "*****    Installation Completed    *****"

echo "*****    Deploy Java App    *****"
gcloud auth activate-service-account --key-file /tmp/credentials.json
gsutil cp gs://lesson14-app-storage/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
rm /tmp/credentials.json

echo "*****    Deployment completed    *****"
echo "*****    Startup script completes!    *****"    

