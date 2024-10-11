#!/bin/bash

if [ $# != 3 ]; then
        echo "Please provide two input files and one output file on the command line!"
        exit
fi

if [ ! -f "$1" ]; then
        echo "File $1 does not exist!"
        exit
fi

if [ ! -f "$2" ]; then
        echo "File $2 does not exist!"
        exit
fi

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3