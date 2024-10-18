M <- matrix(runif(1000000), 1000, 1000)

SumAllElements <- function(M) {  # use loop to sum up elements one by one
    Dimensions <- dim(M)
    Tot <- 0
    for (i in 1:Dimensions[1]) {
        for (j in 1:Dimensions[2]) {
            Tot <- Tot + M[i, j]
        }
    }
    return(Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))  # `system.time` calculates how much time your code takes

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))  
# `sum()` uses vectorization and avoid the amount of looping like `SumAllElements`, so it's much faster
