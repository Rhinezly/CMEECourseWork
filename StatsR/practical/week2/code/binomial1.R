############# Explore data #############

# load and check data structure
require(ggplot2)
require(ggpubr)

worker <- read.csv("../data/workerbees.csv", stringsAsFactors = TRUE)
str(worker)

# plot the data
scatterplot <- ggplot(worker, aes(x = CellSize, y = Parasites))+
    geom_point()+
    labs(x = "Cell Size (cm)", y = "Probability of Parasite")+
    theme_classic()

boxplot <- ggplot(worker, aes(x = factor(Parasites), y = CellSize))+
    geom_boxplot()+
    labs(x = "Presence/Absence of Parasites", y = "Cell Size (cm)")+
    theme_classic()

ggarrange(scatterplot, boxplot, labels = c("A", "B"), ncol = 1, nrow = 2)


############# Fitting the model #############

M1 <- glm(Parasites ~ CellSize, data = worker, family = "binomial")
summary(M1)


############# Plotting the model #############

range(worker$CellSize)

## Predictions
new_data <- data.frame(CellSize = seq(from = 0.352, to = 0.664, length = 100))
predictions <- predict(M1, newdata = new_data, type = "link", se.fit = TRUE)
# the type="link" predicted the fit and se on the log-linear scale.
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred + (new_data$se * 1.96)
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96)

## Plotting
ggplot(new_data, aes(x = CellSize, y = plogis(pred)))+
    geom_line(col = "black")+
    geom_point(worker, mapping = aes(x = CellSize, y = Parasites),
col = "blue")+
    geom_ribbon(aes(ymin = plogis(lowerCI), ymax = plogis(upperCI),
alpha = 0.2), show.legend = FALSE)+
    labs(y = "Probability of Infection", x = "Cell Size (cm)")+
    theme_classic()

# Pseudo R^2 = 1 - (1104.9/1259.6) = 0.12
