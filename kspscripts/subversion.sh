#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install subversion libapache2-mod-svn libsvn-dev -y
sudo a2enmod dav
sudo a2enmod dav_svn
sudo service apache2 restart
sudo cp dav_svn.conf /etc/apache2/mods-enabled/dav_svn.conf
sudo service apache2 restart
sudo mkdir -p /var/lib/svn/
sudo svnadmin create /var/lib/svn/myrepo
sudo chown -R www-data:www-data /var/lib/svn
sudo chmod -R 775 /var/lib/svn
sudo htpasswd -cmb /etc/apache2/dav_svn.passwd admin  admin123
sudo htpasswd -mb /etc/apache2/dav_svn.passwd user1 user123
