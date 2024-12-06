# Load necessary libraries
require(ggplot2)
require(dplyr)
require(broom)
require(purrr)

# Load the dataset
data <- read.csv("../data/EcolArchives-E089-51-D1.csv")


## Create the plot
p <- ggplot(data, aes(x = Prey.mass, y = Predator.mass, color = Predator.lifestage)) +
  # Add points with "+" shape
  geom_point(alpha = 0.7, shape = 3) +
  # Add regression lines across the full x-axis range
  geom_smooth(method = "lm", se = TRUE, fullrange = TRUE) +
  # Set x and y axes to logarithmic scales with specified breaks and labels
  scale_x_log10(
    breaks = c(1e-07, 1e-03, 1e+01),
    expand = expansion(mult = c(0.05, 0.05)) # Add gap near edges
  ) +
  scale_y_log10(
    breaks = c(1e-06, 1e-02, 1e+02, 1e+06),
  ) +
  # Create facets with fixed scales and vertical titles on the right
  facet_wrap(
    ~Type.of.feeding.interaction, 
    scales = "fixed", 
    ncol = 1, 
    strip.position = "right" # Move facet titles to the right
  ) +
  # Set a fixed aspect ratio
  coord_fixed(ratio = 0.5) +  # Aspect ratio of 1:1
  # Minimal theme with customizations for strip text, legend position, and panel borders
  theme_minimal() +
  theme(
    # Plot titles
    strip.text.y = element_text(size = 12, face = "bold"),
    # Axis titles
    axis.title = element_text(size = 13, face = "bold"),  # Larger axis titles
    # Axis text
    axis.text = element_text(size = 12, face = "bold"),  # Larger tick labels
    # Facet strip formatting
    strip.background = element_rect(fill = "grey80", color = "grey50"),  # Grey box for facet titles
    # Add a border around each plot
    panel.border = element_rect(color = "grey50", fill = NA, size = 0.5),  # Black border
    # Legend formatting
    legend.position = "bottom",  # Move legend to the bottom
    legend.title = element_text(size = 11, face = "bold"),  # Bold legend title
    legend.text = element_text(size = 11),  # Legend text font size
  ) +
  # Modify the legend layout to fit in one line
  guides(color = guide_legend(nrow = 1)) +  # Force a single row in the legend
  # Add labels
  labs(
    x = "Prey Mass in grams",
    y = "Predator Mass in grams",
    color = "Predator.lifestage"
  )

# Save the plot as a PDF
pdf("../results/Predator_Prey_Plot.pdf", width = 10, height = 12)
print(p)
dev.off()



## Calculate regression results for each Feeding Type and Life Stage combination
# Fit the linear model and extract results using dplyr and broom
regression_results <- data %>%
  # Select relevant columns for analysis
  select(Predator.mass, Prey.mass, Predator.lifestage, Type.of.feeding.interaction) %>%
  
  # Group data by feeding interaction type and predator life stage
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  
  # Filter out groups with insufficient data (less than 2 records or zero variance in Prey.mass)
  filter(n() > 1, sd(Prey.mass) > 0) %>%
  
  # Fit linear models for each group and extract results
  summarize(
    model = list(lm(log(Predator.mass) ~ log(Prey.mass), data = cur_data())),
    .groups = "drop"
  ) %>%
  
  # Extract regression results using broom
  mutate(
    tidy_results = map(model, ~ broom::tidy(.x) %>% filter(term == "log(Prey.mass)")),
    glance_results = map(model, broom::glance)
  ) %>%
  
  # Combine tidy and glance results into a structured data frame
  transmute(
    Feeding_Type = Type.of.feeding.interaction,
    Life_Stage = Predator.lifestage,
    Slope = map_dbl(tidy_results, ~ .x$estimate),
    Intercept = map_dbl(model, ~ coef(.x)["(Intercept)"]),
    R_squared = map_dbl(glance_results, ~ .x$r.squared),
    F_statistic = map_dbl(glance_results, ~ .x$statistic),
    P_value = map_dbl(tidy_results, ~ .x$p.value)
  )

# Save regression results to a CSV file
write.csv(regression_results, file = "../results/PP_Regress_Results.csv", row.names = FALSE)
