Exponential <- function(NO = 1, r = 1, generations = 10) {
    # Runs a simulation of exponential growth
    # Returns a vector of length generations

    N <- rep(NA, generations)  # create a vecor of NA

    N[1] <- NO
    for (t in 2:generations) {
        N[t] <- N[t-1] * exp(r)
        browser()
    }
    return (N)
}

plot(Exponential(), type = "l", main = "Exponential growth")