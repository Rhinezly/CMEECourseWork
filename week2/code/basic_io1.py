#########################
# File input
#########################

f = open('../sandbox/test.txt', 'r')  # Open a file for reading

# use "implicit" for loop:
# for files, python will cycle over lines
for line in f:
    print(line)

f.close()  # close the file

# Skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()



## Rewrite the above using "with open()"

with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        print(line)
# file automatically closed once drop out of the with

with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)