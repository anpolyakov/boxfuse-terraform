#!/bin/bash
set -e
echo "*****    Installing Tomcat    *****"
apt update -y
apt install -y tomcat9

systemctl enable --now tomcat9

echo "*****    Installation Completed    *****"
echo "*****    Startup script completes! *****"    

