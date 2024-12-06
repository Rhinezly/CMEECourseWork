############ Does our background choice matter? ############

# 1. Create the new dataset
present <- subset(tapir_GBIF, select='kfold')
present$pa <- 1
absent <- pseudo_dismo
absent$pa <- 0

# - rename the geometry column of absent to match so we can stack them together.
names(absent) <- c('geometry','kfold','pa')
st_geometry(absent) <- 'geometry'
# - stack the two dataframes
pa_data_bg2 <- rbind(present, absent)
# - Add the envt.
envt_data <- extract(bioclim_hist_local, pa_data_bg2)
pa_data_bg2 <- cbind(pa_data_bg2, envt_data)

# 2. Fit the model
glm_model_bg2 <-glm(pa ~ bio2 + bio4 + bio3 + bio1 + bio12, data=pa_data_bg2, 
                  family=binomial(link = "logit"),
                  subset=kfold != 1)

# 3. New predictions
glm_pred_bg2 <- predict(bioclim_hist_local, glm_model_bg2, type='response')

# 4. Plot modelled probability using the same colour scheme and using
# axis args to keep a nice simple axis on the legend
par(mfrow=c(1,3))
bks <- seq(0, 1, by=0.01)
cols <- hcl.colors(100, 'Blue-Red')
plot(glm_pred, col=cols, breaks=bks, main='Buffered Background', 
     type='continuous', plg=list(ext=c(1.25e6, 1.3e6, 9.3e6, 11.5e6)))
plot(glm_pred_bg2, col=cols, breaks=bks, main='Extent Background',
     type='continuous', plg=list(ext=c(1.25e6, 1.3e6, 9.3e6, 11.5e6)))
plot(glm_pred - glm_pred_bg2, col= hcl.colors(100), main='Difference',
     type='continuous', plg=list(ext=c(1.25e6, 1.3e6, 9.3e6, 11.5e6)))



############ Reducing the set of variables ############

# We can use the values from the environmental data in a cluster algorithm.
# This is a statistical process that groups sets of values by their similarity
# and here we are using the local raster data (to get a good local sample of the 
# data correlation) to perform that clustering.
clust_data <- values(bioclim_hist_local)
clust_data <- na.omit(clust_data)

# Scale and center the data
clust_data <- scale(clust_data)

# Transpose the data matrix to give variables as rows
clust_data <- t(clust_data)

# Find the distance between variables and cluster
clust_dist <- dist(clust_data)
clust_output <- hclust(clust_dist)
plot(clust_output)

# And then pick one from each of five blocks - haphazardly.
rect.hclust(clust_output, k=5)
