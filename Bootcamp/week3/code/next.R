for (i in 1:10) {
    if ((i %% 2) == 0)  # check if the number is odd
        next  # pass to next iteration of the loop
    print(i)
}
