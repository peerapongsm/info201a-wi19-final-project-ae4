library(shiny)
library(plotly)
library(dplyr)
library(graphics)

shinyUI(navbarPage(
  theme = "custom.css",
  "US Occupational Statistics",
  id = "navbar",
  tabPanel(
    "Home",
    headerPanel(
      h1("Home", align = "center")
  ),
  br(),
  br(),
  br(),
  br(),
  mainPanel(
    # text descripting the project
    p("Our project studies the distribution of wages among occupations 50 states "),
    br(),
    h2("Page Description"),
    br(),
    P("Wage tab shows the difference between states and national occupational wage statistic using "),
    br(),
    p("Gender shows the difference between male and female’s salary within the same occupation field."),
    width = 12
  )
  
),
# Wage tab
tabPanel(
  "Wage",
  headerPanel(
    h1("Wage", align = "center")
  ),
  br()
),
# Gender tab
tabPanel(
  "Gender",
  headerPanel(
    h1("Gender", align = "center")
  ),
  br()
),
# About tab
tabPanel(
  "About",
  headerPanel(
    h1("About", align = "center")
  ),
  br()
)
))