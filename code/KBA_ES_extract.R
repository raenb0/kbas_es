##KBAs and ecosystem services
#Rachel Neugarten

library(terra)
library(tidyverse)
library(tictoc)

getwd() #"C:/Users/rneugarten/Documents/Github/kbas_es"

# Load datasets ------------------

## Load KBAs
kbas <- vect("data/KBAsGlobal_2023_September_02_POL.shp")
kba_ids <- kbas$SitRecID

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

# Data setup --------------------------------

## Project KBAs
kbas <- project(kbas, coastal_protection_reef)

## Setup data storage variables (sum)
coastal_protection_reef_sum <- rep(NA, nrow(kbas))
coastal_protection_sum <- rep(NA, nrow(kbas))
coastal_protection_offshore_sum <- rep(NA, nrow(kbas))
coastal_protection_onshore_sum <- rep(NA, nrow(kbas))
commercial_timber_sum <- rep(NA, nrow(kbas))
domestic_timber_sum <- rep(NA, nrow(kbas))
flood_mitigation_500km_sum <- rep(NA, nrow(kbas))
flood_mitigation_50km_sum <- rep(NA, nrow(kbas))
fuelwood_sum <- rep(NA, nrow(kbas))
fwfish_sum <- rep(NA, nrow(kbas))
grazing_sum <- rep(NA, nrow(kbas))
marinefish_sum <- rep(NA, nrow(kbas))
moisture_recycling_sum <- rep(NA, nrow(kbas))
nitrogen_retention_500km_sum <- rep(NA, nrow(kbas))
nitrogen_retention_50km_sum <- rep(NA, nrow(kbas))
nature_access_rural_6hr_sum <- rep(NA, nrow(kbas))
nature_access_rural_1hr_sum <- rep(NA, nrow(kbas))
nature_access_urban_6hr_sum <- rep(NA, nrow(kbas))
nature_access_urban_1hr_sum <- rep(NA, nrow(kbas))
pollination_sum <- rep(NA, nrow(kbas))
reef_tourism_sum <- rep(NA, nrow(kbas))
sediment_deposition_500km_sum <- rep(NA, nrow(kbas))
sediment_deposition_50km_sum <- rep(NA, nrow(kbas))
vulnerable_carbon_sum <- rep(NA, nrow(kbas))

# repeat for mean values

## Setup data storage variables (mean)
coastal_protection_reef_mean <- rep(NA, nrow(kbas))
coastal_protection_mean <- rep(NA, nrow(kbas))
coastal_protection_offshore_mean <- rep(NA, nrow(kbas))
coastal_protection_onshore_mean <- rep(NA, nrow(kbas))
commercial_timber_mean <- rep(NA, nrow(kbas))
domestic_timber_mean <- rep(NA, nrow(kbas))
flood_mitigation_500km_mean <- rep(NA, nrow(kbas))
flood_mitigation_50km_mean <- rep(NA, nrow(kbas))
fuelwood_mean <- rep(NA, nrow(kbas))
fwfish_mean <- rep(NA, nrow(kbas))
grazing_mean <- rep(NA, nrow(kbas))
marinefish_mean <- rep(NA, nrow(kbas))
moisture_recycling_mean <- rep(NA, nrow(kbas))
nitrogen_retention_500km_mean <- rep(NA, nrow(kbas))
nitrogen_retention_50km_mean <- rep(NA, nrow(kbas))
nature_access_rural_6hr_mean <- rep(NA, nrow(kbas))
nature_access_rural_1hr_mean <- rep(NA, nrow(kbas))
nature_access_urban_6hr_mean <- rep(NA, nrow(kbas))
nature_access_urban_1hr_mean <- rep(NA, nrow(kbas))
pollination_mean <- rep(NA, nrow(kbas))
reef_tourism_mean <- rep(NA, nrow(kbas))
sediment_deposition_500km_mean <- rep(NA, nrow(kbas))
sediment_deposition_50km_mean <- rep(NA, nrow(kbas))
vulnerable_carbon_mean <- rep(NA, nrow(kbas))

