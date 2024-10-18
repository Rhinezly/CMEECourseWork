# No pre-allocation
NoPreallocFun <- function(x) {
    a <- vector()  # empty vector
    for (i in 1:x) {
        a <- c(a, i)  # concatenate
        print(a)
        print(object.size(a))  # can see R resize the vector and re-allocate more memory (will get slow as vectors get big)
    }
}

system.time(NoPreallocFun(10))


# Pre-allocation
PreallocFun <- function(x) {
    a <- rep(NA, x) 
    for (i in 1:x) {
        a[i] <- i  # assign
        print(a)
        print(object.size(a))
    }
}

system.time(PreallocFun(10))
