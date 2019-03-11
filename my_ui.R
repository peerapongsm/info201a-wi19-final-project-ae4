my_ui = fluidPage(
  titlePanel("Data of occupations by gender and ethnicity", windowTitle = "Gender and Race"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "value", label = h2("Top 10 occupations with"),
        choices = c("Most Employee", "Least Employee")
      )
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Total", h3("Plot of number of total employees"), plotOutput("total")),
        tabPanel("Gender", h3("Plot of number of employees comparison between gender"), plotOutput("gender"))
      )
    )
  )
)