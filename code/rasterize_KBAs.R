# Rasterize the KBA shapefile

library(terra)
library(tictoc)

getwd() #"C:/Users/rneugarten/Documents/Github/kbas_es"

## Load KBAs
kbas <- vect("data/KBAsGlobal_2023_September_02_POL.shp")

## Load ES layer to harmonize projection
setwd("C:/users/rneugarten/OneDrive - Wildlife Conservation Society/_WCS/GIS_WCS/EcosystemServices_ChaplinKramer/reprojected_resampled_Eckert2km")
coastal_protection_reef <- rast("realized_coastalprotection_barrierreef.tif")
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")

## Project KBAs to match ES layer
kbas <- project(kbas, coastal_protection_reef)

# Define the rasterization parameters
# Set the extent and resolution of the output SpatRaster
# Adjust resolution as needed
resolution <- 2000  # Example resolution (2000 m, hopefully)
extent_kbas <- ext(kbas)  # Get the extent of the SpatVector

# Create an empty SpatRaster with the desired extent and resolution
r <- rast(extent_kbas, resolution = resolution)

# Rasterize the SpatVector object
# Specify the field to rasterize if the SpatVector has multiple attributes
# Replace "field_name" with the actual attribute name or use NULL for default
kbas@cpp[["names"]] #names include SitReCID, Region, Country, ISO3, etc.
kbas$value <- 1  # Add a new attribute with value 1 to the SpatVector
tic()
kba_rast <- rasterize(kbas, r, field = "value", background = 0)  # Replace "field_name" as needed
toc()
plot(kba_rast)

#now repeat to create the inverse
kbas$value2 <-0

tic()
no_kba_rast <- rasterize(kbas, r, field = "value2", background = 1)  # Replace "field_name" as needed
toc()
plot(no_kba_rast)


# export TIF files
writeRaster(kba_rast, "data/kba_raster.tif", overwrite = TRUE)
writeRaster(kba_rast, "data/no_kba_raster.tif", overwrite = TRUE)

