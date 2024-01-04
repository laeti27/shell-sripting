#!/bin/bash

# This script is going to create a servers
#SGID="sg-085c32f91ae1c3c1a"
# AMI_ID="ami-0f75a13ad2e340a58" # Hardcoding is a bas-choice particulary with AMI-ID as it's going to be chnged when you register a new AMI.


COMPONENTS=$1
HOSTEDZONEID="Z05014054AQKS3H9I2B2"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq ".SecurityGroups[].GroupId"  | sed -e 's/"//g')
INSTANT_TYPE="t3.micro"

echo -e "******* \[32m $COMPONENTS \e[0m Server Creation In progress *******!!!!!!"
PRIVATE_ID=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENTS}}]" | jq ".Instances[].PrivateIpAddress")

echo -e "******* \[32m $COMPONENT \e[0m DNS Record Creation In Progress ******* !!!!!!"
sed -e "s/COMPONENTS/${COMPONENTS}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json
aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file://tmp/dns.json