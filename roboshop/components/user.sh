#!/bin/bash

USER_ID=$(id -u)
COMPONENT=User
COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"

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

echo -n "configuring Nodejs Repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - 
stat $? 

echo -n "Installing Nodejs :"
yum install nodejs -y    &>>$LOGFILE
stat $?

echo -e "Creating $APPUSER:"
id $APPUSER       &>> $LOGFILE 
if [ $? -ne 0 ] ; then
   useradd $APPUSER
   stat $?
else 
   echo -e "\e[35m skipping \e[0m"
fi 

echo -n "Downloading $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL 
stat $? 

echo -n "Performing Cleaning of $COMPONENT:"
rm -rf $APPUSER_HOME &>> $LOGFILE 
stat $? 

echo -n "Extracting $COMPONENT :"
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip     &>> $LOGFILE  
stat $?

echo -n "Configuring $COMPONENT permissions :"
mv ${APPUSER_HOME}-main $APPUSER_HOME
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770 $APPUSER_HOME
stat $?

echo -n "Generating Artifacts :"
cd $APPUSER_HOME
npm install &>> $LOGFILE 
stat $? 

echo "Configurating the $COMPONENT systemd file :"
sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' ${APPUSER_HOME}/systemd.service 
sed -i -e 's/REDIS_ENDPOINT/redis.mongodb.roboshop.internal/' ${APPUSER_HOME}/systemd.service
mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting $COMPONENT service :"
systemctl daemon-reload &>> $LOGFILE 
systemctl enable $COMPONENT &>> $LOGFILE 
systemctl restart $COMPONENT &>> $LOGFILE 
stat $?

echo -e "***** \e[31m configuring frontend \e[0m *****"

