############ Rasters ############

############ Creating a raster ############
# Create an empty raster object covering UK and Eire
uk_raster_WGS84 <- rast(xmin=-11,  xmax=2,  ymin=49.5, ymax=59, 
                        res=0.5, crs="EPSG:4326")
hasValues(uk_raster_WGS84)

# Add data to the raster - just use the cell numbers
values(uk_raster_WGS84) <- cells(uk_raster_WGS84)
print(uk_raster_WGS84)

# Create a basic map with he country borders over the top
# `add=TRUE` adds the vector data to the existing map
plot(uk_raster_WGS84)
plot(st_geometry(uk_eire_sf), add = TRUE, border = 'black', lwd = 2, col = '#FFFFFF44')


############ Changing raster resolution ############
# Define a simple 4 x 4 square raster
m <- matrix(c(1, 1, 3, 3,
              1, 2, 4, 3,
              5, 5, 7, 8,
              6, 6, 7, 7), ncol = 4, byrow = TRUE)
square <- rast(m)

plot(square, legend = NULL) # plot the rasters
text(square, digits = 2) # add text (matrix values) in each cell

## Aggregating rasters
# Average values
square_agg_mean <- aggregate(square, fact = 2, fun = mean) # a factor of 2 aggregates blocks of 2x2 cells
plot(square_agg_mean, legend = NULL)
text(square_agg_mean, digits = 2)

# Maximum values
square_agg_max <- aggregate(square, fact = 2, fun = max)
plot(square_agg_max, legend = NULL)
text(square_agg_max, digits = 2)

# Modal values for categories
# You can use `first` and `last` to specify which value gets chosen if there's no single mode
square_agg_modal <- aggregate(square, fact = 2, fun = 'modal')
plot(square_agg_modal, legend = NULL)
text(square_agg_modal, digits = 2)

## Disaggregating rasters
# Simply duplicate the nearest parent value
# (fine for both continuous and categorical values)
square_disagg <- disagg(square, fact = 2, method = 'near') # create the square 2 (2^2) cells from each cell
plot(square_interp, legend = NULL)
plot(square_disagg, legend = NULL)
text(square_disagg, digits = 2)

# Use bilinear interpolation (provide a smoother gradient between cells)
# (NOT for categorical values)
square_interp <- disagg(square, fact = 2, method = 'bilinear') 
text(square_interp, digits = 1)


############ Reprojecting a raster ############
### To match datasets and that have different origins and alignments
# make two simple `sfc` objects containing points in the
# lower left and top right of the two grids
uk_pts_WGS84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2, 59)), crs=4326)
uk_pts_BNG <- st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs=27700)

# Use st_make_grid to quickly create a polygon grid with the right cellsize
uk_grid_WGS84 <- st_make_grid(uk_pts_WGS84, cellsize=0.5)
uk_grid_BNG <- st_make_grid(uk_pts_BNG, cellsize=1e5)

# Reproject BNG grid into WGS84
uk_grid_BNG_as_WGS84 <- st_transform(uk_grid_BNG, 4326)

# Plot the features
par(mar=c(0,0,0,0))
plot(uk_grid_WGS84, asp=1, border='grey', xlim=c(-13,4))
plot(st_geometry(uk_eire_sf), add=TRUE, border='darkgreen', lwd=2)
plot(uk_grid_BNG_as_WGS84, border='red', add=TRUE)

## Create the target raster
# first create the target raster - we don’t have to put any data into it
uk_raster_BNG <- rast(xmin=-200000, xmax=700000, ymin=0, ymax=1000000,
                      res=100000, crs='+init=EPSG:27700')
# and use that as a template for the reprojected data

# interpolate a representative value from the source data
uk_raster_BNG_interp <- project(uk_raster_WGS84, uk_raster_BNG, method='bilinear')
# pick the cell value from the nearest neighbour to the new cell centre
uk_raster_BNG_near <- project(uk_raster_WGS84, uk_raster_BNG, method='near')

## Plot the data
par(mfrow=c(1,2), mar=c(0,0,0,0))
plot(uk_raster_BNG_interp, main='Interpolated', axes=FALSE, legend=FALSE)
text(uk_raster_BNG_interp, digit=1)
plot(uk_raster_BNG_near, main='Nearest Neighbour',axes=FALSE, legend=FALSE)
text(uk_raster_BNG_near)
