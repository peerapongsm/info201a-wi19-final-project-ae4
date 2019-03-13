source("ui/home_ui.R")
source("ui/about_ui.R")
source("ui/peeras_jeng_ui.R")
source("ui/peeras_jeng_analysis_ui.R")
source("ui/sarah_ui.R")
source("ui/kelly_ui.R")

gather_ui <- navbarPage(
  theme = "bootstrap.css",
  "US Occupational Statistics",
  home,

  # Wage tab
  tabPanel(
    "Wage",
    tabsetPanel(
      type = "pills",
      wage_analysis,
      wage_sandbox
    )
  ),

  # Gender tab
  tabPanel(
    "Gender",
    tabsetPanel(
      type = "pills",
      gender_race_analysis,
      gender_race_sandbox
    )
  ),
  # About tab
  about
)
