# shell-sripting
this is a repository created to host all the automation.
All the coding standards are close to best coding standard.

In this repo, we start everything from basic and follows sequenrial order.

my name is laetitia.

Shell is native to linux and had better native advantage with better performance

Ashumbay give me my money.

echo welcome to shell scripting

echo "welcome to shell scripting"


this repository is all the basics that are need to kickStart terrafrom-learning.

## what is terraform ? why we need it and why companies adopt terraform

HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

The core Terraform workflow consists of three stages:

**Write**: You define resources, which may be across multiple cloud providers and services. For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.
**Plan**: Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.
**apply**: On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.

HashiCorp co-founder and CTO Armon Dadgar explains how Terraform solves infrastructure challenges.



# To get an Image ID:  centos@ws ~ ]$ aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq .

# [ centos@ws ~ ]$ aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId"
# "ami-0f75a13ad2e340a58"

# [ centos@ws ~ ]$ aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId" | sed -e 's/"//g'
ami-0f75a13ad2e340a58

# 52.91.241.51 | 172.31.37.102 | t3.micro | null
# [ centos@ws ~ ]$ AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId" | sed -e 's/"//g')

# [ centos@ws ~ ]$ echo $AMI_ID
ami-0f75a13ad2e340a58

# how to get a security group
get the name of security group

# [ centos@ws ~ ]$ aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq .
# 52.91.241.51 | 172.31.37.102 | t3.micro | null
# [ centos@ws ~ ]$ aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq ".SecurityGroups[].GroupId"  | sed -e 's/"//g'
sg-085c32f91ae1c3c1a

# [ centos@ws ~ ]$ SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq ".SecurityGroups[].GroupId"  | sed -e 's/"//g')

# [ centos@ws ~ ]$ echo $SGID
sg-085c32f91ae1c3c1a

# to create a server to AWS
export AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq " .Images[].ImageId" | sed -e 's/"//g')
export SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56_allow_tls" | jq ".SecurityGroups[].GroupId"  | sed -e 's/"//g')
export COMPONENTS=(servername)
then run this
# aws ec2 run-instances --image-id ${AMI_ID} --istance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "RessourceType=instance, Tags=[{key=Name,Value=${COMPONENTS}}]" | jq .

# [ centos@ws ~ ]$ RATING_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENTS}}]" | jq ".Instances[].PrivateIpAddress")
# echo $RATING_IP
"172.31.32.31"
# ]$ RATING_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENTS}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')

#  echo $RATING_IP
172.31.35.113








