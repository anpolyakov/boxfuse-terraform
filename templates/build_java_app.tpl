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

echo "*****    Building Completed    *****"

echo "*****    Startup script completes! *****"    

