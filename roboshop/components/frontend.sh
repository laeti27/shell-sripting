#!/bin/bash

USER_ID=$(id -u)
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"

stat() {
   if [ $1 -eq 0 ] ; then 
       echo -e "\e[32m Success \e[0m"
   else 
       echo -e "\e[31m Failure \e[0m"
   fi 
}

if [ $USER_ID -ne 0 ] ; then
   echo -e "\e[31m This script is expected to be executed with sudo or as a root user \e[0m"
   echo -e "\e[35m Example Usage: \n\t\t \e[0m sudo bash scriptName componentName"
   exit 1
fi

echo -e "***** \e[31m configuring frontend \e[0m *****"

echo -n "Install Nginx :"
yum install nginx -y      &>> $LOGFILE
stat $?

echo -n "Downloading component $COMPONENT :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Cleanup of $COMPONENT component : "
cd /usr/share/nginx/html
rm -rf *          &>> $LOGFILE

echo -n "Extrating $COMPONENT: "
unzip /tmp/frontend.zip     &>> $LOGFILE

echo -n "Configuring $COMPONENT: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting $COMPONENT: "
systemctl enable nginx     &>> $LOGFILE
systemctl daemon-reload    &>> $LOGFILE
systemctl restart nginx    &>> $LOGFILE
stat $?

echo -e "***** \e[31m $COMPONENT Configuration Is Completed \e[0m *****" 





 
 