library(terra)
library(tidyverse)

## Load countries
countries <- vect("~/Dropbox/Documents/Datasets/GADM/gadm_410_level0/gadm_410_level0.shp")
country_ids <- countries$GID_0

## Load Ecosystem Services 2km
setwd("C:/users/rneugarten/OneDrive - Wildlife Conservation Society/_WCS/GIS_WCS/EcosystemServices_ChaplinKramer/reprojected_resampled_Eckert2km")
coastal_protection_reef <- rast("realized_coastalprotection_barrierreef.tif")
coastal_protection <- rast("realized_coastalprotection_norm.tif")
coastal_protection_offshore <- rast("realized_coastalprotection_norm_offshore.tif")
coastal_protection_onshore <- rast("realized_coastalprotection_norm_onshore.tif")
commercial_timber <- rast("realized_commercialtimber_forest.tif")
domestic_timber <- rast("realized_domestictimber_forest.tif")
flood_mitigation_500km <- rast("realized_floodmitigation_attn_500km_nathab.tif")
flood_mitigation_50km <- rast("realized_floodmitigation_attn_50km.tif")
fuelwood <- rast("realized_fuelwood_forest.tif")
fwfish <- rast("realized_fwfish_per_km2.tif")
grazing <- rast("realized_grazing_natnotforest.tif")
marinefish <- rast("realized_marinefish_watson_2010_2014.tif")
moisture_recycling <- rast("realized_moisturerecycling_nathab30s.tif")
nitrogen_retention_500km <- rast("realized_nitrogenretention_attn_500km.tif")
nitrogen_retention_50km <- rast("realized_nitrogenretention_attn_50km.tif")
nature_access_rural_6hr <- rast("realized_nature_access_rural_6h.tif")
nature_access_rural_1hr <- rast("realized_nature_access_rural_1h.tif")
nature_access_urban_6hr <- rast("realized_nature_access_urban_6h.tif")
nature_access_urban_1hr <- rast("realized_nature_access_urban_1h.tif")
pollination <- rast("realized_pollination_norm_nathab.tif")
reef_tourism <- rast("realized_reeftourism_Modelled_Total_Dollar_Value.tif")
sediment_deposition_500km <- rast("realized_sedimentdeposition_attn_500km.tif")
sediment_deposition_50km <- rast("realized_sedimentdeposition_attn_50km.tif")
vulnerable_carbon <- rast("Vulnerable_C_Total_2018.tif")
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")

## Project countries
countries <- project(countries, coastal_protection_reef)

## Setup data storage variables
coastal_protection_reef_sum <- rep(NA, nrow(countries))
coastal_protection_sum <- rep(NA, nrow(countries))
coastal_protection_offshore_sum <- rep(NA, nrow(countries))
coastal_protection_onshore_sum <- rep(NA, nrow(countries))
commercial_timber_sum <- rep(NA, nrow(countries))
domestic_timber_sum <- rep(NA, nrow(countries))
flood_nathab_sum <- rep(NA, nrow(countries))
flood_mitigation_500km_sum <- rep(NA, nrow(countries))
flood_mitigation_50km_sum <- rep(NA, nrow(countries))
fuelwood_sum <- rep(NA, nrow(countries))
fwfish_sum <- rep(NA, nrow(countries))
grazing_sum <- rep(NA, nrow(countries))
marinefish_sum <- rep(NA, nrow(countries))
moisture_recycling_sum <- rep(NA, nrow(countries))
nitrogen_retention_500km_sum <- rep(NA, nrow(countries))
nitrogen_retention_50km_sum <- rep(NA, nrow(countries))
nature_access_rural_6hr_sum <- rep(NA, nrow(countries))
nature_access_rural_1hr_sum <- rep(NA, nrow(countries))
urban_nature_access_360_sum <- rep(NA, nrow(countries))
nature_access_urban_1hr_sum <- rep(NA, nrow(countries))
pollination_sum <- rep(NA, nrow(countries))
reef_tourism_sum <- rep(NA, nrow(countries))
sediment_deposition_500km_sum <- rep(NA, nrow(countries))
sediment_deposition_50km_sum <- rep(NA, nrow(countries))
vulnerable_carbon_sum <- rep(NA, nrow(countries))