## Crop ES rasters to KBAs, loop through KBAs ------------------
tic()
for(i in 1:nrow(kbas)) { 
  
  ## Get kba i
  kba_id_i <- kba_ids[i]
  kba_i <- subset(kbas, kbas$SitRecID == kba_id_i)
  
  ## Crop ES rasters
  coastal_protection_reef_i <- crop(coastal_protection_reef, kba_i, touches = F, mask = T)
  coastal_protection_i <- crop(coastal_protection, kba_i, touches = F, mask = T)
  coastal_protection_offshore_i <- crop(coastal_protection_offshore, kba_i, touches = F, mask = T)
  coastal_protection_onshore_i <- crop(coastal_protection_onshore, kba_i, touches = F, mask = T)
  commercial_timber_i <- crop(commercial_timber, kba_i, touches = F, mask = T)
  domestic_timber_i <- crop(domestic_timber, kba_i, touches = F, mask = T)
  flood_mitigation_500km_i <- crop(flood_mitigation_500km, kba_i, touches = F, mask = T)
  flood_mitigation_50km_i <- crop(flood_mitigation_50km, kba_i, touches = F, mask = T)
  fuelwood_i <- crop(fuelwood, kba_i, touches = F, mask = T)
  fwfish_i <- crop(fwfish, kba_i, touches = F, mask = T)
  grazing_i <- crop(grazing, kba_i, touches = F, mask = T)
  marinefish_i <- crop(marinefish, kba_i, touches = F, mask = T)
  moisture_recycling_i <- crop(moisture_recycling, kba_i, touches = F, mask = T)
  nitrogen_retention_500km_i <- crop(nitrogen_retention_500km, kba_i, touches = F, mask = T)
  nitrogen_retention_50km_i <- crop(nitrogen_retention_50km, kba_i, touches = F, mask = T)
  nature_access_rural_6hr_i <- crop(nature_access_rural_6hr, kba_i, touches = F, mask = T)
  nature_access_rural_1hr_i <- crop(nature_access_rural_1hr, kba_i, touches = F, mask = T)
  nature_access_urban_6hr_i <- crop(nature_access_urban_6hr, kba_i, touches = F, mask = T)
  nature_access_urban_1hr_i <- crop(nature_access_urban_1hr, kba_i, touches = F, mask = T)
  pollination_i <- crop(pollination, kba_i, touches = F, mask = T)
  reef_tourism_i <- crop(reef_tourism, kba_i, touches = F, mask = T)
  sediment_deposition_500km_i <- crop(sediment_deposition_500km, kba_i, touches = F, mask = T)
  sediment_deposition_50km_i <- crop(sediment_deposition_50km, kba_i, touches = F, mask = T)
  vulnerable_carbon_i <- crop(vulnerable_carbon, kba_i, touches = F, mask = T)
  
  # ## Calculate ES value sums in each KBA -------------------------
  # coastal_protection_reef_sum[i] <- global(coastal_protection_reef_i, fun = "sum", na.rm = T)[[1]]
  # coastal_protection_sum[i] <- global(coastal_protection_i, fun = "sum", na.rm = T)[[1]]
  # coastal_protection_offshore_sum[i] <- global(coastal_protection_offshore_i, fun = "sum", na.rm = T)[[1]]
  # coastal_protection_onshore_sum[i] <- global(coastal_protection_onshore_i, fun = "sum", na.rm = T)[[1]]
  # commercial_timber_sum[i] <- global(commercial_timber_i, fun = "sum", na.rm = T)[[1]]
  # domestic_timber_sum[i] <- global(domestic_timber_i, fun = "sum", na.rm = T)[[1]]
  # flood_mitigation_500km_sum[i] <- global(flood_mitigation_500km_i, fun = "sum", na.rm = T)[[1]]
  # flood_mitigation_50km_sum[i] <- global(flood_mitigation_50km_i, fun = "sum", na.rm = T)[[1]]
  # fuelwood_sum[i] <- global(fuelwood_i, fun = "sum", na.rm = T)[[1]]
  # fwfish_sum[i] <- global(fwfish_i, fun = "sum", na.rm = T)[[1]]
  # grazing_sum[i] <- global(grazing_i, fun = "sum", na.rm = T)[[1]]
  # marinefish_sum[i] <- global(marinefish_i, fun = "sum", na.rm = T)[[1]]
  # moisture_recycling_sum[i] <- global(moisture_recycling_i, fun = "sum", na.rm = T)[[1]]
  # nitrogen_retention_500km_sum[i] <- global(nitrogen_retention_500km_i, fun = "sum", na.rm = T)[[1]]
  # nitrogen_retention_50km_sum[i] <- global(nitrogen_retention_50km_i, fun = "sum", na.rm = T)[[1]]
  # nature_access_rural_6hr_sum[i] <- global(nature_access_rural_6hr_i, fun = "sum", na.rm = T)[[1]]
  # nature_access_rural_1hr_sum[i] <- global(nature_access_rural_1hr_i, fun = "sum", na.rm = T)[[1]]
  # nature_access_urban_6hr_sum[i] <- global(nature_access_urban_6hr_i, fun = "sum", na.rm = T)[[1]]
  # nature_access_urban_1hr_sum[i] <- global(nature_access_urban_1hr_i, fun = "sum", na.rm = T)[[1]]
  # pollination_sum[i] <- global(pollination_i, fun = "sum", na.rm = T)[[1]]
  # reef_tourism_sum[i] <- global(reef_tourism_i, fun = "sum", na.rm = T)[[1]]
  # sediment_deposition_500km_sum[i] <- global(sediment_deposition_500km_i, fun = "sum", na.rm = T)[[1]]
  # sediment_deposition_50km_sum[i] <- global(sediment_deposition_50km_i, fun = "sum", na.rm = T)[[1]]
  # vulnerable_carbon_sum[i] <- global(vulnerable_carbon_i, fun = "sum", na.rm = T)[[1]]
  
## repeat for means: Calculate ES value means in each KBA -------------------------
coastal_protection_reef_mean[i] <- global(coastal_protection_reef_i, fun = "mean", na.rm = T)[[1]]
coastal_protection_mean[i] <- global(coastal_protection_i, fun = "mean", na.rm = T)[[1]]
coastal_protection_offshore_mean[i] <- global(coastal_protection_offshore_i, fun = "mean", na.rm = T)[[1]]
coastal_protection_onshore_mean[i] <- global(coastal_protection_onshore_i, fun = "mean", na.rm = T)[[1]]
commercial_timber_mean[i] <- global(commercial_timber_i, fun = "mean", na.rm = T)[[1]]
domestic_timber_mean[i] <- global(domestic_timber_i, fun = "mean", na.rm = T)[[1]]
flood_mitigation_500km_mean[i] <- global(flood_mitigation_500km_i, fun = "mean", na.rm = T)[[1]]
flood_mitigation_50km_mean[i] <- global(flood_mitigation_50km_i, fun = "mean", na.rm = T)[[1]]
fuelwood_mean[i] <- global(fuelwood_i, fun = "mean", na.rm = T)[[1]]
fwfish_mean[i] <- global(fwfish_i, fun = "mean", na.rm = T)[[1]]
grazing_mean[i] <- global(grazing_i, fun = "mean", na.rm = T)[[1]]
marinefish_mean[i] <- global(marinefish_i, fun = "mean", na.rm = T)[[1]]
moisture_recycling_mean[i] <- global(moisture_recycling_i, fun = "mean", na.rm = T)[[1]]
nitrogen_retention_500km_mean[i] <- global(nitrogen_retention_500km_i, fun = "mean", na.rm = T)[[1]]
nitrogen_retention_50km_mean[i] <- global(nitrogen_retention_50km_i, fun = "mean", na.rm = T)[[1]]
nature_access_rural_6hr_mean[i] <- global(nature_access_rural_6hr_i, fun = "mean", na.rm = T)[[1]]
nature_access_rural_1hr_mean[i] <- global(nature_access_rural_1hr_i, fun = "mean", na.rm = T)[[1]]
nature_access_urban_6hr_mean[i] <- global(nature_access_urban_6hr_i, fun = "mean", na.rm = T)[[1]]
nature_access_urban_1hr_mean[i] <- global(nature_access_urban_1hr_i, fun = "mean", na.rm = T)[[1]]
pollination_mean[i] <- global(pollination_i, fun = "mean", na.rm = T)[[1]]
reef_tourism_mean[i] <- global(reef_tourism_i, fun = "mean", na.rm = T)[[1]]
sediment_deposition_500km_mean[i] <- global(sediment_deposition_500km_i, fun = "mean", na.rm = T)[[1]]
sediment_deposition_50km_mean[i] <- global(sediment_deposition_50km_i, fun = "mean", na.rm = T)[[1]]
vulnerable_carbon_mean[i] <- global(vulnerable_carbon_i, fun = "mean", na.rm = T)[[1]]

# Keep track of progress
print(paste0(kba_i$SitRecID, " - ", i, " of ", nrow(kbas), " completed"))

}
(toc)


