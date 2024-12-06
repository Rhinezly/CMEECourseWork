############ Species Distribution Modelling ############

############ The BIOCLIM model ############

############ Fitting the model ############
# Get the coordinates of 80% of the data for training 
train_locs <- st_coordinates(subset(tapir_GBIF, kfold != 1))

# Fit the model
bioclim_model <- bioclim(as(bioclim_hist_local, 'Raster'), train_locs)

par(mfrow=c(1,2))
plot(bioclim_model, a=1, b=2, p=0.5)
plot(bioclim_model, a=1, b=5, p=0.5)


############ Model predictions ############
bioclim_pred <- predict(bioclim_hist_local, bioclim_model)

# Create a copy removing zero scores to focus on within envelope locations
bioclim_non_zero <- bioclim_pred
bioclim_non_zero[bioclim_non_zero == 0] <- NA
plot(land, col='grey', legend=FALSE)
plot(bioclim_non_zero, col=hcl.colors(20, palette='Blue-Red'), add=TRUE)


############ Model evaluation ############
test_locs <- st_coordinates(subset(tapir_GBIF, kfold == 1))
test_pseudo <- st_coordinates(subset(pseudo_nearby, kfold == 1))
bioclim_eval <- evaluate(p=test_locs, a=test_pseudo, 
                         model=bioclim_model, x=bioclim_hist_local)
print(bioclim_eval)

## Create some standard plots
par(mfrow=c(1,2))

# Plot the ROC curve
plot(bioclim_eval, 'ROC', type='l')

# Find the maximum kappa and show how kappa changes with the model threshold
max_kappa <- threshold(bioclim_eval, stat='kappa')
plot(bioclim_eval, 'kappa', type='l')
abline(v=max_kappa, lty=2, col='blue')


############ Species distribution ############
# Apply the threshold to the model predictions
tapir_range <- bioclim_pred >= max_kappa
plot(tapir_range, legend=FALSE, col=c('khaki3','red'))
plot(st_geometry(tapir_GBIF), add=TRUE, pch=4, col='#00000088')

## Future distribution of the tapir
# Predict from the same model but using the future data
bioclim_pred_future <- predict(bioclim_future_local, bioclim_model)
# Apply the same threshold
tapir_range_future <- bioclim_pred_future >= max_kappa

par(mfrow=c(1,3), mar=c(2,2,1,1))
plot(tapir_range, legend=FALSE, col=c('grey','red'))
plot(tapir_range_future, legend=FALSE, col=c('grey','red'))

# This is a bit of a hack - adding 2 * hist + 2050 gives:
# 0 + 0 - present in neither model
# 0 + 1 - only in future
# 2 + 0 - only in hist
# 2 + 1 - in both
tapir_change <- 2 * (tapir_range) + tapir_range_future
cols <- c('lightgrey', 'blue', 'red', 'forestgreen')

plot(tapir_change, col=cols, legend=FALSE)
legend(-6e5, 1.14e7, fill=cols, 
       legend=c('Absent','Future','Historical', 'Both'), 
       bg='white')



############ Generalized linear model (GLM) ############

############ Data restructuring ############
# Create a single sf object holding presence and pseudo-absence data.
# - reduce the GBIF data and pseudo-absence to just kfold and a presence-absence value
present <- subset(tapir_GBIF, select='kfold')
present$pa <- 1
absent <- pseudo_nearby
absent$pa <- 0

# - rename the geometry column of absent to match so we can stack them together.
names(absent) <- c('geometry','kfold','pa')
st_geometry(absent) <- 'geometry'

# - stack the two dataframes
pa_data <- rbind(present, absent)
print(pa_data)

# extract the environmental values for each point and add into the data frame
envt_data <- extract(bioclim_hist_local, pa_data)
pa_data <- cbind(pa_data, envt_data)
print(pa_data)


############ Fitting the GLM ############
glm_model <- glm(pa ~ bio2 + bio4 + bio3 + bio1 + bio12, data=pa_data, 
                 family=binomial(link = "logit"),
                 subset=kfold != 1)

# Look at the variable significances - which are important
summary(glm_model)

# Response plots
par(mar=c(3,3,1,1), mgp=c(2,1,0))
response(glm_model, fun=function(x, y, ...) predict(x, y, type='response', ...))


############ Model predictions and evaluation ############
## Create a prediction layer
glm_pred <- predict(bioclim_hist_local, glm_model, type='response')

## Evaluate the model using the test data.
# Extract the test presence and absence
test_present <- st_coordinates(subset(pa_data, pa == 1 & kfold == 1))
test_absent <- st_coordinates(subset(pa_data, pa == 0 & kfold == 1))
glm_eval <- evaluate(p=test_present, a=test_absent, model=glm_model, 
                     x=bioclim_hist_local)
print(glm_eval)

## Find the maximum kappa threshold
max_kappa <- plogis(threshold(glm_eval, stat='kappa'))
print(max_kappa)

## Look at some model performance plots
par(mfrow=c(1,2))
# ROC curve and kappa by model threshold
plot(glm_eval, 'ROC', type='l')
plot(glm_eval, 'kappa', type='l')
abline(v=max_kappa, lty=2, col='blue')


############ Species distribution from GLM ############
par(mfrow=c(2,2))

# Modelled probability
plot(glm_pred, col=hcl.colors(20, 'Blue-Red'))

# Threshold map
glm_map <- glm_pred >= max_kappa
plot(glm_map, legend=FALSE, col=c('grey','red'))

# Future predictions
glm_pred_future <- predict(bioclim_future_local, glm_model, type='response')
plot(glm_pred_future, col=hcl.colors(20, 'Blue-Red'))

# Threshold map
glm_map_future <- glm_pred_future >= max_kappa
plot(glm_map_future, legend=FALSE, col=c('grey','red'))

## Decribe the modelled changes
table(values(glm_map), values(glm_map_future), dnn=c('hist', '2050'))
