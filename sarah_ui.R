sarah_ui <- navbarPage(
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
              tabPanel('Analysis',
                       h3("State GDP in the US"),
                       p("What is GDP?"),
                       p("Gross domestic product (GDP) is the monetary value of all the finished goods and services produced within a country's borders in a specific time period."),
                       leafletOutput("gdpMap"),
                       p("The map have shown the GDP differences between states. The state with highest GDP is Washington, and the state with the lowest GDP is Connecticut. 
                         Therefore, our project chose these two states and compare it with national employment data."),
                       br(),
                       br(),
                       h3("Occupations with the highest hourly wage differences"),
                       p("What occupations in Washington have the highest difference of wage comapared to the national data?"),
                       plotOutput("waDiff"),
                       p("As you can see, the graph shows five occupations that have the greatest hourly wages difference between Washington and Nation wage in the year of 2017. 
                         Individuals that work as electrical drafters, emergency medical technicians and paramedics, internists,
                            or psychiatrists in state of Washington would receive pays above national level.
                         The mean difference from those five occupations are 16.374 per hour."),
                       br(),
                       br(),
                       p("What occupations in Connecticut have the highest difference of wage comapared to the national data?"),
                       plotOutput("ctDiff"),
                       p("Similar as the graph above, it shows the top five occupations in the state of Connecticut. Individuals that work as dentists, internists, judges, funeral Director, 
                         and real estate broker have hourly wages that exceed national averages with the highest differences. 
                         It have the mean of 16.37 above nation wages from those top five occupations. Internists have the highest difference with 25.41 above national hourly wage."),
                       br(),
                       br(),
                       h3("Employment number in WA and CT"),
                       p("States often times have their focused industries. 
                         When individuals start looking for jobs, it is good for them to keep in mind what the state is focusing on. 
                         There is always questions from new graduate to think if focused industries would have a higher demand in employment."),
                       p("What job has the highest number of employees in Washington?"),
                       plotOutput("employmentWA"),
                       p("Washington state have the highest employment number in cashiers, combined food prep worker, 
                         laborers and freight, office clerks, and retail salespersons."),
                       br(),
                       br(),
                       p("What job has the hight number of employees in Connecticut?"),
                       plotOutput("employmentCT"),
                       p("In comparison, Connecticut has the highest employment number in cashier, customer service representatives, general manager,
                         registered nurses, and retail salespersons.")
                       ),
              tabPanel("Sandbox")
)),

# Gender tab
tabPanel(
  "Gender",
  tabsetPanel(type = 'pills',
              tabPanel('Analysis',
                      h1("")
              ),
              tabPanel("Sandbox")
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
