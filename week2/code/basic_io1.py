#!/usr/bin/env python3

"""
Basic file input commands.

This script demonstrates how to read from a text file using different methods.
It covers basic reading, skipping blank lines, and using the `with open()` context manager.
"""

#########################
# File Input
#########################

# Open a file for reading
f = open('../sandbox/test.txt', 'r')  

# Use an "implicit" for loop:
# Python will automatically iterate over the lines in the file.
for line in f:
    print(line)

f.close()  # Close the file

# Skip blank lines while reading
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()  # Close the file

## Rewrite the above using "with open()"

# Use `with open()` to automatically handle file closure
with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        print(line)
# The file is automatically closed once the block is exited.

# Skip blank lines using `with open()`
with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)