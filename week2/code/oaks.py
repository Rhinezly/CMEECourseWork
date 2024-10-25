#!/usr/bin/env python3

"""
This script identifies oak tree taxa from a predefined list of species names.
It provides two methods for identifying oaks: using traditional for loops and
list comprehensions. Additionally, it converts the names of the identified oaks
to uppercase format using both methods.
"""


## Find oak tree taxa from the list

taxa = ['Quercus robur',
        'Fraxinus excelsior',
        'Pinus sylvestris',
        'Quercus cerris',
        'Quercus petraea'
        ]

def is_an_oak(name):
    """Check if the given name is an oak species.

    Args:
        name (str): The name of the species.

    Returns:
        bool: True if the name starts with 'quercus', otherwise False.
    """
    return name.lower().startswith('quercus')  # or just return name.startswith('Quercus')

## Using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

## Using list comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

## Get names in upper case using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

## Get names in upper case using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)