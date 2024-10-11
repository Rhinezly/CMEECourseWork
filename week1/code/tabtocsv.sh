#!/bin/sh
# Author: l.zhou24@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024

if [ $# != 1 ]; then
        echo "Please provide a file input on the command line!"
        exit
fi

if [[ $1 != *.txt ]]; then
        echo "The input file should be a text (.txt) file!"
        exit
fi

if [ ! -f "$1" ]; then
        echo "File $1 does not exist!"
        exit
fi

echo "Creaing a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> ${1%.txt}.csv
echo "Done!"
exit