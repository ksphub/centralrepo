#!/bin/bash
aws_access_key_id=$(cat ~/.aws/credentials | grep -i aws_access_key_id | awk -F " " '{ print $3 }')
aws_secret_access_key=$(cat ~/.aws/credentials | grep -i aws_secret_access_key | awk -F " " '{ print $3 }')
TFVAR="/var/lib/jenkins/tftasks/terraform.tfvars"
mkdir /var/lib/jenkins/tftasks/
touch $TFVAR ; > $TFVAR
echo 'aws_access_key_id = "kspaccessid"' > $TFVAR
echo 'aws_secret_access_key = "kspsecretid"' >> $TFVAR
sed -i 's/kspaccessid/'$aws_access_key_id'/g' $TFVAR
sed -i 's/kspsecretid/'$aws_secret_access_key'/g' $TFVAR