## Loop through countries
for(i in 1:nrow(countries)) { 
  
  ## Get country i
  country_id_i <- country_ids[i]
  country_i <- subset(countries, countries$GID_0 == country_id_i)
  
  ## Crop ES rasters
  coastal_protection_reef_i <- crop(coastal_protection_reef, country_i, touches = F, mask = T)
  coastal_protection_i <- crop(coastal_protection, country_i, touches = F, mask = T)
  coastal_protection_offshore_i <- crop(coastal_protection_offshore, country_i, touches = F, mask = T)
  coastal_protection_onshore_i <- crop(coastal_protection_onshore, country_i, touches = F, mask = T)
  commercial_timber_i <- crop(commercial_timber, country_i, touches = F, mask = T)
  domestic_timber_i <- crop(domestic_timber, country_i, touches = F, mask = T)
  flood_nathab_i <- crop(flood_nathab, country_i, touches = F, mask = T)
  flood_mitigation_500km_i <- crop(flood_mitigation_500km, country_i, touches = F, mask = T)
  flood_mitigation_50km_i <- crop(flood_mitigation_50km, country_i, touches = F, mask = T)
  fuelwood_i <- crop(fuelwood, country_i, touches = F, mask = T)
  fwfish_i <- crop(fwfish, country_i, touches = F, mask = T)
  grazing_i <- crop(grazing, country_i, touches = F, mask = T)
  marinefish_i <- crop(marinefish, country_i, touches = F, mask = T)
  moisture_recycling_i <- crop(moisture_recycling, country_i, touches = F, mask = T)
  nitrogen_retention_500km_i <- crop(nitrogen_retention_500km, country_i, touches = F, mask = T)
  nitrogen_retention_50km_i <- crop(nitrogen_retention_50km, country_i, touches = F, mask = T)
  nature_access_rural_6hr_i <- crop(nature_access_rural_6hr, country_i, touches = F, mask = T)
  nature_access_rural_1hr_i <- crop(nature_access_rural_1hr, country_i, touches = F, mask = T)
  urban_nature_access_360_i <- crop(urban_nature_access_360, country_i, touches = F, mask = T)
  nature_access_urban_1hr_i <- crop(nature_access_urban_1hr, country_i, touches = F, mask = T)
  pollination_i <- crop(pollination, country_i, touches = F, mask = T)
  reef_tourism_i <- crop(reef_tourism, country_i, touches = F, mask = T)
  sediment_deposition_500km_i <- crop(sediment_deposition_500km, country_i, touches = F, mask = T)
  sediment_deposition_50km_i <- crop(sediment_deposition_50km, country_i, touches = F, mask = T)
  vulnerable_carbon_i <- crop(vulnerable_carbon, country_i, touches = F, mask = T)
  
  ## Get ES value sums
  coastal_protection_reef_sum[i] <- global(coastal_protection_reef_i, fun = "sum", na.rm = T)[[1]]
  coastal_protection_sum[i] <- global(coastal_protection_i, fun = "sum", na.rm = T)[[1]]
  coastal_protection_offshore_sum[i] <- global(coastal_protection_offshore_i, fun = "sum", na.rm = T)[[1]]
  coastal_protection_onshore_sum[i] <- global(coastal_protection_onshore_i, fun = "sum", na.rm = T)[[1]]
  commercial_timber_sum[i] <- global(commercial_timber_i, fun = "sum", na.rm = T)[[1]]
  domestic_timber_sum[i] <- global(domestic_timber_i, fun = "sum", na.rm = T)[[1]]
  flood_nathab_sum[i] <- global(flood_nathab_i, fun = "sum", na.rm = T)[[1]]
  flood_mitigation_500km_sum[i] <- global(flood_mitigation_500km_i, fun = "sum", na.rm = T)[[1]]
  flood_mitigation_50km_sum[i] <- global(flood_mitigation_50km_i, fun = "sum", na.rm = T)[[1]]
  fuelwood_sum[i] <- global(fuelwood_i, fun = "sum", na.rm = T)[[1]]
  fwfish_sum[i] <- global(fwfish_i, fun = "sum", na.rm = T)[[1]]
  grazing_sum[i] <- global(grazing_i, fun = "sum", na.rm = T)[[1]]
  marinefish_sum[i] <- global(marinefish_i, fun = "sum", na.rm = T)[[1]]
  moisture_recycling_sum[i] <- global(moisture_recycling_i, fun = "sum", na.rm = T)[[1]]
  nitrogen_retention_500km_sum[i] <- global(nitrogen_retention_500km_i, fun = "sum", na.rm = T)[[1]]
  nitrogen_retention_50km_sum[i] <- global(nitrogen_retention_50km_i, fun = "sum", na.rm = T)[[1]]
  nature_access_rural_6hr_sum[i] <- global(nature_access_rural_6hr_i, fun = "sum", na.rm = T)[[1]]
  nature_access_rural_1hr_sum[i] <- global(nature_access_rural_1hr_i, fun = "sum", na.rm = T)[[1]]
  urban_nature_access_360_sum[i] <- global(urban_nature_access_360_i, fun = "sum", na.rm = T)[[1]]
  nature_access_urban_1hr_sum[i] <- global(nature_access_urban_1hr_i, fun = "sum", na.rm = T)[[1]]
  pollination_sum[i] <- global(pollination_i, fun = "sum", na.rm = T)[[1]]
  reef_tourism_sum[i] <- global(reef_tourism_i, fun = "sum", na.rm = T)[[1]]
  sediment_deposition_500km_sum[i] <- global(sediment_deposition_500km_i, fun = "sum", na.rm = T)[[1]]
  sediment_deposition_50km_sum[i] <- global(sediment_deposition_50km_i, fun = "sum", na.rm = T)[[1]]
  vulnerable_carbon_sum[i] <- global(vulnerable_carbon_i, fun = "sum", na.rm = T)[[1]]

  # Keep track of progress
  print(paste0(country_i$GID_0, " - ", i, " of ", nrow(countries), " completed"))
  
}

