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


## Latin names:
# (1) List comprehension:
latin = [i[0] for i in birds]
latin

# (2) Conventional loop:
latin = []
for i in birds:
    latin.append(i[0])
latin

## Common names
# (1)
common = [i[1] for i in birds]
common

# (2)
common = []
for i in birds:
    common.append(i[1])
common

## Body masses:
# (1)
mass = [i[2] for i in birds]
mass

# (2)
mass = []
for i in birds:
    mass.append(i[2])
mass
