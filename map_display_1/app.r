library(tmap)
library(shiny)
library(maps)
library(ggplot2)
library(leaflet)

#asdfghjkl

# Load data ----
data("World")
# User interface ----
ui <- fluidPage(
  titlePanel("Poverty census"),
  
  sidebarLayout(
    sidebarPanel(
      helpText(" Demographic census of 2010 data"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("economy", "inequality", "life_exp"),
                  selected = "economy")
    ),
    
    mainPanel(leafletOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  
  output$map = renderLeaflet({
    tm <- tm_shape(World) + tm_polygons(input$var, legend.title = input$var)
    tmap_leaflet(tm)
  })
}

# Run app ----
shinyApp(ui, server)
