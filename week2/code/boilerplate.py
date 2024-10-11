#!/usr/bin/env python3

"""Description of this program or application.
You can use several lines"""
# """ """ are docstrings, they are part of the running code.
# (normal comments are stripped)
# You can access docstrings at run time. 
# import my_func and then help(my_func) or ?my_func in shell to see them.

__appname__ = '[application name here]'
__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this program"

## imports ##
import sys # module to interface our program with the operating system

## constants ##


## functions ##
def main(argv):
    """ Main entry point of the program """
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)