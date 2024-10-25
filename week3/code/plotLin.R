require(ggplot2)

# Create some random "data" for linear regression
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x +
  rnorm(length(x), mean = 0., sd = 2.5)

# put them in a dataframe
my_data <- data.frame(x = x, y = y)

# perform a linear regression
my_lm <- summary(lm(y ~ x, data = my_data))

# plot the data
p <-  ggplot(my_data, aes(x = x, y = y,
                          colour = abs(my_lm$residual))
             ) +
  geom_point() +  # add scatter plot points
  scale_colour_gradient(low = "black", high = "red") +  # colour points with low/high residuals in black/red
  theme(legend.position = "none") +  # remove the legend
  scale_x_continuous(
    expression(alpha^2 * pi / beta * sqrt(Theta)))  # write the x-axis label in mathematical expression

# add the regression line
p <- p + geom_abline(
  intercept = my_lm$coefficients[1][1],
  slope = my_lm$coefficients[2][1],
  colour = "red")  # colour the regression line in red
  
# throw some math on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2* pi"), 
                       parse = TRUE,  # Interpret the label as a mathematical expression
                       size = 6,  # set the text size
                       colour = "blue")

p

# Save the result graph
pdf("../results/MyLinReg.pdf", 10, 8.3)  # open blank pdf page
print(p)  # Print the graph to the PDF
dev.off()  # Close the PDF device
