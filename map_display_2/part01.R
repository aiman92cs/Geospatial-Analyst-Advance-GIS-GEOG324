library(tmap)
library(shiny)
library(maps)
library(ggplot2)
library(leaflet)

#rsconnect::deployApp('C:/Local/mah198/GEOG324')

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
                  choices = c("economy", "inequality", "HPI"),
                  selected = "economy"),
      
      sliderInput("obs", "Number of observations:",
                  min = 1970, max = 2018, value = 1970
      )
    ),
    
    mainPanel(leafletOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  
  connect=reactive({
      n <- input$obs
      var.n<-paste(n,sep="")
      return(var.n)
    }
    )
  
  
  output$map = renderLeaflet({
    #tm <- tm_shape(World) + tm_polygons(input$var, legend.title = input$var)
    tm <- tm_shape(merge_all) + tm_polygons(toString(input$obs))  #convert INT to String
    tmap_leaflet(tm)
  })
}

# Run app ----
shinyApp(ui, server)