wage_analysis <- tabPanel(
  "Analysis",
  tags$section(id = "wage_map_part",
               h2("State GDP in the US"),
               h3("What is GDP?"),
               p(textOutput("wage_GDP"),
               textOutput("wage_map_analysis")),
               leafletOutput("gdpMap")
               ),
  br(),
  tags$section(id = "wage_first_part",
               h2("Occupations with the highest hourly wage differences"),
               h3("What occupations in Washington have the highest difference of wage comapared to the national data?"),
               plotOutput("waDiff"),
               p(textOutput("wage_analysis_1"))),
  br(),
  tags$section(id = "wage_second_part",
               h3("What occupations in Connecticut have the highest difference of wage compared to the national data?"),
               plotOutput("ctDiff"),
               p(textOutput("wage_analysis_2"))
               ),
 
  br(),
  tags$section(id = "wage_third_part",
               h2("Employment number in WA and CT"),
               p(textOutput("wage_analysis_3"))
               ),
  tags$section(id = "wage_third_part",
               h3("What job has the highest number of employees in Washington?"),
               plotOutput("employmentWA"),
               p("Washington state have the highest employment number in cashiers, combined food prep worker, 
                  laborers and freight, office clerks, and retail salespersons.")),
  br(),
  tags$section(id = "wage_four_part",
               h3("What job has the highest number of employees in Connecticut?"),
               plotOutput("employmentCT"),
               p("In comparison, Connecticut has the highest employment number in cashier, customer service representatives, general manager,
                registered nurses, and retail salespersons.")
               ),

  br(),
  tags$section(id = "wage_conclusion",
               h3("Conclusion"),
               p("Overall, we can see that internists have higher hourly wages from both Washington and Connecticut. 
                  Cashiers have the top five demand for employment in both of the states. 
                 There is a similarity in high demand jobs in both states: They often times are jobs that
                 requires less certificate and is easier to pick up. We were looking for the correlation between GDP and jobs that they are favoring.
                 However, there is not an obvious trend in jobs that they are looking at.")
               )
  )
