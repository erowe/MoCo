
# This US displays the traffic stops from Montgomery County Maryland USA
# and can optionally highlight the stops that were alcohol related. 
# The data is sourced from  the Montgomery County Open Data Website 12/5/2014
# https://data.montgomerycountymd.gov/Public-Safety/Traffic-Violations/4mse-ku6q
#
# The dataset was very large ~ 200MB and only five columns were downloaded
# Date Of Stop  Time Of Stop	Latitude	Longitude	Alcohol
#
# This is the user-interface definition
#

library(shiny)
library(shinyIncubator)

shinyUI(fluidPage(

  # Application title
  titlePanel("Montgomery County Maryland Traffic Stops"),
  h4("Period: 01/01/2012 - 12/6/2014"),
  hr(),
  h4("Description"),
  p("This application displays traffic stops in the Montgomery County Maryland area over the last two years. The user has the ability to truncate the dataset to display where traffic stops occurred during fixed hours of the day and if they were alcohol related."),
  hr(),
  h4("Using This Application"),
  tags$ul(
    tags$li('To adjust the hours of the day that stops occurred, move the slider to the appropriate start and end times. To view all hours of the day, set the values to 0 and 24.'),
    tags$li('To view stops related to alcohol, click', tags$i('Highlight Alcohol Related Stops')),
    tags$li('The', tags$i('Draw Map'), 'button will create the map.')
  ),
  p(
    tags$b('NOTE:'), 
    'Any update to the slider values will not update the map automatically. It is unfavorable to have the map automatically redraw if you need to adjust both numbers on the slider. To update the map, click the ', 
    tags$i('Draw Map'),
    'button.'
  ),
  p(
    tags$b('NOTE:'), 
    'The ',
    tags$i('Highlight Alcohol Related Stops '),
    'checkbox automatically refreshes the map when it is used.'
  ),
  hr(),
  # Setup application interface in side bar
  sidebarLayout(
    sidebarPanel(
      sliderInput("timeRange", "Select Hours of the Day to truncate map data (Requires Re-Draw)",
        min = 0, max = 24, value = c(0, 24)),
      hr(),
      checkboxInput("alcoholInclude", label = "Highlight Alcohol Related Stops (Auto Refreshes) Shown in Red", value = TRUE),
      hr(),
      progressInit(),
      actionButton("drawMe", "Draw Map"), 
      hr()
  ),
      
    # This is the output panel on the right side application interface
    mainPanel(
      textOutput("time"),
      textOutput("drawMe"),
      plotOutput (outputId = "mainPlot", width = "100%")
    )
  )
))