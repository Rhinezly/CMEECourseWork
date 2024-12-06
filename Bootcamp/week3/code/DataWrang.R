################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData)  # show or set the dimension of an object
str(MyData)  # show the internal strcture of an object
fix(MyData)  # display in a data editor
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

# assign data types to each column
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

require(tidyverse)
# check packages inside tidyverse
tidyverse_packages(include_self = T)  # `include_self` measn list 'tidyverse' as well

## convert dataframe to tibble
# a "tibble" in tidyverse is a modified dataframe that makes data exploration more robust
MyWrangledData <- dplyr::as_tibble(MyWrangledData)  # same as `MyWranglesData <- as_tibble(MyWrangledData)`
MyWrangledData
class(MyWrangledData)

glimpse(MyWrangledData)  # like str(), but nicer
utils::View(MyWrangledData)  # same as fix()
filter(MyWrangledData, Count > 100)  # like subset() but nicer
slice(MyWrangledData, 10:15)  # look at a particular range of rows 

## Using "pipe" `%>%`
MyWrangledData %>%
    group_by(Species) %>%
        summarise(avg = mean(Count))
            # add `print(n = ...)` to see more rows, as the default output only shows 10 rows

# the same as using base R:
# aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean)