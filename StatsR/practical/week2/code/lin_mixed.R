rm(list = ls())

# Read the file with all strings as factors
d <- read.table("../data/ObserverRepeatability.txt", sep = "\t",  # specify the seperator as a tab (the table seems to have inconsistent seperator)
                stringsAsFactors = TRUE, header = TRUE)
str(d)

hist(d$Tarsus)
hist(d$BillWidth)

# Remove outlier
d <- subset(d, d$Tarsus <= 40)
d <- subset(d, d$Tarsus >= 10)
hist(d$Tarsus)

# Explore data
summary(d$Tarsus)
var(d$Tarsus)
summary(d$BillWidth)
var(d$BillWidth)

# Linear mixed model
require(lme4)  # for linear mixed models
require(lmtest)

mT1 <- lmer(Tarsus ~ 1 + (1 | StudentID), data = d)
mT2 <- lmer(Tarsus ~ 1 + (1 | StudentID) + (1 | GroupN), data = d)
lrtest(mT1, mT2)  # likelihood ratio test
summary(mT1)
3.65/(3.65+2.25)  # calculate intra-class correlation coefficient
# 62% of the total variance is attributable to the grouping variable(StudentID)
