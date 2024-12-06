
############ Overlaying raster and vector data ############

############ Cropping data ############
so_extent <- ext(-60, -20, -65, -45)

# The crop function for raster data...
so_topo <- crop(etopo_25, so_extent)

# ... and the st_crop function to reduce some higher resolution coastline data
ne_10 <- st_read('../data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')
st_agr(ne_10) <- 'constant'
so_ne_10 <- st_crop(ne_10, so_extent)

## Create map
# Define palette
sea_pal <- colorRampPalette(c('grey30', 'grey50', 'grey70'))

# Plot the underlying sea bathymetry
plot(so_topo, col=sea_pal(100), asp=1, legend=FALSE)
contour(so_topo, levels=c(-2000, -4000, -6000), add=TRUE, col='grey80') # add contours to show different levels

# Add the land
plot(st_geometry(so_ne_10), add=TRUE, col='khaki', border='grey40')

# Show the sampling sites
plot(st_geometry(so_data), add=TRUE, pch=4, cex=2, col='white', lwd=3)
dev.off()



############ Spatial joints and raster data extraction ############

############ Spatial joining ############
## Create some random data for demonstration
set.seed(1)
# extract Africa from the ne_110 data and keep the columns we want to use
africa <- subset(ne_110, CONTINENT=='Africa', select=c('ADMIN', 'POP_EST'))

# transform to the Robinson projection
africa <- st_transform(africa, crs='ESRI:54030')
# create a random sample of points
mosquito_points <- st_sample(africa, 1000)

# Create the plot
plot(st_geometry(africa), col='khaki')
plot(mosquito_points, col='firebrick', add=TRUE)

## Join the data
mosquito_points <- st_sf(mosquito_points)
mosquito_points <- st_join(mosquito_points, africa['ADMIN'])

plot(st_geometry(africa), col='khaki')

# Add points coloured by country
plot(mosquito_points['ADMIN'], add=TRUE)

## Aggregate the points within countries
mosquito_points_agg <- aggregate(
     mosquito_points, 
     by=list(country=mosquito_points$ADMIN), FUN=length
)
names(mosquito_points_agg)[2] <-'n_outbreaks'
print(mosquito_points_agg)

# Merge the number of outbreaks back onto the sf data
africa <- st_join(africa, mosquito_points_agg)
africa$area <- as.numeric(st_area(africa))
print(africa)

# Plot the results
par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1, 0))
plot(n_outbreaks ~ POP_EST, data=africa, log='xy', 
     ylab='Number of outbreaks', xlab='Population size')
plot(n_outbreaks ~ area, data=africa, log='xy',
     ylab='Number of outbreaks', xlab='Area (m2)')


############ Extracting data from Rasters ############
# Load the data
uk_eire_etopo <- rast('../data/uk/etopo_uk.tif')

## Masking elevation data
uk_eire_detail <- subset(ne_10, ADMIN %in% c('United Kingdom', "Ireland"))
uk_eire_detail_raster <- rasterize(uk_eire_detail, uk_eire_etopo)
uk_eire_elev <- mask(uk_eire_etopo, uk_eire_detail_raster)

par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(uk_eire_etopo, plg=list(ext=c(3,4, 50, 59)))
plot(uk_eire_elev, plg=list(ext=c(3,4, 50, 59)))
plot(st_geometry(uk_eire_detail), add=TRUE, border='grey')


############ Raster cell statistics and locations ############
uk_eire_elev >= 1195

global(uk_eire_elev, max, na.rm=TRUE)
global(uk_eire_elev, quantile, na.rm=TRUE)

# Which is the highest cell
where.max(uk_eire_elev)

# Which cells are above 1100m
high_points <- where.max(uk_eire_elev >= 1100, value=FALSE)
xyFromCell(uk_eire_elev, high_points[,2])

## Highlight highest point and areas below sea level
max_cell <- where.max(uk_eire_elev)
max_xy <- xyFromCell(uk_eire_elev, max_cell[2])
max_sfc<- st_sfc(st_point(max_xy), crs=4326)

bsl_cell <- where.max(uk_eire_elev < 0, values=FALSE)
bsl_xy <- xyFromCell(uk_eire_elev, bsl_cell[,2])
bsl_sfc <- st_sfc(st_multipoint(bsl_xy), crs=4326)

plot(uk_eire_elev)
plot(max_sfc, add=TRUE, pch=24, bg='red')
plot(bsl_sfc, add=TRUE, pch=25, bg='lightblue', cex=0.6)


############ The extract function ############
## Extract raster values under points
uk_eire_capitals$elev <- extract(uk_eire_elev, uk_eire_capitals, ID=FALSE)
print(uk_eire_capitals)

## Extract from polygons
etopo_by_country <- extract(uk_eire_elev, uk_eire_sf['name'])
head(etopo_by_country)

# Summary stats
aggregate(etopo_uk ~ ID, data=etopo_by_country, FUN='mean', na.rm=TRUE)

# Specify a summary statistic that should be calculated within polygons
zones <- rasterize(st_transform(uk_eire_sf, 4326), uk_eire_elev, field='name')
etopo_by_country <- zonal(uk_eire_elev, zones, fun='mean', na.rm=TRUE)

print(etopo_by_country)

## Extract values under linestrings
st_layers('../data/uk/National_Trails_Pennine_Way.gpx')

# load the data, showing off the ability to use SQL queries to load subsets of the data
pennine_way <- st_read('../data/uk/National_Trails_Pennine_Way.gpx',
                      query="select * from routes where name='Pennine Way'")

# reproject the vector data
pennine_way_BNG <- st_transform(pennine_way, crs=27700)
# create the target raster and project the elevation data into it.
bng_2km <- rast(xmin=-200000, xmax=700000, ymin=0, ymax=1000000, 
                res=2000, crs='EPSG:27700')
uk_eire_elev_BNG <- project(uk_eire_elev, bng_2km, method='cubic')

# Simplify the data
pennine_way_BNG_simple <- st_simplify(pennine_way_BNG,  dTolerance=100)

# Zoom in to the whole route and plot the data
par(mfrow=c(1,2), mar=c(1,1,1,1))

plot(uk_eire_elev_BNG, xlim=c(3e5, 5e5), ylim=c(3.8e5, 6.3e5),
     axes=FALSE, legend=FALSE)
plot(st_geometry(pennine_way_BNG), add=TRUE, col='black')
plot(st_geometry(pennine_way_BNG_simple), add=TRUE, col='darkred')

# Add a zoom box and use that to create a new plot
zoom <- ext(3.78e5, 3.84e5, 4.72e5, 4.80e5)
plot(zoom, add=TRUE, border='red')

# Zoomed in plot
plot(uk_eire_elev_BNG, ext=zoom, axes=FALSE, legend=FALSE)
plot(st_geometry(pennine_way_BNG), add=TRUE, col='black')
plot(st_geometry(pennine_way_BNG_simple), add=TRUE, col='darkred')

# Extract the data
pennine_way_trans <- extract(uk_eire_elev_BNG, pennine_way_BNG_simple, xy=TRUE)
head(pennine_way_trans)

# Now we can use Pythagoras to find the distance along the transect
pennine_way_trans$dx <- c(0, diff(pennine_way_trans$x))
pennine_way_trans$dy <- c(0, diff(pennine_way_trans$y))
pennine_way_trans$distance_from_last <- with(pennine_way_trans, sqrt(dx^2 + dy^2))
pennine_way_trans$distance <- cumsum(pennine_way_trans$distance_from_last) / 1000

plot( etopo_uk ~ distance, data=pennine_way_trans, type='l', 
     ylab='Elevation (m)', xlab='Distance (km)')
