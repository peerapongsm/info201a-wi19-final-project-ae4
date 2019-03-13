source('peeras_jeng_ui.R')
source('peeras_jeng_analysis_ui.R')
source('sarah_ui.R')
source('kelly_ui.R')

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
        Since the wage varies from each states, we chose states with the highest and lowest GDP and compare them with national wages. 
        Nowadays, there is an obvious gender imbalance in certain industries. Race diversities is also a topic that got brought up often by companies.
        So we deceide to analyse occupational wage data from gender and race perspectives and also analyse the regular occupational dataset. In doing so,
        we hope to address some of the issues that is occuring in work place nowadays."),
      br(),
      h1("Page Description"),
      br(),
      p("Wage tab provide a distribution of state GDP in a map format. 
        It also shows the difference between states and national occupational wage statistic using states with the highest and lowest GDP."),
      br(),
      p("Gender shows occupations that have the greatest gender imbalance and occupations that are dominated by one particular gender.
        It also shows the diversity in occupation distributions among races.")
      
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
      br(),
      br(),
      p("These analysis showed the areas of focus that society needs to be aware of and address. 
        As shown on gender page, there are still jobs with major gap in the number of female and male workers. 
        The stereotype that women are not suited for labor-intensive jobs needs to be broken and treatment towards women in the more 
        male-dominated occupations must to be improved. This will help better balance the number of workers in the natural resources
        and construction field. Graph shows that even when there are jobs that have more female workers, the gap is not as 
        significant as to when the occupation has more male workers. There are also obvious similarities between the jobs that have more 
        of one gender employees. Therefore, society should continue to encourage women not only to enter the workforce, but to enter fields 
        that are more heavily male-dominated. The pie chart shows the need to increase the level of race diversity in all occupations. More 
        diversity in the workplace brings in a variety of perspectives and experiences which can greatly enhance a project or task."),
      br(),
      br(),
      p("We used a lot of great data sets in working on this project:"),
      uiOutput("data1"),
      uiOutput("data2"),
      uiOutput("data3"),
      uiOutput("data4")
    )
  )
)