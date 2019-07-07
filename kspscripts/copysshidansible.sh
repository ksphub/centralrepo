#!/bin/bash

ANS_SERVER=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=AnsibleServer" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].[PrivateIpAddress]" --output=text)
ANS_NODE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=AnsibleNode" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].[PrivateIpAddress]" --output=text)

sshpass -f /var/lib/jenkins/jenkinspasswd ssh -o StrictHostKeyChecking=no ansible@$ANS_SERVER sshpass -f /tmp/tmppasswd  ssh-copy-id -o StrictHostKeyChecking=no  $ANS_NODE
