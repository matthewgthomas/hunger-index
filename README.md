# Interactive risk map of food insecurity in England
Code to produce an interactive map showing the population-level risk of household food insecurity in English neighbourhoods.

The risk index was created by [Smith et al. (2018) Identifying populations and areas at greatest risk of household food insecurity in England](https://www.sciencedirect.com/science/article/abs/pii/S0143622817301340). Note that the data isn't included with this repository. Please contact the corresponding author of the paper for the data.

## Generating the map

1. Install [RStudio](https://www.rstudio.com/)
2. Install packages: `install.packages("tidyverse", "readxl", "rgdal", "rmapshaper", "spdplyr", "leaflet", "leaflet.extras")`
3. Open `hunger.Rmd` and [knit the file](https://rmarkdown.rstudio.com/authoring_quick_tour.html)
