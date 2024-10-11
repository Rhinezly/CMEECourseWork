#!/bin/sh
# Author: Laiyin Zhou (l.zhou24@imperial.ac.uk)
# Script: csvtospace.sh
# Description: converts a csv file to a space seperated values file.
# Saves the output into a new .txt file
# Arguments: 1 -> comma delimited file
# Date: Oct 2024

if [ $# != 1 ]; then
        echo "Please provide a file input on the command line!"
        exit
fi

if [[ $1 != *.csv ]]; then
        echo "The input file should be a CSV (.csv) file!"
        exit
fi

if [ ! -f "$1" ]; then
        echo "File $1 does not exist!"
        exit
fi

echo "Creating a space seperated version of $1 ..."
cat $1 | tr -s "," "\t" >> ${1%.csv}.txt
echo "Done!"
exit