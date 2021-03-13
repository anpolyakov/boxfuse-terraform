#!/bin/bash
set -e
echo "*****    Installing Maven    *****"

apt update -y
apt install -y maven

echo "*****    Installation Completed    *****"

echo "*****    Building Java App    *****"

cd /tmp
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
cd boxfuse-sample-java-war-hello
mvn package

echo "*****    Build Completed    *****"

echo "*****    Copy artefact to bucket *****"

gcloud auth activate-service-account --key-file /tmp/credentials.json
gsutil cp target/hello-1.0.war gs://lesson14-app-storage/
rm /tmp/credentials.json

echo "*****    Copying completed *****"

echo "*****    Startup script completes! *****"    

