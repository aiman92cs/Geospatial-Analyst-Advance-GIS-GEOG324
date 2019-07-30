library(tmap)
library(shiny)
library(maps)
library(ggplot2)
library(leaflet)
library(rgdal)
library(ggplot2)
library(dplyr)

library(readxl)
data("World")


#handle education database
edu <- read_excel("./data/data_education.xls")
edu_all_year <- select(edu, Country, "1970":"2018")
merge_all <- merge(World,edu_all_year, by.x= "name", by.y= "Country")

#handle poverty database
poverty <- read_excel("./data/data_poverty.xls")
merge_poverty <- merge(World, poverty, by.x="iso_a3", by.y="country")




##display the map
tm <- tm_shape(merge_poverty) + tm_polygons("1990")
tmap_leaflet(tm)


