#!/bin/bash
sudo apt-get update && 
sudo apt install openjdk-8-jdk wget -y  && 
sudo sed -ei '\\$aJAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre' /etc/environment
source /etc/environment
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -  && 
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'  && 
sudo apt-get update  && 
sudo apt-get install jenkins -y &&
sudo apt-get install awscli -y &&
echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee --append  /etc/sudoers.d/90-cloud-init-users
sudo apt-get install maven -y
#ls -al /etc/alternatives/java
#sudo update-alternatives --config java
#sudo sed -i -e "\$aJAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/bin/java" /etc/environment
#sudo sed -ie '$aJAVA_HOME=/usr/lafib/jvm/java-1.8.0-openjdk-amd64/jre/bin/java' /etc/environment
