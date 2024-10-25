## load ggplot2 for plotting
require(ggplot2)

## Build a function to calculate the elipse
build_elipse <- function(hradius, vradius){
    npoints = 250
    a <- seq(0, 2 * pi, length = npoints + 1)
    x <- hradius * cos(a)
    y <- vradius * sin(a)
    return(data.frame(x = x, y = y))
}


N <- 250  # assign the size of the matrix
M <- matrix(rnorm(N * N), N, N)  # build the matrix
eigvals <- eigen(M)$values  # find the eigenvalues
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals))  # build a dataframe
my_radius <- sqrt(N)  # calculate the radius of the circle
ellDF <- build_elipse(my_radius, my_radius)  # dataframe to plot the elipse
names(ellDF) <- c("Real", "Imaginary")  # rename the columns


## Plotting
# plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
    geom_point(shape = I(3)) +
    theme(legend.position = "none")

# add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

# add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p


## Output the result figure into results directory
dir.create("../results", showWarnings = FALSE)  # Create the directory if it doesn't exist
ggsave("../results/Girko.pdf", plot = p)