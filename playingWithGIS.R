# playing with GIS files

library(tidyverse)
library(ggplot2)
library(lubridate)
library(sf)
#source("Cm_SealBeach_fcns.R")

# specify a folder that contains GIS files
# each GIS object comes with muliple files but shares one name
# If one folder contains multiple objects, specify it in the 
# layer argument:
# Just the pond
pond_7th <- st_read("GIS files/Eelgrass", layer = "7th_Street_Pond")

# Eelgrass
eelgrass_pond_7th <- st_read("GIS files/Eelgrass", layer = "7th_St_Pond_Eelgrass")
eelgrass2_pond_7th <- st_read("GIS files/Eelgrass", layer = "7th_St_Pond_Eelgrass2")

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

bathy <- st_read("GIS files/SealBeach_Precon_eelgrass_GIS_Data_October2019", 
                 layer = "1600331-V-SP-BATHY")

bathy %>% st_transform(crs = "+proj=longlat +datum=WGS84")  -> bathy_latlon
p.2 <- ggplot() +
  geom_sf(data = bathy)

p.2

project.areas <- st_read("GIS files/SealBeach_Precon_eelgrass_GIS_Data_October2019", 
                 layer = "project_areas_oct2019")

project.areas %>% st_transform(crs = "+proj=longlat +datum=WGS84")  -> project_areas_Oct2019_latlon
p.3 <- ggplot() +
  geom_sf(data = project_areas_Oct2019_latlon)

p.3

# coast.line <- getCoastLine('data/coast_Epac.txt',
#                            lon.limits = c(-118.5, -118),
#                            lat.limits = c(33.5, 33.75))
# 
# coast.line.df <- do.call(rbind, coast.line)

# convert the lat/lon into northing/easting
# the study area covers zones 10 and 11. An arbitrary center point
# was created here.

# study.area <- st_as_sf(data.frame(Lat = c(33, 34, 34, 33, 33),
#                                   Lon = c(-119, -119, -118, -118, -119)),
#                        coords = c("Lon", "Lat"),
#                        crs = "+proj=longlat +datum=WGS84")

# p4 <- ggplot() +
#   geom_polygon(fill = "darkgray",
#                data = coast.line.df,
#                aes(x = Longitude,
#                    y = Latitude, group = idx)) +
#   coord_map()
# 
# p4
