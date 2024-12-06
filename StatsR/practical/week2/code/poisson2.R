############# Fitting poisson model #############

mites <- read.csv("../data/bee_mites.csv")
mites_m1 <- glm(Dead_mites ~ Concentration, data = mites, family = "poisson")
summary(mites_m1)
anova(mites_m1, test = "Chisq")

## Interpretation
# ln(Number of Dead Mites) = 0.53 + 0.57 * Concentration
# Pseudo R^2 = 1 - (109.25/154.79) = 0.29


############# Model validation #############

# Dispersion Parameter = 109.25/113 = 0.97

## Plot model diagnostics
par(mfrow = c(2, 2))
plot(mites_m1)

## Plot the model
range(mites$Concentration)

# make predictions from the model
new_data <- data.frame(Concentration = seq(from = 0, to = 2.16, length = 100))
predictions <- predict(mites_m1, newdata = new_data, type = "link", se.fit = TRUE)
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred + (new_data$se * 1.96)
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96)

# plot out the predictions
ggplot(new_data, aes(x = Concentration, y = exp(pred)))+
    geom_line(col = "black")+
    geom_ribbon(aes(ymin = exp(lowerCI), ymax = exp(upperCI), alpha = 0.1),
show.legend = FALSE, fill = "grey")+
    geom_point(mites, mapping = aes(x = Concentration, y = Dead_mites),
col = "blue")+
    labs(y = "Number of Dead Mites", x = "Concentration (g/l)")+
    theme_classic()
