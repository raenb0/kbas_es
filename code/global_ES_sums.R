# Calculate global ES sums

library(terra)
library(tidyverse)

getwd() #"C:/Users/rneugarten/Documents/Github/kbas_es"

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

# Calculate global ES sums--------------------------
coastal_protection_reef_sum_global <- global(coastal_protection_reef, fun = "sum", na.rm = T)
coastal_protection_sum_global <- global(coastal_protection, fun = "sum", na.rm = T)
coastal_protection_offshore_sum_global <- global(coastal_protection_offshore, fun = "sum", na.rm = T)
coastal_protection_onshore_sum_global <- global(coastal_protection_onshore, fun = "sum", na.rm = T)
commercial_timber_sum_global <- global(commercial_timber, fun = "sum", na.rm = T)
domestic_timber_sum_global <- global(domestic_timber, fun = "sum", na.rm = T)
flood_mitigation_500km_sum_global <- global(flood_mitigation_500km, fun = "sum", na.rm = T)
flood_mitigation_50km_sum_global <- global(flood_mitigation_50km, fun = "sum", na.rm = T)
fuelwood_sum_global <- global(fuelwood, fun = "sum", na.rm = T)
fwfish_sum_global <- global(fwfish, fun = "sum", na.rm = T)
grazing_sum_global <- global(grazing, fun = "sum", na.rm = T)
marinefish_sum_global <- global(marinefish, fun = "sum", na.rm = T)
moisture_recycling_sum_global <- global(moisture_recycling, fun = "sum", na.rm = T)
nitrogen_retention_500km_sum_global <- global(nitrogen_retention_500km, fun = "sum", na.rm = T)
nitrogen_retention_50km_sum_global <- global(nitrogen_retention_50km, fun = "sum", na.rm = T)
nature_access_rural_6hr_sum_global <- global(nature_access_rural_6hr, fun = "sum", na.rm = T)
nature_access_rural_1hr_sum_global <- global(nature_access_rural_1hr, fun = "sum", na.rm = T)
nature_access_urban_6hr_sum_global <- global(nature_access_urban_6hr, fun = "sum", na.rm = T)
nature_access_urban_1hr_sum_global <- global(nature_access_urban_1hr, fun = "sum", na.rm = T)
pollination_sum_global <- global(pollination, fun = "sum", na.rm = T)
reef_tourism_sum_global <- global(reef_tourism, fun = "sum", na.rm = T)
sediment_deposition_500km_sum_global <- global(sediment_deposition_500km, fun = "sum", na.rm = T)
sediment_deposition_50km_sum_global <- global(sediment_deposition_50km, fun = "sum", na.rm = T)
vulnerable_carbon_sum_global <- global(vulnerable_carbon, fun = "sum", na.rm = T)

## Setup output file
es_global_sum_df <- data.frame(coastal_protection_reef = coastal_protection_reef_sum_global,
                     coastal_protection = coastal_protection_sum_global,
                     coastal_protection_offshore = coastal_protection_offshore_sum_global,
                     coastal_protection_onshore = coastal_protection_onshore_sum_global,
                     commercial_timber = commercial_timber_sum_global,
                     domestic_timber = domestic_timber_sum_global,
                     flood_mitigation_500km = flood_mitigation_500km_sum_global,
                     flood_mitigation_50km = flood_mitigation_50km_sum_global,
                     fuelwood = fuelwood_sum_global,
                     fwfish = fwfish_sum_global,
                     grazing = grazing_sum_global,
                     marinefish = marinefish_sum_global,
                     moisture_recycling = moisture_recycling_sum_global,
                     nitrogen_retention_500km = nitrogen_retention_500km_sum_global,
                     nitrogen_retention_50km = nitrogen_retention_50km_sum_global,
                     nature_access_rural_6hr = nature_access_rural_6hr_sum_global,
                     nature_access_rural_1hr = nature_access_rural_1hr_sum_global,
                     nature_access_urban_6hr = nature_access_urban_6hr_sum_global,
                     nature_access_urban_1hr = nature_access_urban_1hr_sum_global,
                     pollination = pollination_sum_global,
                     reef_tourism = reef_tourism_sum_global,
                     sediment_deposition_500km = sediment_deposition_500km_sum_global,
                     sediment_deposition_50km = sediment_deposition_50km_sum_global,
                     vulnerable_carbon = vulnerable_carbon_sum_global)

es_global_sum_df <- rbind(coastal_protection_reef_sum_global,
                               coastal_protection_sum_global,
                               coastal_protection_offshore_sum_global,
                               coastal_protection_onshore_sum_global,
                               commercial_timber_sum_global,
                               domestic_timber_sum_global,
                               flood_mitigation_500km_sum_global,
                               flood_mitigation_50km_sum_global,
                               fuelwood_sum_global,
                               fwfish_sum_global,
                               grazing_sum_global,
                               marinefish_sum_global,
                               moisture_recycling_sum_global,
                               nitrogen_retention_500km_sum_global,
                               nitrogen_retention_50km_sum_global,
                               nature_access_rural_6hr_sum_global,
                               nature_access_rural_1hr_sum_global,
                               nature_access_urban_6hr_sum_global,
                               nature_access_urban_1hr_sum_global,
                               pollination_sum_global,
                               reef_tourism_sum_global,
                               sediment_deposition_500km_sum_global,
                               sediment_deposition_50km_sum_global,
                               vulnerable_carbon_sum_global)

## Export
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")
write.csv(es_global_sum_df, paste0("outputs/ES_global_sums_14Oct2024.csv"))
