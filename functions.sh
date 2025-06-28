#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -eq 0 ]
then
    echo "You're running the commands with the root access"
else
    echo "You need root access to install any packages"
    exit 90
fi


# dnf list installed | grep nginx 

# if [ $? -eq 0 ]
# then
#     echo " Nginx is already installed"
# else
#     echo "Nginx is unavailable on your server"
#     dnf install nginx -y

#     if [ $? -eq 0 ]
#     then
#         echo "Nginx is installed"
#     else
#         echo "Failed to install the nginx"
#     fi
# fi


# dnf list installed | grep nodejs

# if [ $? -eq 0 ]
# then
#     echo " Nodejs is already installed"
# else
#     echo "Nodejs is unavailable on your server"
#     dnf install nodejs -y

#     if [ $? -eq 0 ]
#     then
#         echo "Nodejs is installed"
#     else
#         echo "Failed to install Nodejs"
#     fi
# fi



# dnf list installed | grep htop

# if [ $? -eq 0 ]
# then
#     echo "htop is already installed"
# else
#     echo "htop is unavailable on your server"
#     dnf install htop -y

#     if [ $? -eq 0 ]
#     then
#         echo "htop is installed"
#     else
#         echo "Failed to install htop"
#     fi
# fi

validate() {
    
    if [ $1 -eq 0 ]
    then
        echo "$2 is already installed"
    else
        echo "$2 is unavailable on your server"
        dnf install $2 -y

        if [ $? -eq 0 ]
        then
            echo "$2 is installed"
        else
            echo "Failed to install $2"
            exit 90
        fi
    fi
}

dnf list installed | grep nginx 

validate $? "nginx"

dnf list installed | grep nodejs
validate $? "nodejs"

dnf list installed | grep htop

validate $? "htop"
