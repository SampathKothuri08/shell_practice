#!/bin/bash

# echo "Hello world"

# echo -e "\e[31mHello world\e[0m"

# echo "Let's learn shell scripting"


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


USER_ID=$(id -u)

if [ USER_ID -ne 0 ]
then:
    echo -e "$R Error: You need root access to run this script $N"
    exit 90
else
    echo -e "$G You have root access to run the script $N"
fi


Validate(){

    if [ $1 -eq 0 ]
    then
        echo -e "$Y$2 is already installed on your server $N"
    else
        echo -e "$Y$2 is unavailable on your server, let's install it $N"
        dnf install $2 -y

        if [ $1 -ne 0]
        then
            echo -e "$R Error: Failed to install $2 $N"
        else
            echo -e "$G $2 is successfully installed $N"
        fi
    fi

}

dnf list installed nginx

Validate "$?" "nginx"


dnf list installed mysql
Validate $? "mysql"


dnf list installed python3
Validate $? "python3"

