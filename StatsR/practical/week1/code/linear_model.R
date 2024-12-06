rm(list=ls())

## data input
daphnia <- read.delim("../data/daphnia.txt")
summary(daphnia)
head(daphnia)
str(daphnia)

## check outliers
par(mfrow = c(1, 2))
plot(Growth.rate ~ as.factor(Detergent), data = daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia)

## check homogeneity of variances
require(dplyr)

daphnia %>%
    group_by(Detergent) %>%
    summarise(variance = var(Growth.rate))

daphnia %>%
    group_by(Daphnia) %>%
    summarise(variance = var(Growth.rate))

## check normal distribution
dev.off()
hist(daphnia$Growth.rate)

## Linear model

# get the means for each explanatory variable
seFun <- function(x)  # calculate standard error
{
    sqrt(var(x)/length(x))
}

detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
    FUN = mean))

detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
    FUN = seFun))

cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean))

cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))

# plot graphs for the above
par(mfrow = c(2, 1), mar = c(4, 4, 1, 1))

barMids <- barplot(detergentMean,
    xlab = "Detergent type", ylab = "Population growth rate", ylim = c(0, 5))

arrows(barMids, detergentMean - detergentSEM,
    barMids, detergentMean + detergentSEM, code = 3, angle = 90)

barMids <- barplot(cloneMean,
    xlab = "Daphnia clone", ylab = "Population growth rate",
    ylim = c(0, 5))

arrows(barMids, cloneMean - cloneSEM,
    barMids, cloneMean + cloneSEM, code = 3, angle = 90)

# build linear model
daphiniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphiniaMod)

# ANOVA (for multiple comparisons)
daphniaANOVAMod <- aov(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaANOVAMod)

daphiniaModHSD <- TukeyHSD(daphniaANOVAMod)
daphiniaModHSD

# plot daphiaModHSD
par(mfrow = c(2, 1), mar = c(4, 4, 1, 1))
plot(daphiniaModHSD)

# model validation
par(mfrow = c(2, 2))
plot(daphiniaMod)


## Multiple regression

timber <- read.delim("../data/timber.txt")
summary(timber)
str(timber)
head(timber)

# outliers
par(mfrow = c(2, 2))
boxplot(timber$volume)
boxplot(timber$girth)
boxplot(timber$height)
dev.off()

# homogeneity of variances
var(timber$volume)
var(timber$girth)
var(timber$height)

# deal with heterogeneity
t2 <- as.data.frame(subset(timber, timber$volume != "NA"))
t2$z.girth <- scale(timber$girth)
t2$z.height <- scale(timber$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)

# normal distribution
par(mfrow = c(2, 2))
hist(t2$volume)
hist(t2$girth)
hist(t2$height)
dev.off()

# collinearity among covariates
pairs(timber)
cor(timber)
# use VIF (Variance Inflation Factor) to see what amount of collinearity is too much
# VIF = 1/(1 - R^2)
summary(lm(girth ~ height, data = timber))
VIF <- 1/(1 - 0.27)
VIF
sqrt(VIF)

# modelling
timberMod <- lm(volume ~ girth + height, data = timber)
anova(timberMod)
summary(timberMod)

# model validation
plot(timberMod)
