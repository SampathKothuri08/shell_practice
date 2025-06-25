#!/bin/bash

echo "Hello world"

person1=$1
person2=$2


echo "$person1 : Hey, how's it going ?"

echo "$person2 : hello there! just gearing up for my exam"

echo "$person1 : Enter your student id here"

read -s "Student_ID"

echo "$person2's student ID is $Student_ID"


number1=100
number2=200

sum=$((number1 + number2))

echo "sum of $number1 and $number2 is $sum"



series=("modern family" "friends" "stranger things")

echo "First series : ${series[0]}"

echo "second favorite series : ${series[1]}"
echo "All the series that's on the list : ${series[@]}"

TIMESTAMP=$(date)

echo "This conversation ended at : $TIMESTAMP"