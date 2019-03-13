kelly_ui <- fluidPage(
  titlePanel("Sandbox"),
  tabsetPanel(type = 'tabs',
              tabPanel(
                "Map", 
                hr("Highlight over a state to reveal more stats"),
                sidebarLayout(
                  sidebarPanel(
                    radioButtons(inputId = "map_value", label = "Map by:", selected = "gdp",
                                 choices = c("GDP" = "gdp", "Hourly wage" = "wage", "Total employees" = "total"))
                  ),
                mainPanel(  
                  leafletOutput("map")))
              
                ), 
                tabPanel("Occupations Plot",
                  titlePanel("Occupations Explorer"),
                  sidebarLayout(
                    sidebarPanel(
                      radioButtons(inputId = "plot_select", label = "Choose",
                                   c("Top 5" = "top", "Lowest 5" = "bot")),
                      radioButtons(inputId = "plot_occ", label = "Select Occupation",
                                   c("Occupation Field" = "major","Occupation" = "detailed")),
                      selectInput(inputId = "plot_value", label = "Choose topic:",
                                  choices = c("Total Employees" = "TOT_EMP", "Average Hourly Wage" = "H_MEAN", "Average Annual Salary" = "A_MEAN")),
                      selectInput(inputId = "plot_state", label = "Enter a State",
                                  c(states$region))
    
                    ),
                    mainPanel(
                      plotOutput("plot", width = "100%", height = "700px")
                    )
                  
                  )),
              tabPanel("Occupations Table",
                       titlePanel("Occupations Data Table"),
                       sidebarLayout(
                         sidebarPanel(
                           radioButtons(inputId = "table_select", label = "Choose",
                                        c("Top 10" = "top", "Lowest 10" = "bot")),
                           radioButtons(inputId = "table_occ", label = "Select Occupation",
                                        c("Occupation Field" = "major","Occupation" = "detailed")),
                           selectInput(inputId = "table_value", label = "Choose topic:",
                                       choices = c("Total Employees" = "TOT_EMP", "Average Hourly Wage" = "H_MEAN", "Average Annual Salary" = "A_MEAN")),
                           selectInput(inputId = "table_state", label = "Enter a State",
                                       c(states$region))

                         ),
                         mainPanel(
                           dataTableOutput("table")
                         )

                       ))
              
  )
  
)