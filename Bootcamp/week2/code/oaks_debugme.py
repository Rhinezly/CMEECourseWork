#!/usr/bin/env python3

import csv
import sys
import doctest

"""
This script processes a CSV file containing taxonomic data, identifies oak species 
based on their genus name, and writes the corresponding data to a new CSV file.
"""

def is_an_oak(name):
    """Check if the given name is an oak species.

    Returns True if the name starts with 'quercus'.

    >>> is_an_oak('quercus')
    True

    >>> is_an_oak('Quercus')
    True

    >>> is_an_oak('Pinus')
    False

    >>> is_an_oak('Quercuss')
    False
    
    """
    return name.lower().startswith('quercus') and len(name) == 7

def main(argv):
    """
    Main function to read taxonomic data, identify oaks, and write to a new CSV.
    """
    # Open the input and output CSV files
    with open('../data/TestOaksData.csv', 'r') as f, open('../results/JustOaksData.csv', 'w') as g:
        taxa = csv.reader(f)
        csvwrite = csv.writer(g)
        
        for row in taxa:
            print(row)
            print("The genus is:")
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])

    return 0
    
if __name__ == "__main__":
    status = main(sys.argv)
    doctest.testmod()