## Setup country output file
country_df <- data.frame(country = countries$COUNTRY,
                         country_id = country_ids,
                         coastal_protection_reef = coastal_protection_reef_sum,
                         coastal_protection = coastal_protection_sum,
                         coastal_protection_offshore = coastal_protection_offshore_sum,
                         coastal_protection_onshore = coastal_protection_onshore_sum,
                         commercial_timber = commercial_timber_sum,
                         domestic_timber = domestic_timber_sum,
                         flood_nathab = flood_nathab_sum,
                         flood_mitigation_500km = flood_mitigation_500km_sum,
                         flood_mitigation_50km = flood_mitigation_50km_sum,
                         fuelwood = fuelwood_sum,
                         fwfish = fwfish_sum,
                         grazing = grazing_sum,
                         marinefish = marinefish_sum,
                         moisture_recycling = moisture_recycling_sum,
                         nitrogen_retention_500km = nitrogen_retention_500km_sum,
                         nitrogen_retention_50km = nitrogen_retention_50km_sum,
                         nature_access_rural_6hr = nature_access_rural_6hr_sum,
                         nature_access_rural_1hr = nature_access_rural_1hr_sum,
                         urban_nature_access_360 = urban_nature_access_360_sum,
                         nature_access_urban_1hr = nature_access_urban_1hr_sum,
                         pollination = pollination_sum,
                         reef_tourism = reef_tourism_sum,
                         sediment_deposition_500km = sediment_deposition_500km_sum,
                         sediment_deposition_50km = sediment_deposition_50km_sum,
                         vulnerable_carbon = vulnerable_carbon_sum)

## Convert all NaNs to 0
country_df <- country_df %>% 
  mutate(across(everything(), ~replace(.x, is.nan(.x), 0)))

## Export
setwd("~/Dropbox/Documents/Manuscripts/Drafts/KBA_ES/data")
write.csv(country_df, paste0("country_ES_data.csv"))
