#!/usr/bin/env python3

"""
This script creates a dictionary mapping taxonomic orders to sets of taxa 
derived from a predefined list of taxa. It includes a standard approach 
and a list comprehension method to achieve the same result.
"""

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

#### Your solution here #### 
taxa_dic = {}
for n in taxa:
    taxa_dic[n[0]] = n[1]

taxa_dic

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Your solution here #### 
taxa_dic = {n[0]: n[1] for n in taxa}
taxa_dic