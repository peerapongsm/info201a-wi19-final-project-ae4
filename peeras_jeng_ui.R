peeras_jeng_ui = fluidPage(
  titlePanel("Data of occupations by gender and ethnicity", windowTitle = "Gender and Race"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "employee", label = h2("Top 10 occupations with"),
        choices = c("Most Employee" = "most", "Least Employee" = "least")
      ),
      radioButtons(
        inputId = "diff_gender", label = h2("Top 10 occupations with"),
        choices = c("Greatest different in employment between gender" = "most", 
                    "Lowest different in employment between gender" = "least")
      )
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Total Employee", h3("Plot of number of total employees"), plotOutput("total_employee")),
        tabPanel("Gender Employee", h3("Plot of number of employees comparison between gender"), plotOutput("gender_employee")),
        tabPanel("Employee Table", h3("Data table for employees data"), dataTableOutput("table_employee")),
        tabPanel("Gender Different", h3("Plot of different in employment between gender"), plotOutput("gender_diff")),
        tabPanel("Gender Different Table", h3("Data table for gender different data"), dataTableOutput("table_gender_diff"))
      )
    )
  )
)

