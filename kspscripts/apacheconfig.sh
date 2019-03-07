#!/bin/bash
sudo cp /tmp/apachefiles/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml && 
sudo cp /tmp/apachefiles/manager-context.xml /opt/tomcat/webapps/manager/META-INF/context.xml && 
sudo cp /tmp/apachefiles/host-manager-context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml && 
sudo cp /tmp/apachefiles/tomcat.service /etc/systemd/system/tomcat.service && 
cd /opt/tomcat && 
sudo chgrp -R tomcat /opt/tomcat && 
sudo chmod -R g+r conf && 
sudo chmod g+x conf && 
sudo chown -R tomcat webapps/ work/ temp/ logs/ && 
sudo systemctl daemon-reload && 
sudo systemctl start tomcat && 
sudo systemctl enable tomcat 
