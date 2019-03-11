peeras_jeng_analysis_ui = fluidPage(
  titlePanel(h1("Analyzing Tables and Graphs")),
  tags$section(id =  "first_section", 
               h2(textOutput("header"),
               textOutput("content")
               )),
)

