#!/usr/bin/env python3

"""
This script processes monthly rainfall data for the UK in 1910,
extracting months with rainfall greater than 100 mm and less than 50 mm
using both list comprehensions and conventional loops.
"""

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.



# (1) Months and rainfalls with the amount of rain greater than 100mm:
# List comprehension
greater_100_rainfall = [n for n in rainfall if n[1] > 100]
print("Months and rainfall values when the amount of rain was greater than 100mm (list comprehension):", greater_100_rainfall)

# Conventional loop
greater_100_rainfall_loop = []
for n in rainfall:
    if n[1] > 100:
        greater_100_rainfall_loop.append(n)
print("Months and rainfall values when the amount of rain was greater than 100mm (conventional loop):", greater_100_rainfall_loop)

# (2) Months with the amount of rain less than 50mm:
# List comprehension
less_50_rainfall = [n[0] for n in rainfall if n[1] < 50]
print("Months with rainfall less than 50mm (list comprehension):", less_50_rainfall)

# Conventional loop
less_50_rainfall_loop = []
for n in rainfall:
    if n[1] < 50:
        less_50_rainfall_loop.append(n[0])  # Append only the month name
print("Months with rainfall less than 50mm (conventional loop):", less_50_rainfall_loop)
