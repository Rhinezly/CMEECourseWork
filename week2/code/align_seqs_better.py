#!/usr/bin/env python3

'''Align DNA sequences and find the best alignment.'''

__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'


## imports ##
import sys # module to interface our program with the operating system

# Two example sequences to match
def read_fasta(file1, file2):
    '''Take two FASTA file inputs and extract the sequences.'''
    def read_seq(file_path):
        with open(file_path, 'r') as f:
            next(f)  # skip the heading
            sequence = f.read()
        return sequence
    
    seq1 = read_seq(file1)
    seq2 = read_seq(file2)
    return seq1, seq2

# Decide wether files are default (../data/*.fasta) or explicit input (sys.argv)
file1 = sys.argv[1] if len(sys.argv) >1 else '../data/407228326.fasta'
file2 = sys.argv[2] if len(sys.argv) > 2 else '../data/407228412.fasta'

seq1, seq2 = read_fasta(file1, file2)

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths


## functions ##
# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
#calculate_score(s1, s2, l1, l2, 0)
#calculate_score(s1, s2, l1, l2, 1)
#calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
import pickle

def best_match(s1, s2, l1, l2):
    my_best_align = []
    my_best_score = -1

    for i in range(l1):  # take all the best alignments with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        align = "." * i + s2

        if z > my_best_score:
            my_best_align = [(align, s1, z)]  # write better alignment into the list
            my_best_score = z
        elif z == my_best_score:
            my_best_align.append((align, s1, z))  # add same best score to list

    with open('../results/my_best_match', 'wb') as f:
        pickle.dump(my_best_align, f)  # output the result (list) to 'results' directory

    with open('../results/my_best_match', 'rb') as f:
        best_match_list = pickle.load(f)  # open and read the result file
    
    print("Best alignments:")
    for align, s1, score in best_match_list:
        print(f"{align}\n{s1}\n{score}\n")  # print all the best alignments
    
    return 0

def main(argv):
    """ Main entry point of the program """
    calculate_score(s1, s2, l1, l2, 0)
    best_match(s1, s2, l1, l2)
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)