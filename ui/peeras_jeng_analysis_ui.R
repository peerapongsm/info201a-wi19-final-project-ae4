gender_race_analysis = tabPanel(
  "Analyzing Tables and Graphs",
  tags$section(id =  "gender_first_section", # first section is titled "observations"
               h2(textOutput("gender_header")), # "observations" header
               textOutput("gender_first_section_content") # displays the content for the observations header 
               ),
  tags$section(id = "gender_question_1_second_section", # first analysis question section
              h2(textOutput("gender_questions")), # "questions" header
              strong((textOutput("gender_question_1"))), # prints out the first question
              br(), # line break
              plotOutput("gender_employee", width = "100%", height = "550px"), # displays the bar chart comparing gender difference in the top 10 occupations with most number of employees
              textOutput("gender_question_1_content") # prints out analysis for first question
              ),
  br(), # line break
  tags$section(id = "gender_question_2_second_section", # second analysis question section
               strong((textOutput("gender_question_2"))), # prints out the second question
               br(), # line break
               (textOutput("male_difference_table_title")), # prints out title for table that shows top 10 occupations where there are more males than females 
               tableOutput("male_difference_table"), # prints out the table that shows top 10 occupations where there are more males than females 
               br(), # line break
               (textOutput("female_difference_table_title")), # prints out title for table that shows top 10 occupations where there are more females than males 
               tableOutput("female_difference_table"), # prints out the table that shows top 10 occupations where there are more females than males 
               textOutput("gender_question_2_content") # prints out the analysis for the second question 
               ),
  br(),
  tags$section(id = "gender_question_3_second_section", # third analysis question section
               strong((textOutput("gender_question_3"))), # prints out the third question
               br(), # line break
               textOutput("gender_pie_title"), # prints out the table 
               plotOutput("ethnicity_pie"), # displays pie chart showing the average ethnicity distribution
               textOutput("gender_question_3_content") # prints out the analysis for the third question
               ),
  tags$section(id = "gender_fourth_section", # conclusion section
               h2(textOutput("gender_conclusion")), # prints out the "conclusion" header
               textOutput("gender_conclusion_content") # prints out the conclusion content 
  )
)

