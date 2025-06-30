#!/bin/bash

# for i in {1..100}
# do
#     echo $i
# done
PACKAGES=("nginx" "mysql" "python3" "htop")
USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
C="\e[37m"


LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="/$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo "$C script started executing at : $(date) $N" | tee -a $LOG_FILE


if [ $USER_ID -ne 0 ]
then
    echo -e $R"Error: You need the Root access to run the script $N" | tee -a $LOG_FILE
    exit 90
else
    echo -e $G"You've the Root access to run the script $N" | tee -a $LOG_FILE
fi

for package in ${PACKAGES[@]}
do
    dnf list installed $package &>> $LOG_FILE
    validate() "$?" "$package"
done

validate(){
    if [ $1 -ne 0 ]
    then
        echo "$Y$2 is unavailable on the server, let's install it $N" | tee -a $LOG_FILE
        dnf install $2 -y &>> $LOG_FILE

        if [ $? -eq 0 ]
        then
            echo "$G$2 is installed successfully $N" | tee -a $LOG_FILE
        else
            echo "$RFailed to install $2$N" | tee -a $LOG_FILE
        fi
    else
        echo "$Y$2 is already installed on your server$N" | tee -a $LOG_FILE
    fi
}