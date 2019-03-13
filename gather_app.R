library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("geojsonio")
library("stringr")
library("DT")
source("gather_ui.R")
source("gather_server.R")

## Create a shiny app
shinyApp(ui = gather_ui, server = gather_server)

