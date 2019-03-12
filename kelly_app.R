library(shiny)

source("kelly_ui.R")
source("kelly_server.R")

shinyApp(ui = kelly_ui, server = kelly_server)
