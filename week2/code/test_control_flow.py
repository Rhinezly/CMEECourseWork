#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""

__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'

import sys # module to interface our program with the operating system
import doctest

def even_or_odd(x=0):  # if not specified, x should take value 0        
    """Find whether a number x is even or odd.
    
    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    in case of negative numbers, the positive is taken:
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """
    # Define function to be tested
    if x % 2 == 0:
        return f"{x} is Even!"
    return f"{x} is Odd!"

def main(argv):
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0

if __name__ == "__main__":
    status = main(sys.argv)

doctest.testmod()  # To run with embedded tests