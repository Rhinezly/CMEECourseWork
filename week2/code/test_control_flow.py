#!/usr/bin/env python3

"""
This script exemplifies the use of control statements in Python.
It defines a function to determine whether a given number is even or odd,
and includes embedded tests using doctest.
"""

__appname__ = 'test_control_flow'
__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'


import sys  # Module to interface our program with the operating system
import doctest


def even_or_odd(x=0):
    """Determine whether a number x is even or odd.

    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """
    # Check if x is even or odd
    if x % 2 == 0:
        return f"{x} is Even!"
    return f"{x} is Odd!"

def main(argv):
    """Main function to demonstrate even_or_odd function."""
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0

if __name__ == "__main__":
    status = main(sys.argv)

doctest.testmod()  # Run embedded tests
