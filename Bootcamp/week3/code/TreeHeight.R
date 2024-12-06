# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:    The angle of elevation of tree
# distance:   The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

trees <- read.csv("../data/trees.csv", header = TRUE)  # import with headers

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)

    return(height)
}

# Add new column with calculated heights
trees$Tree.Height.m <- TreeHeight(trees$Angle.degrees, trees$Distance.m)

# Save the modified data frame back to a CSV file
write.csv(trees, "../results/TreeHts.csv", row.names = FALSE)
print("Calculated tree heights saved at ../result/TreeHts.csv")
