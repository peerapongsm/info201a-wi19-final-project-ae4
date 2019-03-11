library(shiny)
library(plotly)
library(dplyr)
library(graphics)

sarah_ui <- navbarPage(
  "US Occupational Statistics",
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
    h1("US Occupational Statistics"),
    p("Our project studies the distribution of wages among occupations 50 states "),
    br(),
    h2("Page Description"),
    br(),
    P("Wage tab shows the difference between states and national occupational wage statistic using "),
    br(),
    p("Gender shows the difference between male and female’s salary within the same occupation field."),

  )
  
),

# Wage tab
tabPanel(
  "Wage",
  tabsetPanel(type = 'pills',
              tabPanel('Analysis',
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
)

sarah_server <- 
shinyApp(ui = my_ui, server = sarah_server)