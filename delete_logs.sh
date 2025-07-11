#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/deleted-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR="/home/ec2-user/app-logs"

if [ $USER_ID -ne 0 ]
then
    echo -e "${R}You need root privileges to run this script ${N}" | tee -a $LOG_FILE 
    exit 90
else
    echo -e "${G}You have the root privileges, you can run the script ${N}" | tee -a $LOG_FILE
fi 

Validate(){

    if [ $? -ne 0 ]
    then
        echo -e "${R}This command is a failure ${N}"  | tee -a $LOG_FILE
        exit 90
    else
        echo -e "${G}This command is a success ${N}" | tee -a $LOG_FILE
    fi
}

mkdir -p $LOGS_FOLDER

echo -e "${Y}Script started executing at $(date) ${N}" | tee -a $LOG_FILE
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14) &>> $LOG_FILE




while IFS= read -r file_path
do
    rm -rf $file_path

done <<< $FILES