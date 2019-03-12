peeras_jeng_ui = fluidPage(
  titlePanel("Data of Occupations by Gender and Ethnicity", windowTitle = "Gender and Race"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "select", label = h2("Select data"),
        choices = c("Employment data" = "emp", 
                    "Gender data" = "gdr",
                    "Gender different data" = "gdiff")
      ),
      radioButtons(
        inputId = "radio", label = h2("Select filter"),
        choices = c("Most" = "most", "Least" = "least")
      )
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
          tabPanel("Bar plot", h3(textOutput("bar_header")), plotOutput("bar")),
          tabPanel("Table", h3(textOutput("table_header")), dataTableOutput("table"), textOutput("note")),
          tabPanel("Pie chart", h3(textOutput("pie_header")), plotOutput("pie"))
      )
    )
  )
)

