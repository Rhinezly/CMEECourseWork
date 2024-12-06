#!/usr/bin/env python3

"""
Demonstrates debug methods using ipdb and "try...except...".
"""

def buggyfunc(x):
    """Perform a series of divisions of x by decreasing values of y, handling potential errors.

    Args:
        x (int): The number to be used for division.

    Returns:
        float: The last successful result of the division operation.
    
    Raises:
        ValueError: If x is less than or equal to zero, as division by zero will occur.
    """
    y = x
    for i in range(x):
        try:
            y = y -1
            # import ipdb; ipdb.set_trace()
            # the line adds a breakpoint at where you want to pause and start a debugging session
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; {x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }; {z = };")
    return z

buggyfunc(20)
