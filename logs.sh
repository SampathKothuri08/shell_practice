 #!/bin/bash



R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/logs/shellscript-logs"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo "script started executing at : $(date)" &>> $LOG_FILE



USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]
then
    echo -e "$R Error: You need root access to run this script $N" &>> $LOG_FILE
    exit 90
else
    echo -e "$G You have root access to run the script $N" &>> $LOG_FILE
fi


Validate(){

    if [ $1 -eq 0 ]
    then
        echo -e "$Y$2 is already installed on your server $N" &>> $LOG_FILE
    else
        echo -e "$Y$2 is unavailable on your server, let's install it $N" &>> $LOG_FILE
        dnf install $2 -y &>> $LOG_FILE

        if [ $? -ne 0 ]
        then
            echo -e "$R Error: Failed to install $2 $N" &>> $LOG_FILE
        else
            echo -e "$G $2 is successfully installed $N" &>> $LOG_FILE
        fi
    fi

}

dnf list installed nginx &>> $LOG_FILE

Validate "$?" "nginx"


dnf list installed mysql &>> $LOG_FILE
Validate $? "mysql"


dnf list installed python3 &>> $LOG_FILE
Validate $? "python3"

