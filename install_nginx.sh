#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]
then
    echo "Please run the script with the root access"
    exit 90
else
    echo "You're running with the root access"
fi

dnf list installed | grep nginx 

if [ $? -eq 0 ]
then
    echo "Nginx is already installed on your server"
else
    echo "Nginx is unavailable on your server"
    dnf install nginx -y

    if [ $? -eq 0 ]
    then
        echo "Nginx is installed successfully"
    else
        echo "Failed to install the Nginx"
    fi
fi

    

