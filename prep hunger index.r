##
## Prepare England hunger risk index data for mapping
##
library(tidyverse)
library(readxl)
library(rgdal)
library(rmapshaper)
library(spdplyr)

data.dir = "data"


#############################################################################################
## Load boundaries
##
# Middle Layer Super Output Areas (using super generalised clipped because they're the smallest file size)
# source: http://geoportal.statistics.gov.uk/datasets/middle-layer-super-output-areas-december-2011-super-generalised-clipped-boundaries-in-england-and-wales
# I manually removed all Wales MSOAs using QGIS to generate the shapefile used here
msoa_bounds = readOGR(dsn = data.dir,
                      layer = "MSOA_England",
                      verbose = F)

# transform to WGS84 - web Mercator
msoa_bounds = spTransform(msoa_bounds, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

# simplify the boundaries
msoa_bounds = ms_simplify(msoa_bounds)

# get rid of columns we don't need
msoa_bounds = msoa_bounds %>% select(msoa11cd, msoa11nm)


#############################################################################################
## Load hunger index
##
hunger = read_excel(file.path(data.dir, "Oct2018_MSOA_model_BritishRedCross.xlsx"))  # note that this file isn't shipped with the GitHub repository

# merge the hunger risk rate quintiles into the map data
msoa_bounds@data = msoa_bounds@data %>% 
  left_join(hunger %>% select(MSOAcode, RiskRateQ), by = c("msoa11cd" = "MSOAcode"))
