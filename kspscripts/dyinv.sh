#!/bin/bash
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
chmod u+x ec2.py ec2.ini
sudo apt-get install python-boto -y
