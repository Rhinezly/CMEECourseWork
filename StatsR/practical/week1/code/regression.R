############# lecture 9 exercise ##############
# create vetors for simple linear regression
x <- c(1, 2, 3, 4, 8)
y <- c(4, 3, 5, 7, 9)

# perform linear regression
model1 <- lm(y ~ x)
model1
summary(model1)
anova(model1)
resid(model1)
cov(x, y)
var(x)
plot(y ~ x)


############ handout 7 ###############

## simple linear functions
rm(list = ls())
# create a uniform distributed vector
x <- seq(from = -5, to = 5, by = 1)
x
a <- 2
b <- 1
y <- a + b * x
plot(x, y)
# add cartesian axes
segments(0,-10,0,10, lty=3)
segments(-10,0,10,0,lty=3)
# trun thr dot white and add a staight line
plot(x,y, col="white")
segments(0,-10,0,10, lty=3)
segments(-10,0,10,0,lty=3)
abline(a = 2, b=1)
# add points
points(4,0, col="red", pch=19)
points(-2,6, col="green", pch=9)
points(x,y, pch=c(1,2,3,4,5,6,7,8,9,10,11))
