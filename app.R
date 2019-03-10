library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("geojsonio")
library("stringr")
library("DT")
source("data.R")
source("my_ui.R")
source("my_server.R")

## Create a shiny app
shinyApp(ui = my_ui, server = my_server)
