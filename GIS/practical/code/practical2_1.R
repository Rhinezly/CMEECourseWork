# Load packages
library(terra)
library(geodata)

library(raster)
library(sf)
library(sp)

library(dismo)



############ Data preparation ############

############ Focal species distribution ############
## View the IUCN data
tapir_IUCN <- st_read('../data/sdm/iucn_mountain_tapir/data_0.shp')
print(tapir_IUCN)

## Load the GBIF data
# Load the data frame
tapir_GBIF <- read.delim('../data/sdm/gbif_mountain_tapir.csv')

# Drop rows with missing coordinates
tapir_GBIF <- subset(tapir_GBIF, ! is.na(decimalLatitude) | ! is.na(decimalLongitude))

# Convert to an sf object and set the projection
tapir_GBIF <- st_as_sf(tapir_GBIF, coords=c('decimalLongitude', 'decimalLatitude'))
st_crs(tapir_GBIF) <- 4326

# Load some (coarse) country background data
ne110 <- st_read('../data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp')

# Create a modelling extent for plotting and cropping the global data.
model_extent <- extent(c(-85,-70,-5,12))

# Plot the species data over a basemap
plot(st_geometry(ne110), xlim=model_extent[1:2], ylim=model_extent[3:4], 
     bg='lightblue', col='ivory', axes=TRUE)
plot(st_geometry(tapir_IUCN), add=TRUE, col='grey', border=NA)
plot(st_geometry(tapir_GBIF), add=TRUE, col='red', pch=4, cex=0.6)


############ Predictor variables ############
# Load the data
bioclim_hist <- worldclim_global(var='bio', res=10, path='../data')
bioclim_future <- cmip6_world(var='bioc', res=10, ssp="585", 
                              model='HadGEM3-GC31-LL', time="2041-2060", path='../data')
 
# Relabel the variables to match between the two dataset
bioclim_names <- paste0('bio', 1:19)
names(bioclim_future) <- bioclim_names
names(bioclim_hist) <- bioclim_names

# Look at the data structure
print(bioclim_hist)
print(bioclim_future)

## Compare BIO 1 (Mean Annual Temperature) between the two datasets
par(mfrow=c(2,2), mar=c(1,1,1,1))

# Create a shared colour scheme
breaks <- seq(-30, 35, by=2)
cols <- hcl.colors(length(breaks) - 1)

# Plot the historical and projected data
plot(bioclim_hist[[1]], breaks=breaks, col=cols, 
     type='continuous', plg=list(ext=c(190,200,-90,90)))
plot(bioclim_future[[1]], breaks=breaks, col=cols, 
     type='continuous', plg=list(ext=c(190,200,-90,90)))

# Plot the temperature difference
plot(bioclim_future[[1]] - bioclim_hist[[1]], 
     col=hcl.colors(20, palette='Inferno'), breakby='cases',
     type='continuous', plg=list(ext=c(190,200,-90,90)))

## Reduce the global maps down to the species' range
bioclim_hist_local <- crop(bioclim_hist, model_extent)
bioclim_future_local <- crop(bioclim_future, model_extent)


############ Reproject the data ############
test <-  project(bioclim_hist_local, 'EPSG:32718')
ext(test)

res(test)  # Resolution in metres on X and Y axes

# Define a new projected grid
 utm18s_grid <- rast(ext(-720000, 1180000, 9340000, 11460000), 
                       res=20000, crs='EPSG:32718')

# Reproject the model data
bioclim_hist_local <- project(bioclim_hist_local, utm18s_grid)
bioclim_future_local <- project(bioclim_future_local, utm18s_grid)

# Reproject the species distribution vector data
tapir_IUCN <- st_transform(tapir_IUCN, crs='EPSG:32718')
tapir_GBIF <- st_transform(tapir_GBIF, crs='EPSG:32718')


############ Pseudo-absence data ############
# Create a simple land mask
land <- bioclim_hist_local[[1]] >= 0

# How many points to create? We'll use the same as number of observations
n_pseudo <- nrow(tapir_GBIF)

# Sample the points
pseudo_dismo <- randomPoints(mask=as(land, 'Raster'), n=n_pseudo, 
                             p=st_coordinates(tapir_GBIF))

# Convert this data into an sf object, for consistency with the
# next example.
pseudo_dismo <- st_as_sf(data.frame(pseudo_dismo), coords=c('x','y'), crs=32718)

# Create buffers around the observed points
nearby <- st_buffer(tapir_GBIF, dist=100000)
too_close <- st_buffer(tapir_GBIF, dist=20000)
# merge those buffers
nearby <- st_union(nearby)
too_close <- st_union(too_close)
# Find the area that is nearby but _not_ too close
nearby <- st_difference(nearby, too_close)
# Get some points within that feature in an sf dataframe
pseudo_nearby <- st_as_sf(st_sample(nearby, n_pseudo))

## plot those two points side by side for comparison
par(mfrow=c(1,2), mar=c(1,1,1,1))

# Random points on land
plot(land, col='grey', legend=FALSE)
plot(st_geometry(tapir_GBIF), add=TRUE, col='red')
plot(pseudo_dismo, add=TRUE)

# Random points within ~ 100 km but not closer than ~ 20 km
plot(land, col='grey', legend=FALSE)
plot(st_geometry(tapir_GBIF), add=TRUE, col='red')
plot(pseudo_nearby, add=TRUE)


############ Testing and training dataset ############
# Use kfold to add labels to the data, splitting it into 5 parts
tapir_GBIF$kfold <- kfold(tapir_GBIF, k=5)

# Do the same for the pseudo-random points
pseudo_dismo$kfold <- kfold(pseudo_dismo, k=5)
pseudo_nearby$kfold <- kfold(pseudo_nearby, k=5)
