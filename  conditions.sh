#!/bin/bash

number1=$1


if [ number1 -lt 10 ]
then
    echo "The number $number1 is less than 10"
else
    echo "The given number $number1 is greater than 10"
fi