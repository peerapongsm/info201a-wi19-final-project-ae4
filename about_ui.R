about <- tabPanel(
  "About",
  headerPanel(
    h1("About this project", align = "center")
  ),
  mainPanel(
    h1("AE-4 Team members"),
    p("Jacinda Eng, Kelly Tran Ho, Yizhen(Sarah) Jin, Peerapong Saksommon"),
    p("Women in workplace has always been a hot topic"),
    br(),
    p("We used a lot of great data sets in working on this project:"),
    uiOutput("data1"),
    uiOutput("data2"),
    uiOutput("data3")
  )
)
