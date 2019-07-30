library(tmap)
library(shiny)
library(maps)
library(ggplot2)
library(leaflet)
library(readxl)
#kakashikuun file

# Load data ----
data("World")
source("./Servers.R")
#edu <- read_excel("data_poverty.xls")
#poverty <- read_excel("data_poverty.xls")
# User interface ----
ui <- navbarPage(" ",
                 tabPanel("Poverty rate", h4("The poverty gap, in international-$, 2013 "), helpText("The poverty gap is the amount of money that would be theoretically needed to lift the incomes of all people in extreme poverty up to the international poverty line of $1.90 a day. These estimates are expressed in international dollars using 2011 PPP conversion rates. This means that figures account for differences in prices levels, as well as for inflation. (Source: PovcalNET, 2017)"),
                          sliderInput("obs", "Number of observations:",
                                      min = 1981, max = 2013, value = 1981, animate = TRUE, step= 3),
                          mainPanel(leafletOutput("map"))
                 ),
                 tabPanel("Education rate", tabPanel("Component 1",  h4("The percentage of out-of-school children of primary school age - %, 2018"),helpText("The primary source for estimates include primary and lower and upper secondary children out of school for more than 200 countries and territories. (Source: UNESCO Institute for Statistics)"),
                                                     sliderInput("obj", "Number of observations:",
                                                                 min = 1971, max = 2017, value = 1971, animate = TRUE),
                                                     mainPanel(leafletOutput("mop"))
                 )
                 ),
                 navbarMenu("More",
                            tabPanel("Histogram", img(src='img_1.png', height=700, width=700), helpText("These figures are the result of important changes across time. As we mentioned above in our discussion of regional trends, in 1990 Asia was the world region with the largest number of poor people (505 million in South Asia, plus 966 million in East Asia and the Pacific). However, with rapid economic growth in Asia over the past two decades, poverty in Asia fell more rapidly than in Africa.")),
                            tabPanel("Charts", img(src='img_2.png', height=700, width=700), helpText("Figure above shows the percent of people living below different levels of consumption or income in low and middle income countries, by age group (2013) – UNICEF (2016")))
)


"1990" 
1990
# Server logic ----
server <- function(input, output) {
  #edu<-read_excel("./data/data_education.xls")
  #poverty<-read_excel("./data/data_poverty.xls")
  
  output$map = renderLeaflet({
    tm <- tm_shape(merge_poverty) + tm_polygons(palette = "YlOrRd", toString(input$obs))
    tmap_leaflet(tm)
  })
  
  output$mop = renderLeaflet({
    tm <- tm_shape(merge_all) + tm_polygons(palette = "Accent", toString(input$obj)) 
    tmap_leaflet(tm)
  })
}


# Run app ----
shinyApp(ui, server)