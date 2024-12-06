#!/usr/bin/env python3

"""
This script contains a series of functions that print 'hello' under various conditions.
Each function demonstrates different control flow mechanisms in Python, including loops and conditionals.
"""

def hello_1(x):
    """Print 'hello' for every number from 0 to x that is a multiple of 3."""
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)


def hello_2(x):
    """Print 'hello' for every number from 0 to x where the number modulo 4 or 5 equals 3."""
    for j in range(x):
        if j % 5 == 3 or j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)


def hello_3(x, y):
    """Print 'hello' for (y-x) times."""
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)


def hello_4(x):
    """
    Print 'hello' in increments of 3 until x reaches or surpasses 15.
    
    Note:
        The loop will stop if x surpasses 15 to prevent an infinite loop.
    """
    while x != 15:
        print('hello')
        x += 3  # Simplified increment syntax
        if x > 15:
            break  # Prevents infinite loop
    print(' ')

hello_4(0)
hello_4(1)


def hello_5(x):
    """
    Iterate from the given integer until x reaches 100, printing 'hello' under certain conditions. 
    The function will increment x by 1 in each iteration.
        
    Conditions:
        - If x equals 31, it prints 'hello' 7 times.
        - If x equals 18, it prints 'hello' once.
    """
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x += 1  # Consistent increment syntax
    print(' ')

hello_5(12)


def hello_6(x, y):
    """
    Print 'hello!' followed by the value of y, incrementing y each time, until a break condition is met.
    
    Args:
        x (bool): Condition to start the loop (typically True to enter the loop).
        y (int): Starting integer value that is incremented with each iteration.
        
    Note:
        The loop breaks if y reaches 6.
    """
    while x:
        print('hello!' + str(y))
        y += 1
        if y == 6:
            break
    print(' ')

hello_6(True, 0)