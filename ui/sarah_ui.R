wage_analysis <- tabPanel(
  "Analysis",
  h3("State GDP in the US"),
  strong(p("What is GDP?")),
  p("Gross domestic product (GDP) is the monetary value of all the finished goods and services produced within a country's borders in a specific time period."),
  leafletOutput("gdpMap"),
  p("The map shows the GDP differences between states. The state with the highest GDP is Washington, and the state with the lowest GDP is Connecticut. 
    Therefore, our project chose these two states and compare it with national employment data."),
  br(),
  br(),
  h3("Occupations with the highest hourly wage differences"),
  strong(p("What occupations in Washington have the highest difference of wage comapared to the national data?")),
  plotOutput("waDiff"),
  p("The graph shows five occupations that have the greatest hourly wages difference between Washington and national wage in the year of 2017. 
    Individuals that work as electrical drafters, emergency medical technicians and paramedics, internists,
    or psychiatrists in state of Washington would receive pays above national level.
    The mean difference from those five occupations are $16.374 per hour."),
  br(),
  br(),
  strong(p("What occupations in Connecticut have the highest difference of wage compared to the national data?")),
  plotOutput("ctDiff"),
  p("Similar to the graph above, it shows the top five occupations in the state of Connecticut. Individuals that work as dentists, internists, judges, funeral Director, 
    and real estate broker have hourly wages that exceed national averages with the highest differences. 
    It have the mean of $16.37 above national wages from those top five occupations. Internists have the highest difference with 25.41 above national hourly wage."),
  br(),
  br(),
  h3("Employment number in WA and CT"),
  p("States often times have their focused industries. 
    When individuals start looking for jobs, it is good for them to keep in mind what the state is focusing on. 
    There are always questions from new graduates to think if focused industries would have a higher demand in employment."),
  strong(p("What job has the highest number of employees in Washington?")),
  plotOutput("employmentWA"),
  p("Washington state have the highest employment number in cashiers, combined food prep worker, 
    laborers and freight, office clerks, and retail salespersons."),
  br(),
  br(),
  strong(p("What job has the highest number of employees in Connecticut?")),
  plotOutput("employmentCT"),
  p("In comparison, Connecticut has the highest employment number in cashier, customer service representatives, general manager,
    registered nurses, and retail salespersons."),
  br(),
  h3("Conclusion"),
  p("Overall, we can see that internists have higher hourly wages from both Washington and Connecticut. 
    Cashiers have the top five demand for employment in both of the states. 
    There is a similarity in high demand jobs in both states: They often times are jobs that
    requires less certificate and is easier to pick up. We were looking for the correlation between GDP and jobs that they are favoring.
    However, there is not an obvious trend in jobs that they are looking at.")
  )
