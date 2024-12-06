# Load data
d <- read.table("../data/SparrowSize.txt", header = TRUE)
str(d)
names(d)
head(d)

# Basic histograms
hist(d$Tarsus)

par(mfrow = c(2, 2)) # draw plots in 4 panels
hist(d$Tarsus, breaks = 3, col="grey")
hist(d$Tarsus, breaks = 10, col="grey")
hist(d$Tarsus, breaks = 30, col="grey")
hist(d$Tarsus, breaks = 100, col="grey")
dev.off()

## Descriptive statistic
mean(d$Tarsus, na.rm = TRUE)
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus, na.rm = TRUE)

head(table(d$Tarsus))
d$Tarsus.rounded <- round(d$Tarsus, digits = 1) # round the tarsus data
head(d$Tarsus.rounded)

## Further exploration and wrangling
require(dplyr)
TarsusTally <- d %>%
    count(Tarsus.rounded, sort = TRUE)  # sort from large to small
TarsusTally

d2 <- subset(d, d$Tarsus != "NA") # exclude NA data
length(d$Tarsus)-length(d2$Tarsus)

TarsusTally <- d2 %>% count(Tarsus.rounded, sort=TRUE)
TarsusTally

TarsusTally[[1]][1] # use `[]` to extract specific data

zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus) # z-standardization
var(zTarsus)
sd(zTarsus)
hist(zTarsus)

# Boxplot of Tarsus ~ Sex
boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")
boxplot(d$Tarsus~d$Sex, col = c("red", "blue"), ylab="Tarsus length (mm)")


# Example graph to demonstrate normal distribution
par(mfrow = c(1, 2))
dis1 <- rnorm(1000, mean = 0, sd = sqrt(2))
plot(density(dis1))
dis2 <- rnorm(1000, mean = 0, sd = sqrt(200))
plot(density(dis2))


require(plotrix) # to calculate se
se_Tarsus <- std.error(d$Tarsus)
se


# SE for Year 2001 only
se_2001 <- function(d, column_name) {
  d %>%
    filter(d$Year == 2001) %>%
    pull({{ column_name }}) %>%
    std.error()
}

se_tarsus <- se_2001(d, Tarsus)
se_tarsus


d1 <- subset(d, d$Year == 2001)
std.error(d1$Tarsus)
