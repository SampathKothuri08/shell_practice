#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]
then
    echo "Please run the script with the root access"
    exit 90
else
    echo "You're running with the root access"
fi

dnf install nginx -y

if [ $? -ne 0 ]
then
    echo "Nginx is installed successfully"
else
    echo "Failed to install nginx"
fi

