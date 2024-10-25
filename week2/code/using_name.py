#!/usr/bin/env python3
# Filename: using_name.py

"""
This script demonstrates the use of the special variable `__name__` in Python.
When run as a standalone program, it indicates that it is being executed by itself. 
When imported as a module in another script, it identifies that it is being imported.
"""

if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from another script/program/module!')

print("This module's name is: " + __name__)