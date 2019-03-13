library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("geojsonio")
library("stringr")
library("DT")
library("readxl")
source("ui/gather_ui.R")
source("server/gather_server.R")

## Create a shiny app
shinyApp(ui = gather_ui, server = gather_server)
