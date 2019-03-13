home <- tabPanel(
  "Home",
  headerPanel(
    h1("US Occupational Statistics", align = "center")
  ),
  mainPanel(
    # text describing the project
    p("Our project studies the distribution of wages among occupations. 
      Since the wage varies from each states, we chose states with the highest and lowest GDP and compare them with nation wages. 
      In this case for 2017 the state with the highest GDP is Washington, and the state with the lowest GDP is Connecticut.
      Comparing these states will help us develop a deeper understanding regarding each states' focus within their respective economy.
      For example, if there is a higher wage towards technology related fields in Washington compared to Connecticut, then there is a trend
      that Washington has a stronger focus towards technology related careers.
      "),
    br(),
    h1("Page Description"),
    br(),
    p("The 'Wage' tab provides a description of the states' GDP in a map format. 
      It also describes how GDP affect's each states occupation's wage and total number of employees relating to that."),
    br(),
    p("The 'Gender' tab describes the distribution of occupations across men and women and across races as well.
      This helps us understand if there is a lack of a diversity within an occupation field. 
      Looking at this data can help us understand how gender, occupations, wage ties together in a subtle way. 
      In other words, if we see that there are more men that have an occupation with a higher wage, then we can see that
      there is a wage gap between men and women which ties to the idea of a lack of diversity within fields.")
  )
)
