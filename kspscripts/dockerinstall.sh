#!/bin/bash
sudo apt-get update &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  &&
sudo sh -c 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'  &&
sudo apt-get update  &&
apt-cache policy docker-ce  &&
sudo apt-get install -y docker-ce  &&
sudo docker pull sonatype/nexus  &&
sudo docker run -d -p 8081:8081 --name nexus sonatype/nexus:oss
