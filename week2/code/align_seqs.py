#!/usr/bin/env python3

"""
Align two DNA sequences from an arbitrary startpoint and find the best alignment.

This script reads two DNA sequences from a CSV file, compares them to find the best alignment
starting from different positions, and identifies the alignment with the highest match score.
The longest sequence is used as the reference, and the shorter one is aligned to it.
"""

__appname__ = 'align_seqs'
__author__ = 'Laiyin Zhou (l.zhou24@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys  # Module to interface our program with the operating system.
import csv  # Module to read CSV files.

# Two example sequences to match.
with open('../data/sequences.csv', 'r') as f:
    seq1, seq2 = [row['sequence'] for row in csv.DictReader(f)]  
    # Reads the CSV as a dictionary and assigns the value of the 'sequence' column to seq1 and seq2.

# Print to verify loaded sequences.
print(f"Seq1: {seq1}")
print(f"Seq2: {seq2}")

# Determine the longer and shorter sequences.
# l1 is the length of the longest, and l2 is the length of the shortest.

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1  # Swap the two lengths.


## functions ##

def calculate_score(s1, s2, l1, l2, startpoint):
    """
    Calculate and return the matching score (number of matches) starting from a given startpoint.

    Parameters:
        s1 (str): The longer DNA sequence.
        s2 (str): The shorter DNA sequence.
        l1 (int): Length of the longer DNA sequence.
        l2 (int): Length of the shorter DNA sequence.
        startpoint (int): The starting index for alignment.

    Returns:
        The score indicating the number of matches from the startpoint.
    """
    matched = ""  # String to hold a visual representation of alignments.
    score = 0  # Counter for the number of matches.

    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:  # If the bases match
                matched += "*"  # mark the matched point
                score += 1
            else:
                matched += "-"  # mark the unmatched point

    # Print formatted alignment output.
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score


def best_match():
    """
    Find and print the best alignment for two sequences with the highest match score.

    Uses the calculate_score function to iterate over possible startpoints for alignment
    and finds the one with the maximum score.
    """
    my_best_align = None
    my_best_score = -1

    for i in range(l1):  # Iterate over possible startpoints.
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2  # Format the output for the best alignment.
            my_best_score = z 

    # Print the best alignment and its score.
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)


def main(argv):
    """
    Main entry point of the program.

    Runs the score calculation from the startpoint of 0 and then searches for the best match.

    Parameters:
        argv (list): Command-line arguments.
    """
    calculate_score(s1, s2, l1, l2, 0)
    best_match()
    return 0


if __name__ == "__main__":
    """
    Ensures the main function is called when the script is executed from the command line.
    """
    status = main(sys.argv)
    sys.exit(status)