#!/bin/bash
echo Configuring Ansible Master
sudo useradd -c 'Ansible User' -m -d /home/ansible -s /bin/bash ansible
echo  \"ansible ALL=(ALL) NOPASSWD:ALL\" | sudo tee --append  /etc/sudoers.d/90-cloud-init-users
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
sudo echo -e '\n\n\n' | sudo -u ansible -- ssh-keygen -t rsa -N ''
sudo sed -i 's#ansible:!#ansible:$6$VvE3RiZW$afrzusqN.jBWERtwPxVWmLgG3NxG/kO7TwAl1.Cwth13OS1P1oBP9qBMaJO2evCJ9/eU7HovwdGazl5jPXPP5/#g' /etc/shadow
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo admin123 > /tmp/tmppasswd
echo Successfully Configured Ansible Master
