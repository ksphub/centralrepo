#!/bin/bash
sudo apt-get update && 
sudo apt-get install default-jdk -y && 
sudo groupadd tomcat && 
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat && 
cd /tmp && 
curl -O http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38.tar.gz && 
sudo mkdir /opt/tomcat && 
sudo tar xzvf apache-tomcat-8.5.38.tar.gz -C /opt/tomcat --strip-components=1 