## Setup KBA ES sum output file ----------------------------
kba_df <- data.frame(kba = kbas$SitRecID,
                     coastal_protection_reef = coastal_protection_reef_sum,
                     coastal_protection = coastal_protection_sum,
                     coastal_protection_offshore = coastal_protection_offshore_sum,
                     coastal_protection_onshore = coastal_protection_onshore_sum,
                     commercial_timber = commercial_timber_sum,
                     domestic_timber = domestic_timber_sum,
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
                     nature_access_urban_6hr = nature_access_urban_6hr_sum,
                     nature_access_urban_1hr = nature_access_urban_1hr_sum,
                     pollination = pollination_sum,
                     reef_tourism = reef_tourism_sum,
                     sediment_deposition_500km = sediment_deposition_500km_sum,
                     sediment_deposition_50km = sediment_deposition_50km_sum,
                     vulnerable_carbon = vulnerable_carbon_sum)

## repeat for  KBA ES mean output file
kba_df_mean <- data.frame(kba = kbas$SitRecID,
                     coastal_protection_reef = coastal_protection_reef_mean,
                     coastal_protection = coastal_protection_mean,
                     coastal_protection_offshore = coastal_protection_offshore_mean,
                     coastal_protection_onshore = coastal_protection_onshore_mean,
                     commercial_timber = commercial_timber_mean,
                     domestic_timber = domestic_timber_mean,
                     flood_mitigation_500km = flood_mitigation_500km_mean,
                     flood_mitigation_50km = flood_mitigation_50km_mean,
                     fuelwood = fuelwood_mean,
                     fwfish = fwfish_mean,
                     grazing = grazing_mean,
                     marinefish = marinefish_mean,
                     moisture_recycling = moisture_recycling_mean,
                     nitrogen_retention_500km = nitrogen_retention_500km_mean,
                     nitrogen_retention_50km = nitrogen_retention_50km_mean,
                     nature_access_rural_6hr = nature_access_rural_6hr_mean,
                     nature_access_rural_1hr = nature_access_rural_1hr_mean,
                     nature_access_urban_6hr = nature_access_urban_6hr_mean,
                     nature_access_urban_1hr = nature_access_urban_1hr_mean,
                     pollination = pollination_mean,
                     reef_tourism = reef_tourism_mean,
                     sediment_deposition_500km = sediment_deposition_500km_mean,
                     sediment_deposition_50km = sediment_deposition_50km_mean,
                     vulnerable_carbon = vulnerable_carbon_mean)

