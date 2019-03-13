source('peeras_jeng_ui.R')
source('peeras_jeng_analysis_ui.R')
source('sarah_ui.R')
#source('kelly_ui.R')

gather_ui = navbarPage (
  "US Occupational Statistics",
  tabPanel(
    "Home",
    headerPanel(
      h1("US Occupational Statistics", align = "center")
    ),
    mainPanel(
      # text descripting the project
      p("Our project studies the distribution of wages among occupations. 
        Since the wage varies from each states, we chose states with the highest and lowest GDP and compare them with nation wages."),
      br(),
      h1("Page Description"),
      br(),
      p("Wage tab provide a distribution of state GDP in a map format. It also shows the difference between states and national occupational wage statistic using "),
      br(),
      p("Gender shows the difference between male and female’s salary within the same occupation field.")
      
      )
  ),
  
  # Wage tab
  tabPanel(
    "Wage",
    tabsetPanel(type = 'pills',
                wage_analysis
                #wage_sandbox
                )
    ),
  
  # Gender tab
  tabPanel(
    "Gender",
    tabsetPanel(type = 'pills',
                gender_race_analysis,
                gender_race_sandbox
                )
  ),
  # About tab
  tabPanel(
    "About",
    headerPanel(
      h1("About this project", align = "center")
    ),
    mainPanel(
      h1("AE-4 Team members"),
      p("Jacinda Eng, Kelly Tran Ho, Yizhen(Sarah) Jin, Peerapong Saksommon"),
      p("Women in workplace has always been a hot topic"),
      br(),
      p("We used a lot of great data sets in working on this project:"),
      uiOutput("data1"),
      uiOutput("data2"),
      uiOutput("data3")
      
    )
  )
)