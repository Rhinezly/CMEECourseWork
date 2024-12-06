#!/usr/bin/env python3

"""
Basic binary file output commands using `pickle`.

This script demonstrates how to store and retrieve Python objects in a binary file using the `pickle` module.
"""

###############################
# Storing Objects
###############################

# Save an object for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

# Save the dictionary object to a binary file
f = open('../sandbox/testp.p', 'wb')  # b: accept binary files; 'wb' mode to write binary files.
pickle.dump(my_dictionary, f)
f.close()

# Load the dictionary object from the binary file
f = open('../sandbox/testp.p', 'rb')  # 'rb' mode to read binary files.
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)