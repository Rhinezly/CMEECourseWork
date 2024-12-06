#!/usr/bin/env python3

"""
Basic file output command.

This script demonstrates how to write a list of elements to a text file.
Each element is written on a new line.
"""

######################
# File Output
######################

list_to_save = range(100)  # Save the elements of a list to a file

f = open('../sandbox/testout.txt', 'w')
for i in list_to_save:
    f.write(str(i) + '\n')  # add a newline at the end

f.close()  # Close the file
