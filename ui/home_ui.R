home <- tabPanel(
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
    p("Wage tab provide a distribution of state GDP in a map format. It also shows the difference between states and national occupational wage statistic using
      Gender shows the difference between male and female’s salary within the same occupation field.")
  )
)