## Convert all NaNs to 0
kba_df <- kba_df %>% 
  mutate(across(everything(), ~replace(.x, is.nan(.x), 0)))

## repeat for mean df
kba_df_mean <- kba_df_mean %>% 
  mutate(across(everything(), ~replace(.x, is.nan(.x), 0)))

## Export
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")
write.csv(kba_df, paste0("outputs/kba_ES_sums_1Jan2025.csv"))
write.csv(kba_df_mean, paste0("outputs/kba_ES_means_1Jan2025.csv"))

# Calculate percent of global ES in KBAs ----------------------

# Calculate sum of ES contained in all KBAs
kba_es_total_df <- kba_df %>%
  pivot_longer(cols = 2:25, names_to = "es", values_to = "value") %>%
  group_by(es) %>%
  summarize(total_kba = sum(value, na.rm = TRUE))

# Calculate mean of ES contained in all KBAs globally
kba_es_total_mean_df <- kba_df_mean %>%
  pivot_longer(cols = 2:25, names_to = "es", values_to = "value") %>%
  group_by(es) %>%
  summarize(global_mean_kba = mean(value, na.rm = TRUE))

## Export sum of ES contained in all KBAs
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")
write.csv(kba_es_total_df, paste0("outputs/kba_es_total_sum_1Jan2025.csv"))

## Export mean of ES contained in all KBAs
setwd("C:/Users/rneugarten/Documents/Github/kbas_es")
write.csv(kba_es_total_mean_df, paste0("outputs/kba_es_total_mean_1Jan2025.csv"))

#load output from other script if needed: global_ES_sums.R
es_global_sum_df <- read_csv("outputs/ES_global_sums_14Oct2024.csv")
es_global_mean_df <- read_csv("outputs/ES_global_means_1Jan2025.csv")

