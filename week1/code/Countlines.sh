#!/bin/bash

if [ $# != 1 ]; then
        echo "Please provide a file input on the command line!"
        exit
fi

if [ ! -f "$1" ]; then
        echo "File $1 does not exist!"
        exit
fi

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo