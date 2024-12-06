############ Packages loading and setting ############

library(terra)     # core raster GIS package
library(sf)        # core vector GIS package
library(units)     # used for precise unit conversion

library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files

## Turn off the `s2` package in `sf`
# (s2 handles coordinates as angular positions on the surface of a sphere
# rather than pretending that they are cartesian coordinates are on a flat plane
# That is definitely the right way to do this,
# but some of the datasets in this practical have some issues with using s2)
sf_use_s2(FALSE)



############ Vector data ############

############ Making vectors from coordinates ############
## Create population density map
# create a dataframe for each country
pop_dens <- data.frame(
    n_km2 = c(260, 67, 151, 4500, 133),
    country = c('England', 'Scotland', 'Wales', 'London', 'Northern Ireland')
)

print(pop_dens)

## Create coordinates for each country
# create a matrix of pairs of coordinates forming the edge of the polygon
# (they have to _close_: the first and last coordinate must be the same)
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                  c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                  c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
                  c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                  c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

# Convert these coordinates into feature geometries
# (these are simple coordinate sets with no projection information)
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# combine geometries into a simple feature column (sfc)
uk_eire_sfc <- st_sfc(wales, england, scotland, ireland, crs = 4326)
plot(uk_eire_sfc, asp = 1) # `asp` sets an aspect ratio of the plot


############ Making vector points from a dataframe ############
## Create point locations for capital cities
# turn a data frame with coordinates in columns into a point vector data source
uk_eire_capitals <- data.frame(
     long= c(-0.1, -3.2, -3.2, -6.0, -6.25),
     lat=c(51.5, 51.5, 55.8, 54.6, 53.30),
     name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin')
)

# indicate which fields in the data frame contain the coordinates
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long','lat'), crs=4326)
print(uk_eire_capitals)


############ Vector geometry operations ############
## Handle the missing separate polygon for London
# use 'buffer' operation to create a polygon for London
st_pauls <- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25) # an area within 0.25 degree of st_pauls

# remove London from the England polygon
england_no_london <- st_difference(england, london)

# see the number of components in a polygon and how many points are in each component
lengths(scotland)
lengths(england_no_london)

## Tidy up Wales boundary
# extract Wales from the England polygon
wales <- st_difference(wales, england)

## Separate Northern Ireland from the island of Ireland
# create a rough polygon that includes Northern Ireland and surrounding sea.
# (note the alternative way of providing the coordinates)
ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))

# find the intersection and difference of that polygon with Ireland
northern_ireland <- st_intersection(ireland, ni_area)
eire <- st_difference(ireland, ni_area)

# combine the final geometries
uk_eire_sfc <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)


############ Features and geometries ############
# compare six Polygon features with one Multipolygon feature
print(uk_eire_sfc)

# make the UK into a single feature
uk_country <- st_union(uk_eire_sfc[-6])
print(uk_country)

# Plot them
par(mfrow = c(1, 2), mar = c(3, 3, 1, 1))
plot(uk_eire_sfc, asp = 1, col = rainbow(6))
plot(st_geometry(uk_eire_capitals), add = TRUE)
plot(uk_country, asp = 1, col = 'lightblue')


############ Vector data and attributes ############
# create an sf object type
# (a normal data frame with additional field containing simple feature data)
uk_eire_sf <- st_sf(name=c('Wales', 'England','Scotland', 'London', 
                            'Northern Ireland', 'Eire'),
                    geometry=uk_eire_sfc)

print(uk_eire_sf)

# draw a basic map
plot(uk_eire_sf['name'], asp=1)

# add attributes
uk_eire_sf$capital <- c('Cardiff', 'London', 'Edinburgh', 
                        NA, 'Belfast','Dublin')
print(uk_eire_sf)

# add attributes using 'merge'
# (more useful and less error prone)
uk_eire_sf <- merge(uk_eire_sf, pop_dens,
                    by.x = 'name', by.y = 'country', all.x = TRUE)
print(uk_eire_sf)


############ Spatial attributes ############
## Centroids of features
uk_eire_centroids <- st_centroid(uk_eire_sf)
st_coordinates(uk_eire_centroids)

## Length and area
uk_eire_sf$area <- st_area(uk_eire_sf)

# To calculate a 'length' of a polygon, you have to convert it to a LINESTRING or a 
# MULTILINESTRING. Using MULTILINESTRING will automatically include all perimeter of a 
# polygon (including holes).
uk_eire_sf$length <- st_length(st_cast(uk_eire_sf, 'MULTILINESTRING'))

# look at the result
print(uk_eire_sf)

# change units in a neat way
uk_eire_sf$area <- set_units(uk_eire_sf$area, 'km^2')
uk_eire_sf$length <- set_units(uk_eire_sf$length, 'km')
print(uk_eire_sf)
# And it won't let you make silly error like turning a length into weight
# uk_eire_sf$area <- set_units(uk_eire_sf$area, 'kg')

# or simply convert the `units` version to simple numbers
uk_eire_sf$length <- as.numeric(uk_eire_sf$length)

# get the closest distance between geometries
st_distance(uk_eire_sf)
st_distance(uk_eire_centroids)


############ Plotting `sf` objects ############
# The default is to plot a map for every attribute,
# but you can pick a single field to plot by using square brackets.
plot(uk_eire_sf['n_km2'], asp = 1)

## You can get a log scale on the right
# simply log the data:
uk_eire_sf$log_n_km2 <- log10(uk_eire_sf$n_km2)
plot(uk_eire_sf['log_n_km2'], asp = 1, key.pos = 4)

# or have logarithimic labelling using logz
plot(uk_eire_sf['n_km2'], asp = 1, logz = TRUE, key.pos = 4)


############ Reprojecting vector data ############
# British National Grid (EPSG:27700)
uk_eire_BNG <- st_transform(uk_eire_sf, 27700)

# UTM50N (EPSG:32650) for Broneo (bad example)
uk_eire_UTM50N <- st_transform(uk_eire_sf, 32650)

# the bounding boxes of the data shows the change in units
st_bbox(uk_eire_sf)
st_bbox(uk_eire_BNG)

# plot the results
par(mfrow=c(1, 3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire_sf), asp=1, axes=TRUE, main='WGS 84')
plot(st_geometry(uk_eire_BNG), axes=TRUE, main='OSGB 1936 / BNG')
plot(st_geometry(uk_eire_UTM50N), axes=TRUE, main='UTM 50N')

## Degrees are not constant
# set up some points separated by 1 degree latitude and longitude from St. Pauls
st_pauls <- st_sfc(st_pauls, crs=4326)
one_deg_west_pt <- st_sfc(st_pauls - c(1, 0), crs=4326) # near Goring
one_deg_north_pt <-  st_sfc(st_pauls + c(0, 1), crs=4326) # near Peterborough

# calculate the distance between St Pauls and each point
st_distance(st_pauls, one_deg_west_pt)
st_distance(st_pauls, one_deg_north_pt)
st_distance(st_transform(st_pauls, 27700), 
            st_transform(one_deg_west_pt, 27700))

## Improve the London feature using a distance buffer instead of degrees
# transform St Pauls to BNG and buffer using 25 km
london_bng <- st_buffer(st_transform(st_pauls, 27700), 25000)

# In one line, transform england to BNG and cut out London
england_not_london_bng <- st_difference(st_transform(st_sfc(england, crs=4326), 27700), london_bng)

# project the other features and combine everything together
others_bng <- st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs=4326), 27700)
corrected <- c(others_bng, london_bng, england_not_london_bng)

# Plot that and marvel at the nice circular feature around London
par(mar=c(3,3,1,1))
plot(corrected, main='25km radius London', axes=TRUE)
