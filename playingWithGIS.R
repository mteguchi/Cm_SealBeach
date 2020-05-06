# playing with GIS files

library(tidyverse)
library(ggplot2)
library(lubridate)
library(sf)
#source("turtle_sightings_sf_fcns.R")

# specify a folder that contains GIS files
# each GIS object comes with muliple files but shares one name
# If one folder contains multiple objects, specify it in the 
# layer argument:
# Just the pond
pond_7th <- st_read("data/Eelgrass", layer = "7th_Street_Pond")

# Eelgrass
eelgrass_pond_7th <- st_read("data/Eelgrass", layer = "7th_St_Pond_Eelgrass")
eelgrass2_pond_7th <- st_read("data/Eelgrass", layer = "7th_St_Pond_Eelgrass2")

#Convert these into lat/lon
pond_7th %>% st_transform(crs = "+proj=longlat +datum=WGS84")  -> pond_7th_latlon
eelgrass_pond_7th %>% st_transform(crs = "+proj=longlat +datum=WGS84")  -> eelgrass_pond_7th_latlon
eelgrass2_pond_7th %>% st_transform(crs = "+proj=longlat +datum=WGS84")  -> eelgrass2_pond_7th_latlon

water.color <- "darkblue"
p.1 <- ggplot() +
  geom_sf(data = pond_7th_latlon,
               fill = water.color)  +
  geom_sf(data = eelgrass_pond_7th_latlon,
          color = "white",
          fill = "green") +
  geom_sf(data = eelgrass2_pond_7th_latlon,
          color = "white",
          fill = "green")
p.1


