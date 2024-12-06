rm(list=ls())  # clear the previous workspace

## Load and explore data
load("../data/KeyWestAnnualMeanTemperature.RData")

ls()
class(ats)
head(ats)
plot(ats)

## Compute correlation coefficient between years and Temperature and store it
observed_cor <- cor(ats$Year, ats$Temp)
observed_cor # check the result


## Randomly reshuffle the temperatures
## and recalculate the correlation coefficients (and store it)

# Number of repetitions
set.seed(12345)
n_repeats <- 10000

# Vector to store the correlation results
random_cor <- numeric(n_repeats)

# Repeat the correlation calculation with reshuffled temperatures
for (i in 1:n_repeats) {
    reshuffled_temp <- sample(ats$Temp)  # Randomly reshuffle temperatures
    random_cor[i] <- cor(ats$Year, reshuffled_temp)
}

# Check the first few results
head(random_cor)
range(random_cor)


## Calculate what fraction of the random correlation coefficients were greater
## than the observed one (as the approximate, asymptotic p-value).

# Calculate the fraction
approx_p <- mean(random_cor > observed_cor)

# Print the result
approx_p

# Create a base plot
plot <- ggplot(ats, aes(x = Year, y = Temp)) +
  geom_point(color = "blue", alpha = 0.4) +       # Scatter plot of the data
  theme_classic() +                               # Use the classic theme
  labs(
    x = "Year",
    y = "Temperature"
  )

# Add regression line with 95% CI
p <- plot +
  geom_smooth(
    method = "lm", # Linear regression
    formula = y ~ x, # Formula for the regression line
    color = "red", # Line color
    fill = "lightpink", # Confidence interval fill color
    level = 0.95 # 95% confidence interval
  )

# Display the plot
print(p)

# Save the result graph
pdf("../results/Florida.pdf", 6, 3)  # open blank pdf page
print(p)  # Print the graph to the PDF
dev.off()  # Close the PDF device
