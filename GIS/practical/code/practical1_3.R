############ Converting between vector and raster ############

############ vector to raster ############
# Provide the target raster and the vector data and put it all through the `rasterize` function
# A cell might have more than one possible value;
# the rasterize function has a `fun` argument that allows you to set rules to decide which value ‘wins’

## Rasterize the uk_eire_BNG vector data onto a 20km resolution grid
# Create the target raster 
uk_20km <- rast(xmin=-200000, xmax=650000, ymin=0, ymax=1000000, 
                res=20000, crs='+init=EPSG:27700')

# Rasterizing polygons
uk_eire_poly_20km  <- rasterize(uk_eire_BNG, uk_20km, field='name')

plot(uk_eire_poly_20km)

## Represent the boundary lines or polygon vertices as raster data
uk_eire_BNG$name <- as.factor(uk_eire_BNG$name)
# When you alter geometries, it isn’t always clear that
# the attributes of the original geometry apply to the altered geometries
# We can tell sf that attributes are constant and it will stop warning us
st_agr(uk_eire_BNG) <- 'constant'

# Rasterizing lines
uk_eire_BNG_line <- st_cast(uk_eire_BNG, 'LINESTRING')
uk_eire_line_20km <- rasterize(uk_eire_BNG_line, uk_20km, field='name')

# Rasterizing points
# - This isn't quite as neat as there are two steps in the casting process:
#   Polygon -> Multipoint -> Point
uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, 'MULTIPOINT'), 'POINT')
uk_eire_point_20km <- rasterize(uk_eire_BNG_point, uk_20km, field='name')

# Plotting those different outcomes
# - Use the hcl.colors function to create a nice plotting palette
color_palette <- hcl.colors(6, palette='viridis', alpha=0.5)

# - Plot each raster
par(mfrow=c(1,3), mar=c(1,1,1,1))
# polygons
plot(uk_eire_poly_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

# boundary lines
plot(uk_eire_line_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

# vertices
plot(uk_eire_point_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')


############ Raster to vector ############
# Get a set of dissolved polygons (the default) including NA cells
poly_from_rast <- as.polygons(uk_eire_poly_20km, na.rm=FALSE)

# Get individual cells (no dissolving)
cells_from_rast <- as.polygons(uk_eire_poly_20km, dissolve=FALSE)

# Get individual points
points_from_rast <- as.points(uk_eire_poly_20km)

# The `terra` package has its own format (SpatVector) for vector data
# Transform it to `sf` object and see the output
print(st_as_sf(poly_from_rast))
print(st_as_sf(cells_from_rast))
print(st_as_sf(points_from_rast))

# Plot the outputs - using key.pos=NULL to suppress the key
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(poly_from_rast, key.pos = NULL)
plot(cells_from_rast, key.pos = NULL)
plot(points_from_rast, key.pos = NULL, pch=4)



############ Using data in files ############

############ Saving vector data ############
## Save as shapefile
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.shp')
st_write(uk_eire_BNG, '../data/uk/uk_eire_BNG.shp')

## GeoJSON and GeoPackage file format
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.geojson')
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.gpkg')

# Specify a driver
# A driver is a bit of internal software that reads or writes a particular format
# you can see the list of available formats using `st_drivers()`
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.json', driver='GeoJSON')


############ Saving raster data ############
# Save a GeoTiff
writeRaster(uk_raster_BNG_interp, '../data/uk/uk_raster_BNG_interp.tif')
# Save an ASCII format file: human readable text. 
# Note that this format also creates an aux.xml and .prj file!
writeRaster(uk_raster_BNG_near, '../data/uk/uk_raster_BNG_ngb.asc', filetype='AAIGrid')


############ Loading vector data ############
# Load a vector shapefile
ne_110 <- st_read('../data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp')
# Also load some WHO data on 2016 life expectancy
# see: http://apps.who.int/gho/athena/api/GHO/WHOSIS_000001?filter=YEAR:2016;SEX:BTSX&format=csv
life_exp <- read.csv(file = "../data/WHOSIS_000001.csv")

## Create global maps
# Global GDP plot
plot(ne_110['GDP_MD'],  asp=1, main='Global GDP', logz=TRUE, key.pos=4)

# 2016 global life expectancy for both sexes
# Merge the data
ne_110 <- merge(ne_110, life_exp, by.x='ISO_A3_EH', by.y='COUNTRY', all.x=TRUE)
# Create a sequence of break values to use for palette display
bks <- seq(50, 85, by=0.25)
# Plot the data
plot(ne_110['Numeric'], asp=1, main='Global 2016 Life Expectancy (Both sexes)',
      breaks=bks, pal=hcl.colors, key.pos=4)


############ Loading XY data ############
# Read in Southern Ocean example data
so_data <- read.csv('../data/Southern_Ocean.csv', header=TRUE)

# Convert the data frame to an sf object
so_data <- st_as_sf(so_data, coords=c('long', 'lat'), crs=4326)
print(so_data)


############ Loading raster data ############
etopo_25 <- rast('../data/etopo_25.tif')
# Look at the data content
print(etopo_25)
# Plot it 
plot(etopo_25, plg=list(ext=c(190, 210, -90, 90)))

## Controlling raster plot
# Define a sequence of 65 breakpoints along an elevation gradient from -10 km to 6 km.
# There are 64 intervals between these breaks and each interval will be assigned a colour
breaks <- seq(-10000, 6000, by=250)

# Define 24 land colours for use above sea level (0m)
land_cols  <- terrain.colors(24)

# Generate a colour palette function for sea colours
sea_pal <- colorRampPalette(c('darkslateblue', 'steelblue', 'paleturquoise'))

# Create 40 sea colours for use below sea level
sea_cols <- sea_pal(40)

# Plot the raster providing the breaks and combining the two colour sequences to give
# 64 colours that switch from sea to land colour schems at 0m.
plot(etopo_25, axes=FALSE, breaks=breaks,
     col=c(sea_cols, land_cols), type='continuous', # continous legend
     plg=list(ext=c(190, 200, -90, 90)) # set the extent of the legend box
)


############ Raster stacks ############
# Download bioclim data: global maximum temperature at 10 arc minute resolution
tmax <- worldclim_global(var='tmax', res=10, path='../data')
# The data has 12 layers, one for each month
print(tmax)

## Access different layers and extract info across layers
# Extract  January and July data and the annual maximum by location.
tmax_jan <- tmax[[1]]
tmax_jul <- tmax[[7]]
tmax_max <- max(tmax)

# Plot those maps
par(mfrow=c(2,2), mar=c(2,2,1,1))
bks <- seq(-50, 50, length=101)
pal <- colorRampPalette(c('lightblue','grey', 'firebrick'))
cols <- pal(100)
plg <- list(ext=c(190, 200, -90, 90))

plot(tmax_jan, col=cols, breaks=bks, 
     main='January maximum temperature', type='continuous', plg=plg)
plot(tmax_jul, col=cols, breaks=bks, 
     main='July maximum temperature', type='continuous', plg=plg)
plot(tmax_max, col=cols, breaks=bks, 
     main='Annual maximum temperature', type='continuous', plg=plg)
dev.off()
