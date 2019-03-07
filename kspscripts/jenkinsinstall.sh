#!/bin/bash
sudo apt-get update && 
sudo apt install openjdk-8-jdk wget -y  && 
sudo sed -ei '\\$aJAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/bin/java' /etc/environment
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -  && 
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'  && 
sudo apt-get update  && 
sudo apt-get install jenkins -y
