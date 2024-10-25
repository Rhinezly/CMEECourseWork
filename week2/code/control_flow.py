#!/usr/bin/env python3

"""
Some functions exemplifying the use of control statements.
"""

__appname__ = 'control_flow'
__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'

import sys  # Module to interface our program with the operating system

def even_or_odd(x=0):  # Default value of x is 0
    """Determine whether a number x is even or odd.

    Args:
        x (int, optional): The number to check. Defaults to 0.

    Returns:
        str: A message indicating whether x is even or odd.
    """
    if x % 2 == 0:
        return f"{x} is Even!"
    return f"{x} is Odd!"

def largest_divisor_five(x=120):
    """Find the largest divisor of x among 2, 3, 4, and 5.

    Args:
        x (int, optional): The number to check. Defaults to 120.

    Returns:
        str: A message indicating the largest divisor or that none was found.
    """
    largest = 0
    if x % 5 == 0:
        largest = 5
    elif x % 4 == 0:
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else:
        return f"No divisor found for {x}!"  # Each function can return a value or a variable
    return f"The largest divisor of {x} is {largest}"

def is_prime(x=70):
    """Determine whether an integer x is prime.

    Args:
        x (int, optional): The number to check. Defaults to 70.

    Returns:
        bool: True if x is prime, False otherwise.
    """
    if x < 2:
        return False  # Handle edge case for numbers less than 2
    for i in range(2, x):
        if x % i == 0:
            print(f"{x} is not a prime: {i} is a divisor")
            return False
    print(f"{x} is a prime!")
    return True

def find_all_primes(x=22):
    """Find all prime numbers up to x.

    Args:
        x (int, optional): The upper limit to find primes. Defaults to 22.

    Returns:
        list: A list of all prime numbers up to x.
    """
    allprimes = []
    for i in range(2, x + 1):
        if is_prime(i):
            allprimes.append(i)
    print(f"There are {len(allprimes)} primes between 2 and {x}")
    return allprimes

def main(argv):
    """Main function to execute the example functions.

    Args:
        argv (list): Command line arguments.

    Returns:
        int: Exit status of the program.
    """
    print(even_or_odd(22))
    print(even_or_odd(33))
    print(largest_divisor_five(120))
    print(largest_divisor_five(121))
    print(is_prime(60))
    print(is_prime(59))
    print(find_all_primes(100))
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)