#rename rows to match KBA ES outputs with help from chatGPT
original_names <- c(
  "realized_coastalprotection_barrierreef",
  "realized_coastalprotection_norm",
  "realized_coastalprotection_norm_offshore",
  "realized_coastalprotection_norm_onshore",
  "realized_commercialtimber_forest",
  "realized_domestictimber_forest",
  "realized_floodmitigation_attn_500km_nathab",
  "realized_floodmitigation_attn_50km",
  "realized_fuelwood_forest",
  "realized_fwfish_per_km2",
  "realized_grazing_natnotforest",
  "realized_marinefish_watson_2010_2014",
  "realized_moisturerecycling_nathab30s",
  "realized_nitrogenretention_attn_500km",
  "realized_nitrogenretention_attn_50km",
  "realized_nature_access_rural_6h",
  "realized_nature_access_rural_1h",
  "realized_nature_access_urban_6h",
  "realized_nature_access_urban_1h",
  "realized_pollination_norm_nathab",
  "realized_reeftourism_Modelled_Total_Dollar_Value",
  "realized_sedimentdeposition_attn_500km",
  "realized_sedimentdeposition_attn_50km",
  "Vulnerable_C_Total_2018"
)

# New row names (provided in the second image)
new_names <- c(
  "coastal_protection_reef",
  "coastal_protection",
  "coastal_protection_offshore",
  "coastal_protection_onshore",
  "commercial_timber",
  "domestic_timber",
  "flood_mitigation_500km",
  "flood_mitigation_50km",
  "fuelwood",
  "fwfish",
  "grazing",
  "marinefish",
  "moisture_recycling",
  "nitrogen_retention_500km",
  "nitrogen_retention_50km",
  "nature_access_rural_6hr",
  "nature_access_rural_1hr",
  "nature_access_urban_6hr",
  "nature_access_urban_1hr",
  "pollination",
  "reef_tourism",
  "sediment_deposition_500km",
  "sediment_deposition_50km",
  "vulnerable_carbon"
)

# Replace column in the data frame
column_to_update <- "...1"
es_global_sum_df[[column_to_update]] <- new_names[match(es_global_sum_df[[column_to_update]], original_names)]
#rename column
colnames(es_global_sum_df)[colnames(es_global_sum_df) == "...1"] <- "es"
colnames(es_global_sum_df)[colnames(es_global_sum_df) == "sum"] <- "total_global"

#repeat for means
# Replace column in the data frame
column_to_update <- "...1"
es_global_mean_df[[column_to_update]] <- new_names[match(es_global_mean_df[[column_to_update]], original_names)]
#rename column
colnames(es_global_mean_df)[colnames(es_global_mean_df) == "...1"] <- "es"
colnames(es_global_mean_df)[colnames(es_global_mean_df) == "sum"] <- "total_global"

#export updated global ES dataframe
write.csv(es_global_sum_df, paste0("outputs/es_global_sum_30Dec2024.csv"))
write.csv(es_global_mean_df, paste0("outputs/es_global_mean_1Jan2025.csv"))

#left join the KBA total with the global total dataframes
library(dplyr)
es_kba_global_join <- left_join(kba_es_total_df, es_global_sum_df, by = "es")

es_kba_global_join <- es_kba_global_join %>%
  mutate(pct_kba = total_kba/total_global)

#export KBA and global ES totals and percentages
write.csv(es_kba_global_join, paste0("outputs/es_kba_global_join_30Dec2024.csv"))

#repeat for means
#left join the KBA total with the global total dataframes
library(dplyr)
es_kba_global_mean_join <- left_join(kba_es_total_mean_df, es_global_mean_df, by = "es")

es_kba_global_mean_join <- es_kba_global_mean_join %>%
  mutate(pct_kba = global_mean_kba/mean)

#export KBA and global ES totals and percentages
write.csv(es_kba_global_join, paste0("outputs/es_kba_global_join_30Dec2024.csv"))
write.csv(es_kba_global_mean_join, paste0("outputs/es_kba_global_mean_join_1Jan2025.csv"))



# Calculate global area of KBAs with help from chatGPT------------------------
library(sf)

#load data in format sf can read it
kbas <- st_read("data/KBAsGlobal_2023_September_02_POL.shp")

# Transform to a globally applicable equal-area projection (EPSG: 6933 - World Mollweide Equal Area)
kbas <- st_transform(kbas, crs = 6933)

# Calculate the area in square meters
kbas$area_sqm <- st_area(kbas)

# convert to square kilometers
kbas$area_sqkm <- kbas$area_sqm / 1e6

# sum of the "area_sqkm" column **NOTE this includes marine KBAs
kba_total_area_sqkm <- sum(kbas$area_sqkm, na.rm = TRUE)
kba_total_area_sqkm  #39,181,668 sq km **NOTE KBA database says 22,229,814 sq km
#global land area (according to google) 149 million sq km
#minus Antarctica 135 million sq km

