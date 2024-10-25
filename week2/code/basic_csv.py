#!/usr/bin/env python3

"""
Basic script for reading and writing CSV files.

This script demonstrates how to read data from a CSV file and extract specific columns.
It also shows how to write a new CSV file with a subset of the data.
"""

import csv

## Read a csv file

with open('../data/testcsv.csv', 'r') as f:

    csvread = csv.reader(f)
    temp = []  # create a temporary list
    for row in csvread:
        temp.append(tuple(row))  # stores each row as a tuple in a list
        print(row)
        print("The species is", row[0])  # prints the species name from each row

## Write a file with only specie name and body mass

with open('../data/testcsv.csv', 'r') as f:
    with open('../data/bodymass.csv', 'w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])  # writes the species name and body mass columns to a new CSV file