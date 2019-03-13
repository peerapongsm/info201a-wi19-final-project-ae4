home <- tabPanel(
  "Home",
  tags$section(id = "home_section_page_title",
               h1(textOutput("page_title_home_ui")),
               textOutput("project_description_home_ui"),
               br()
  ),
  tags$section(id = "home_section_description",          
              h1(textOutput("page_description_home_ui")),
               textOutput("wage_description_home_ui"),
               textOutput("gender_description_home_ui"),
               textOutput("about_home_ui")
  )
)