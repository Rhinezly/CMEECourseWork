############ Using ggplot to make maps ############

library(ggplot2)
# World map
ggplot(ne_110) +
       geom_sf() +
       theme_bw()

## BAD example
europe <- st_crop(ne_110, ext(-10,40,35,75))
ggplot(europe) +
       geom_sf(aes(fill=GDP_MD)) +
       scale_fill_viridis_c() +
       theme_bw() + 
       geom_sf_text(aes(label = ADMIN), colour = "white")

## European life expectancy
# Calculate the extent in the LAEA projection of the cropped data
europe_crop_laea <- st_transform(europe, 3035)

# Reproject all of the country data and _then_ crop to the previous extent
europe_laea <- st_transform(ne_110, 3035)
europe_laea <- st_crop(europe_laea, europe_crop_laea)

# Plot the two maps
p1 <- ggplot(europe_crop_laea) +
       geom_sf(aes(fill=log(GDP_MD))) +
       scale_fill_viridis_c() +
       theme_bw() + 
       theme(legend.position="bottom") +
       geom_sf_text(aes(label = ADM0_A3), colour = "grey20")

p2 <- ggplot(europe_laea) +
       geom_sf(aes(fill=log(GDP_MD))) +
       coord_sf(expand=FALSE) +
       scale_fill_viridis_c() +
       theme_bw() + 
       theme(legend.position="bottom") +
       geom_sf_text(aes(label = ADM0_A3), colour = "grey20")

library(gridExtra)
grid.arrange(p1, p2, ncol=2)



############ Colour palettes ############

############ Viridis ############
# The viridis package contains the viridis palette, but also these other palettes:
# magma, plasma, inferno

# With ggplot, you can use the functions scale_color_viridis() to colour 
# points, lines or texts and scale_fill_viridis() to fill areas. 
# Use the option argument to select which pallette in viridis you wish, 
# with the viridis palette being the default.


############ Brewer ############
library(RColorBrewer)
# display the palette
display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)

# As with viridis you can use scale_color_brewer() and scale_fill_brewer() in ggplot.