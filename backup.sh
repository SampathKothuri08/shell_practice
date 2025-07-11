#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/backup-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR="$1"
DEST_DIR="$2"
DAYS=${3:-14}

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


USAGE(){
    echo -e "${R} Usage::$N sh backup.sh <Source-directory> <destination-directory> <days(optional)>"
    exit 90
}


if [ $# -lt 2 ]
then
    USAGE
fi



if [ ! -d $SOURCE_DIR ]
then
    echo -e "${R}Source directory $SOURCE_DIR doesn't exit ${N}"
    exit 90
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "${R}Destination directory $DEST_DIR doesn't exit ${N}"
    exit 90
fi

dnf install zip -y &>> $LOG_FILE

Validate $? "Installed zip function" 

FILES=$(find $SOURCE_DIR -type f -mtime +$DAYS) 

if [ ! -z "$FILES" ]
then
    echo "Files to be zipped are : $FILES" | tee -a $LOG_FILE
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -type f -mtime +$DAYS | zip -@ "$ZIP_FILE"
    
    if [ -f $ZIP_FILE ]
    then
        echo "successfully created zip file" | tee -a $LOG_FILE
        while IFS= read -r line
        do
            rm -rf $line

        done <<< $FILES
        echo "Log files older than $DAYS were removed from the source directory" | tee -a $LOG_FILE
    else
        echo -e "${R}Zip file creation is a failure ${N}" | tee -a $LOG_FILE
        exit 90
    fi
else
    echo "No log files older than $DAYS have been found " | tee -a $LOG_FILE
fi





echo -e "${Y}Script executed successfully ${N}" | tee -a $LOG_FILE
