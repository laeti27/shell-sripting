#!/bin/bash

# This script is going to create a servers
#SGID="sg-085c32f91ae1c3c1a"
# AMI_ID="ami-0f75a13ad2e340a58" # Hardcoding is a bas-choice particulary with AMI-ID as it's going to be chnged when you register a new AMI.
 if [ -z $1 ] || [ -z $2 ] ; then
    echo -e "\e[31m ****** COMPONENTS NAME & ENV ARE NEEDED ****** \e[0m \n\t\t"
    echo -e "\e[36m \t\t Example usage : \e[0m bash create-ec2 ratings dev"
    exit 1
fi

COMPONENTS=$1
ENV=$2
HOSTEDZONEID="Z08751963MBUTMW6KV5BY"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq ".SecurityGroups[].GroupId"  | sed -e 's/"//g')
INSTANT_TYPE="t3.micro"

create_server() {
    echo -e "******* \e[32m $COMPONENTS-$ENV \e[0m Server Creation In Progress *******!!!!!!"

    PRIVATE_ID=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENTS}}]" | jq ".Instances[].PrivateIpAddress")
    echo -e "****** \e[32m $COMPONENTS-$ENV \e[0m DNS Record Creation Is Completed ****** !!!!!! \n\n"
 
    echo -e "******* \e[32m $COMPONENTS-$ENV \e[0m DNS Record Creation In Progress ******* !!!!!!"
    sed -e "s/COMPONENTS/${COMPONENTS}-${ENV}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json\
    echo -e "****** \e[32m $COMPONENTS-$ENV \e[0m DNS Record Creation Is Completed ****** !!!!!! \n\n"
}

# if the user supplies all as the first argument, the all these servers will be created.
if [ "$1" == "all" ]; then
   
   for component in mongodb catalogue cart user shipping frontend payment mysql redis rabbiting; do 
       COMPONENTS=$components 
       create_server 
    done

else
    create_server
fi        

