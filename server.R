
# This application prints the traffic stops from Montgomery County Maryland USA
# and can optionally highlight the stops that were alcohol related. 
# The data is sourced from  the Montgomery County Open Data Website 12/5/2014
# https://data.montgomerycountymd.gov/Public-Safety/Traffic-Violations/4mse-ku6q
#
# This is the server logic for the application

library(shiny)
library(shinyIncubator)
library(MASS)
library(RgoogleMaps)
library(RColorBrewer)
library(stringr)
library(devtools)
library(lubridate)
#library(shinyapps)

shinyServer(function(input, output, session) {
  
  output$time <- renderText({
    # Take slider input and set variables
    startTime <<- input$timeRange[1]
    endTime <<- input$timeRange[2]
    # Do not print to screen
    a <- NULL
  })
  
  output$drawMe <- renderText({
    if(input$drawMe > 0) {
      progress <- Progress$new(session)
      Sys.sleep(1)
      progress$set(message = 'Drawing Map...')
      Sys.sleep(1)
      
      if(is.null(nrow(df))) {
        progress$set(detail = 'Please Wait. Loading Data...') 
        df <- read.csv(file = 'Traffic_Violations_Truncated.csv',  
                       colClasses = c("character", "character", "numeric", "numeric", "factor"))
      }
      
      # Remove NA
      progress$set(detail = 'Crunching Numbers...') 
      dataset <<- na.omit(df)
      
      # Grab the coordinates and add to a new data frame
      rawdata <- data.frame(as.numeric(dataset$Longitude), as.numeric(dataset$Latitude))
      names(rawdata) <- c("lon", "lat")
      
      # Create a matrix from the long/lat
      data <- as.matrix(rawdata)
      
      # Find the center of the map using the mean of the coordinates 
      # Grab maps using RgoogleMaps
      center <- rev(sapply(rawdata, mean))
      map <- GetMap(center=center, zoom=11)
      
      # Translate original data
      coords <- LatLon2XY.centered(map, rawdata$lat, rawdata$lon, 11)
      modCoords <- data.frame(coords)
      
      # Numeric Stop Time
      numericStopTime <- hour(hms(dataset$Time.Of.Stop))
      
      # Bind the coordinate data with the application modifiers
      # Alcohol Stops
      # Times
      modCoords <- cbind (modCoords, dataset$Alcohol, numericStopTime)
      names(modCoords) <- c("lat", "lon", "Alcohol", "StopTime")
      # Adjust for time
      modCoords <- modCoords[modCoords$StopTime >= startTime,]
      modCoords <- modCoords[modCoords$StopTime <= endTime,]
      alcoholCoords <- modCoords[modCoords$Alcohol == 'Yes',]
      
      # Lay down the background google map
      output$mainPlot <- renderPlot({
        
        PlotOnStaticMap(map)
        
        # Plot all points
        points(modCoords$lat, modCoords$lon, pch=16, cex=.5, col="black")
            
        if (input$alcoholInclude) {
          # Turn on Alcohol Differentiater
          points(alcoholCoords$lat, alcoholCoords$lon, pch=16, cex=.65, col="red")
        } else {
          # Turn off Alcohol Differentiater
          points(alcoholCoords$lat, alcoholCoords$lon, pch=16, cex=.65, col="black")
        }
      
      }, height = 600, width = 800 )
      
      progress$set(detail = '') 
      progress$close()
      
    } else {
      return()
    }
  })
}
)

