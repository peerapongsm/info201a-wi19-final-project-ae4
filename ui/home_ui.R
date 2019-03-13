home <- tabPanel(
  "Home",
  tags$section(
    h1("US Occupational Statistics"),
    p("Our project studies the distribution of wages among occupations. 
                  Since the wage varies from each states, we chose states with the highest and lowest GDP and compare them with nation wages. In this case for 2017, the state with the highest GDP is Washington, and the state with the lowest GDP is Connecticut. Comparing these states will help us develop a deeper understanding regarding each states' focus within their respective economy. For example, if there is a higher wage towards technology related fields in Washington compared to Connecticut, 
                  then there is a trend that Washington has a stronger focus towards technology related careers."),
    br(),
    h1("Page Description"),
    p("The 'Wage' tab provides a description of the states' GDP in a map format. It also describes how GDP affect's each states occupation's wage and total number of employees relating to that.
      The 'Gender' tab describes the distribution of occupations across men and women and across races as well.
      Looking at this data can help us understand how gender, occupations, wage ties together in a subtle way. In other words, if we see that there are more men have an occupation with a higher wage, then 
      due to the lack of diversity within that occupation, there is a large wage gap between men and women.
      The 'About' tab contains references of the datasets.")
  )
)
