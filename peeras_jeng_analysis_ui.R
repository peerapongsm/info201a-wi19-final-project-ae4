gender_race_analysis = fluidPage(
  titlePanel(h1("Analyzing Tables and Graphs")),
  tags$section(id =  "first_section", 
               h2(textOutput("header")),
               textOutput("first_section_content")
               ),
  tags$section(id = "question_1_second_section",
              h2(textOutput("questions")),
              strong((textOutput("question_1"))),
              br(),
              plotOutput("gender_employee", width = "100%", height = "550px"),
              textOutput("question_1_content")
              ),
  br(),
  tags$section(id = "question_2_second_section",
               strong((textOutput("question_2"))),
               br(),
               (textOutput("male_difference_table_title")),
               tableOutput("male_difference_table"),
               br(),
               (textOutput("female_difference_table_title")),
               tableOutput("female_difference_table"),
               textOutput("question_2_content")
               ),
  br(),
  tags$section(id = "question_3_second_section",
               strong((textOutput("question_3"))),
               br(),
               textOutput("pie_title"),
               plotOutput("management_pie"),
               textOutput("question_3_content")
               ),
  tags$section(id = "third_section",
               h2(textOutput("conclusion")),
               textOutput("conclusion_content")
  ),
 tags$section(id = "reference",
              h2(textOutput("reference")),
              textOutput("links"))
)

