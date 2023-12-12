#!/bin/bash

USER_ID=$(id -u)
COMPONENT=$1

if [ $USER_ID -ne 0 ] ; then
   echo -e "\e[31m This script is expected to be executed with sudo or as a root user \e[0m"
   echo -e "\e[35m Example Usage: \n\t\t \e[0m sudo bash scriptName componentName"
   exit 1
fi

echo -e"***** \e[35m configuring frontend \e[0m *****"

echo -n "Install Nginx :"
yum install nginx -y      &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi

echo -n "Downloading component $1 :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi

echo -n "Cleanup of $1 component : "
cd /usr/share/nginx/html
rm -rf *          &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi

echo -n "Extrating $1: "
unzip /tmp/frontend.zip     &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi

echo -n "Configuring $1: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi

echo -n "Restarting $1: "
systemctl enable nginx     &>> /tmp/frontend.log
systemctl daemon-reload    &>> /tmp/frontend.log
systemctl restart nginx    &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
   echo -e "\e[32m success \e[0m"
else 
   echo -e "\e[31m failure \e[0m"   
fi


 
 