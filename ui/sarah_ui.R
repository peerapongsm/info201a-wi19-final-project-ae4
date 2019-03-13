wage_analysis <- tabPanel(
  "Analysis",
  tags$section(id = "wage_map_part",
               h3("State GDP in the US"),
               strong(p("What is GDP?")),
               textOutput("wage_GDP"),
               leafletOutput("gdpMap"),
               textOutput("wage_map_analysis")
               ),
  br(),
  br(),
  tags$section(id = "wage_first_part",
               h3("Occupations with the highest hourly wage differences"),
               strong(p("What occupations in Washington have the highest difference of wage comapared to the national data?")),
               plotOutput("waDiff"),
               textOutput("wage_analysis_1")),
  br(),
  br(),
  tags$section(id = "wage_second_part",
               strong(p("What occupations in Connecticut have the highest difference of wage compared to the national data?")),
               plotOutput("ctDiff"),
               textOutput("wage_analysis_2")
               ),
 
  br(),
  br(),
  tags$section(id = "wage_third_part",
               h3("Employment number in WA and CT"),
               textOutput("wage_analysis_3")
               ),
  tags$section(id = "wage_third_part",
               strong(p("What job has the highest number of employees in Washington?")),
               plotOutput("employmentWA"),
               p("Washington state have the highest employment number in cashiers, combined food prep worker, 
                  laborers and freight, office clerks, and retail salespersons.")),
  br(),
  br(),
  tags$section(id = "wage_four_part",
               strong(p("What job has the highest number of employees in Connecticut?")),
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
