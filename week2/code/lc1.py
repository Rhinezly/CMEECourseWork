#!/usr/bin/env python3

"""
This script processes a tuple of bird species, extracting their Latin names,
common names, and mean body masses using both list comprehensions and 
conventional loops.
"""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.


# (1) Latin names
# List comprehension
latin = [i[0] for i in birds]
print("Latin names (list comprehension):", latin)

# Conventional loop
latin_loop = []
for i in birds:
    latin_loop.append(i[0])
print("Latin names (conventional loop):", latin_loop)

# (2) Common names
# List comprehension
common = [i[1] for i in birds]
print("Common names (list comprehension):", common)

# Conventional loop
common_loop = []
for i in birds:
    common_loop.append(i[1])
print("Common names (conventional loop):", common_loop)

# (3) Body masses
# List comprehension
mass = [i[2] for i in birds]
print("Body masses (list comprehension):", mass)

# Conventional loop
mass_loop = []
for i in birds:
    mass_loop.append(i[2])
print("Body masses (conventional loop):", mass_loop)
