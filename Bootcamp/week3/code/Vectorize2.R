# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}

print("Stochastic Ricker takes:")
print(system.time(stochrick()))


# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance:

stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  # initialize empty matrix

  N[1, ] <- p0

  # from 2 to numyears, calculating the population size for each year
  for (yr in 2:numyears)
  {
    # Update the population size for the current year (N[yr,]) based on the previous year's size (N[yr - 1,])
    # include a random fluctuation drawn from a normal distribution
    N[yr, ] <- N[yr - 1, ] * exp(r * (1 - N[yr - 1, ] / K) + rnorm(1, 0, sigma))
  }

  return(N)

}

print("Vectorized Stochastic Ricker takes:")
print(system.time(stochrickvect()))  # print execution time
