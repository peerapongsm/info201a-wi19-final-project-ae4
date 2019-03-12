library("shiny")
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("geojsonio")
library("stringr")
library("DT")
source("peeras_jeng_ui.R")
source("peeras_jeng_server.R")

## Create a shiny app
shinyApp(ui = peeras_jeng_ui, server = peeras_jeng_server)

