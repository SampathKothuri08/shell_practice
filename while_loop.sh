#!/bin/bash

# a=0

# while [ $a -lt 5 ]
# do
#     echo $a
#     a=$(($a+1))
# done

while IFS= read -r line
do
    echo $line
done < sets.sh