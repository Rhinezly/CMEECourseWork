#!/user/bin/env python3

'''Some functions using control flows for basic calculation'''

__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'


## Imports ##
import sys # module to interface our program with the operating system
import doctest


## Functions ##
def foo_1(x=121):
    '''Calculate the square root of a number.
    
    >>> foo_1(16)
    'The square root of 16 is: 4.0'

    >>> foo_1(1)
    'The square root of 1 is: 1.0'

    '''

    return f"The square root of {x} is: {x ** 0.5}"


def foo_2(x=8, y=10):
    '''Find the larger one between two numbers.
    
    >>> foo_2(1, 2)
    '2 is larger'

    >>> foo_2(2, 1)
    '2 is larger'

    '''

    if x > y:
        return f"{x} is larger"
    return f"{y} is larger"


def foo_3(x=3, y=2, z=1):
    '''Sort three numbers from small to large.
    
    >>> foo_3(8, 3, 5)
    'From small to large: [3, 5, 8]'

    >>> foo_3(4, 7, 2)
    'From small to large: [2, 4, 7]'

    '''

    while x > y or y > z:  # make sure the loop won't stop before the sorting is done (or you'll get wrong output when x>y>z)
        if x > y:
            tmp = y
            y = x
            x = tmp
        if y > z:
            tmp = z
            z = y
            y = tmp
    return f"From small to large: {[x, y, z]}"


def foo_4(x=10):
    '''Calculate the factorial of x using FOR loop.
    
    >>> foo_4(1)
    'The factorial of 1 is: 1'

    >>> foo_4(3)
    'The factorial of 3 is: 6'

    '''

    result = 1
    for i in range(1, x + 1):
        result = result * i
    return f"The factorial of {x} is: {result}"


def foo_5(x=10):  # recursive funtion that calculates the factorial of x
    '''Calculate the factorial of x using recursive function.
    
    >>> foo_5(1)
    1

    >>> foo_5(3)
    6

    '''

    if x == 1:
        return 1
    return x * foo_5(x -1)


def foo_6(x=10):  # another way to calculate factorial
    '''Calculate the factorial of x using WHILE loop.
    
    >>> foo_6(1)
    1

    >>> foo_6(3)
    6

    '''

    facto = 1
    while x >=1:
        facto = facto * x
        x = x-1
    return facto


def main(argv):
    '''Test functions in this module'''
    print(f"foo_1(4) \n {foo_1(4)} \n")
    print(f"foo_2(0, 5) \n {foo_2(0, 5)} \n")
    print(f"foo_2(3, 1) \n {foo_2(3, 1)} \n")
    print(f"foo_3(3, 1, 2) \n {foo_3(3, 1, 2)} \n")
    print(f"foo_3(1, 3, 2) \n {foo_3(1, 3, 2)} \n")
    print(f"foo_4(4) \n {foo_4(4)} \n")
    print(f"foo_5(4) \n {foo_5(4)} \n")
    print(f"foo_6(4) \n {foo_6(4)} \n")
    return 0

if __name__ == "__main__":
    status = main(sys.argv)

doctest.testmod()  # to run embedded tests