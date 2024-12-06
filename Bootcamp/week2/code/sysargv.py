#!/usr/bin/env python3

"""
This script demonstrates the use of command-line arguments in Python.
It prints the name of the script, the number of arguments passed, and the arguments themselves.

Usage:
    python script_name.py arg1 arg2 ...
"""

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: ", str(sys.argv))