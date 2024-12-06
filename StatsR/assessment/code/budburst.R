# Research question:
# Do larger trees budburst earlier or later than smaller trees?


############## Data wrangling ##############

## Import data
trees <- read.csv("../data/trees.csv", header = TRUE)
bud <- read.csv("../data/phenology.csv", header = TRUE)
girth <- read.csv("../data/girth.csv", header = TRUE)

str(trees)
str(bud)
str(girth)

# Load the required package
library(dplyr)
library(lubridate)

# Convert the Date column to Date format
bud$Date <- dmy(bud$Date)  # Assuming Date format is dd/mm/yyyy

# Create a new column in bud to classify the Date into two categories (2007-2015, or 2016-2019)
bud <- bud %>%
  mutate(
    Date_range = case_when(
      year(Date) >= 2007 & year(Date) <= 2015 ~ "2007-2015",
      year(Date) >= 2016 ~ "2016-2019",
    )
  )

bud$Date_range <- as.character(bud$Date_range)

# Create a new column in girth to classify the Date into the same ranges
girth$Date_range <- girth$Date

# Remove any newline characters from the Date_range column in girth
girth$Date_range <- gsub("\n", "", girth$Date_range)

# Verify by checking the first few rows of the Date_range column
head(girth$Date_range)

# Merge the two dataframes based on TreeID and the Date_range
temp <- merge(bud, girth, by = c("TreeID", "Date_range"))
trees_merged <- merge(temp, trees, by = c("TreeID"))

# View the merged data
head(trees_merged)
str(trees_merged)

## Filter the first budburst state (Score = 1)
require(tidyverse)
trees_filtered <- filter(trees_merged, Score == "1")
trees_filtered <- rename(trees_filtered, Date = Date.x)
trees_filtered <- filter(trees_filtered, species == "quercus.robur")
str(trees_filtered)
head(trees_filtered)

## Transform date into day within a year
# Assuming trees_filtered is your dataframe
trees_filtered <- trees_filtered %>%
  mutate(
    Day = yday(Date)              # Calculate day of the year
  )

str(trees_filtered)
head(trees_filtered)

# transform data type
trees_filtered$TreeID <- as.factor(trees_filtered$TreeID)
trees_filtered$TreeForm <- as.factor(trees_filtered$TreeForm)
trees_filtered$species <- as.factor(trees_filtered$species)
trees_filtered$SPlocation <- as.factor(trees_filtered$SPlocation)



############## Data exploration ##############

mean(trees_filtered$Girth_cm)
range(trees_filtered$Girth_cm)
sd(trees_filtered$Girth_cm)
median(trees_filtered$Girth_cm)

require(ggplot2)

# Create a histogram of girth, colored by TreeForm
ggplot(trees_filtered, aes(x = Girth_cm, fill = TreeForm)) +
  geom_histogram(binwidth = 10, position = "dodge") +
  labs(title = "Histogram of Girth_cm by TreeForm", x = "Girth (cm)", y = "Frequency") +
  theme_minimal() +
  scale_fill_discrete(name = "Tree Form")

# Create the boxplot of Girth_cm categorized by TreeForm
ggplot(trees_filtered, aes(x = TreeForm, y = Girth_cm, fill = TreeForm)) +
  geom_boxplot() +  # Create the boxplot
  labs(title = "Boxplot of Girth_cm by TreeForm", 
       x = "TreeForm", 
       y = "Girth (cm)") +
  theme_minimal() +  # Use a minimal theme for the plot
  scale_fill_discrete(name = "Tree Form")  # Add a legend title for TreeForm

# Plot Day vs Girth_cm with TreeForm as a factor
ggplot(trees_filtered, aes(x = Girth_cm, y = Day, color = TreeForm)) +
  geom_point() +
  labs(title = "Budburst Day vs Tree Size",
       x = "Tree Size (Girth_cm)",
       y = "Budburst Day (Day of Year)") +
  theme_minimal()

# check collinearity
pairs(trees_filtered[, c("Girth_cm", "Day", "TreeForm", "species")])

boxplot(TreeForm ~ species, data = trees_filtered)
boxplot(trees_filtered$Girth_cm)

############## Linear mixed models ##############

# Load the required package
require(lme4)
require(lmtest)
require(nlme)

# Fit the mixed-effects model and compare with gls
m1 <- gls(Day ~ Girth_cm * TreeForm, data = trees_filtered)
m2 <- lmer(Day ~ Girth_cm * TreeForm + (1 | TreeID), data = trees_filtered, REML = TRUE)
lrtest(m1, m2)  # likelihood ratio test

# no improvement from linear mixed model, use linear model instead
m3 <- lm(Day ~ Girth_cm * TreeForm, data = trees_filtered)
m4 <- lm(Day ~ Girth_cm + TreeForm, data = trees_filtered)
m5 <- lm(Day ~ Girth_cm, data = trees_filtered)

############## Compare AIC values ##############
require(AICcmodavg)

# List of models
model_list <- list(m3, m4, m5)

# Compare models using aictab
aic_results <- aictab(cand.set = model_list, modnames = c("m3", "m4", "m5"))
print(aic_results)

# Summary of the model
summary(m5)

par(mfrow = c(2, 2))
plot(m5)

mean(trees_filtered$Girth_cm)
var(trees_filtered$Girth_cm)



############## Output model summary as a table ##############
require(stargazer)
require(sjPlot)

# Create LaTeX output
stargazer(m5, type = "latex", out = "../results/model_summary.tex")
tab_model(m5)



############## Plot with regression line ##############

# Create a base plot
plot <- ggplot(trees_filtered, aes(x = Girth_cm, y = Day)) +
  geom_point(color = "blue", alpha = 0.4) +       # Scatter plot of the data
  theme_classic() +                               # Use the classic theme
  labs(
    x = "Tree Girth (cm)",
    y = "Budburst Date (Day of Year)"
  )

# Add regression line with 95% CI based on model m5
plot_with_model <- plot +
  geom_smooth(
    method = "lm",                                # Linear regression
    formula = y ~ x,                              # Formula for the regression line
    color = "red",                                # Line color
    fill = "lightpink",                           # Confidence interval fill color
    level = 0.95                                  # 95% confidence interval
  )

# Display the plot
print(plot_with_model)

# Save the result graph
pdf("../results/Plot.pdf", 10, 12)  # open blank pdf page
print(plot_with_model)  # Print the graph to the PDF
dev.off()  # Close the PDF device
