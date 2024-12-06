########### Data exploration ###########

require(ggplot2)
require(MASS)
require(ggpubr)

fish <- read.csv("../data/fisheries.csv", stringsAsFactors = TRUE)
str(fish)

ggplot(fish, aes(x = MeanDepth, y = TotAbund))+
    geom_point()+
    labs(x = "Mean Depth (km)", y = "Total Abundance")+
    theme_classic()


########### Model fitting ###########

M1 <- glm(TotAbund ~ MeanDepth, data = fish, family = "poisson")
summary(M1)


########### Interpretation and validation ###########

# based on the summary:
# ln(TotAbund) = 6.64 - 0.63 * MeanDepth
# Pseudo R^2 = 1 - (15770/27779) = 0.43

### Plot and check the model diagnostics

par(mfrow = c(2, 2))
plot(M1)  # “Std.Pearson resid. vs Leverage” shows potentially a lot outliers

## Explore how many outliers we have
# A Cook's distance more than 1 is generally considered an outlier
sum(cooks.distance(M1) > 1)  # got 29 outliers, don't want to drop this many observations for now

### Examine the dispersion parameter

# Dispersion Parameter = 15770/144 = 109.51
# model is overdispersed
# possible reason: (1) outliers (2) missing covariates/interactions
# (3) inherent dependency
# to explore those reasons: include additional covariates and/or fixed factors

## Explore Period as a factor through plotting
scatterplot <- ggplot(fish, aes(x = MeanDepth, y = TotAbund, color = factor(Period)))+
    geom_point()+
    labs(x = "Mean Depth (km)", y = "Total Abundance")+
    theme_classic()+
    scale_color_discrete(name = "Period", labels = c("1979-1989", "1997-2002"))

boxplot <- ggplot(fish, aes(x = factor(Period, labels = c("1979-1989", "1997-2002")), y = TotAbund))+
    geom_boxplot()+
    theme_classic()+
    labs(x = "Period", y = "Total Abundance")

ggarrange(scatterplot, boxplot, labels = c("A", "B"), ncol = 1, nrow = 2)

# add Period as a fixed factor
fish$Period <- factor(fish$Period)
M2 <- glm(TotAbund ~ MeanDepth * Period, data = fish, family = "poisson")
summary(M2)
anova(M2, test = "Chisq")
# Dispersion Parameter = 14293/142 = 100.65 (still overdspersed)

## Option 1) quasi-Poisson model

## Option 2) negative binomial model
M3 <- glm.nb(TotAbund ~ MeanDepth * Period, data = fish)
summary(M3)
anova(M3, test = "Chisq")  # no significant difference in interaction terms

# remove the interaction term
M4 <- glm.nb(TotAbund ~ MeanDepth + Period, data = fish)
summary(M4)
anova(M4)

# model diagnostics plot
par(mfrow = c(2, 2))
plot(M4)

# Dispersion Parameter = 158.23/143 = 1.11


########### plot the model ###########

## Make predictions from the model
range(fish$MeanDepth)  # find the range of MeanDepth

period1 <- data.frame(MeanDepth = seq(from = 0.804, to = 4.865, length = 100),
    Period = "1")

period2 <- data.frame(MeanDepth = seq(from = 0.804, to = 4.865, length = 100),
    Period = "2")

period1_predictions <- predict(M4, newdata = period1, type = "link",
    se.fit = TRUE)
# the type="link" predicted the fit and se on the log-linear scale.

period2_predictions <- predict(M4, newdata = period2, type = "link",
    se.fit = TRUE)

period1$pred <- period1_predictions$fit
period1$se <- period1_predictions$se.fit
period1$upperCI <- period1$pred + (period1$se * 1.96)
period1$lowerCI <- period1$pred - (period1$se * 1.96)

period2$pred <- period2_predictions$fit
period2$se <- period2_predictions$se.fit
period2$upperCI <- period2$pred + (period2$se * 1.96)
period2$lowerCI <- period2$pred - (period2$se * 1.96)

complete <- rbind(period1, period2)

## Plotting
ggplot(complete, aes(x = MeanDepth, y = exp(pred)))+
    geom_line(aes(color = factor(Period)))+
    geom_ribbon(aes(ymin = exp(lowerCI), ymax = exp(upperCI), 
fill = factor(Period), alpha = 0.3), show.legend = FALSE)+
    geom_point(fish, mapping = aes(x = MeanDepth, y = TotAbund,
color = factor(Period)))+
    labs(y = "Total Abundance", x = "Mean Depth (km)")+
    theme_classic()+
    scale_color_discrete(name = "Period", labels = c("1979-1989", "1997-2002"))

# simpler way of plotting
require(ggeffects)
plot(ggpredict(M4, terms = c("MeanDepth", "Period")), show_data = TRUE)
# ggpredict also works with adding more ggplot commands using "+"