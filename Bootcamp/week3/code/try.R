# A simulation that samples from a synthetic population with replacement
# and takes its mean,
# but only if sample size is larger than 30
doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {  # only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique values!")
        }
    }

# generate population
set.seed(1345)  # the get the same result for illustration
popn <- rnorm(50)
hist(popn)

# repeat the sampling 15 times
# lapply(1:15, function(i) doit(popn))
# this will get an error massage when the loop stop

# do the same using `try`
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

class(result)  # result stored as a list
result  # tells you which run ran into error and why
# store the result "manually"
result <- vector("list", 15)  # preallocation
for (i in 1:15){
    result [[i]] <- try(doit(popn), FALSE)
}
