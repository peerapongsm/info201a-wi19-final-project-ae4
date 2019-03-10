
library('geojson')
library("geojsonio")
library("leaflet")
library("readxl")
library("dplyr")

states <- geojson_read("data/us-states.json", what = "sp")
gdp_2017  = read_xlsx("data/qgdpstate0219.xlsx")

#Temporaily rename columns
colnames(gdp_2017) = letters[1:10]

#Takes the rows that are states
#Takes the first two columns and renames to state and gdp_2017
gdp = gdp_2017[gdp_2017$a %in% state.name,] %>% 
  select(a,b) %>% 
  rename(
    "state" = a,
    "gdp_2017" = b
  )
#Rearranges the states in the gdp dataframe to match the 
#states order in the states SpatialPolygonsDataFrame
levels = states$NAME
rearranged_gdp <- as.data.frame(gdp %>% mutate(
  state = factor(state, levels = levels)) %>% 
  arrange(state)
)
#Bins for the map ranging from -2 to 5 incremented by 1
bins <- seq(-2,5,1)
pal <- colorBin(palette = "RdYlGn", domain = rearranged_gdp$gdp_2017, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  rearranged_gdp$state, rearranged_gdp$gdp_2017
) %>% lapply(htmltools::HTML)

colnames(rearranged_gdp)[colnames(rearranged_gdp) == "state"] <- "NAME"
state_data <- left_join(rearranged_gdp, as.data.frame(states), by = "NAME") 


#GDP map of the US 
leaflet(states) %>% 
  addTiles() %>% 
  setView(-97,39, zoom = 3) %>%
  addPolygons(
    fillColor = ~pal(state_data$gdp_2017),
    weight = 1,
    dashArray = "3",
    color = "black",
    fillOpacity = 2,
    highlight = highlightOptions(
      weight = 5,
      color = "#999",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")
  ) %>%  addLegend(
                pal = pal,
                title = "Percent of GDP Growth (2017)",
                values = ~rearranged_gdp$gdp_2017,
                labFormat = labelFormat(suffix = "%", between = " to "),
                position = "bottomleft",
                opacity = 2)



#Taken from A6
national_df <- read_xlsx("dataset/national_M2017_dl.xlsx") %>%
  select(OCC_CODE, OCC_TITLE, OCC_GROUP, TOT_EMP, H_MEAN, A_MEAN) %>%
  rename(
    "tot_emp" = TOT_EMP,
    "hour_mean" = H_MEAN,
    "annual_mean" = A_MEAN
  )

state_df <- read_xlsx("dataset/state_M2017_dl.xlsx")

washington_df <- state_df %>%
  filter(STATE == "Washington") %>%
  select(OCC_CODE, OCC_TITLE, TOT_EMP, H_MEAN, A_MEAN) %>%
  rename(
    "washington_tot_emp" = TOT_EMP,
    "washington_hour_mean" = H_MEAN,
    "washington_annual_mean" = A_MEAN
  )

connecticut_df <- state_df %>%
  filter(STATE == "Connecticut") %>%
  select(OCC_CODE, OCC_TITLE, TOT_EMP, H_MEAN, A_MEAN) %>%
  rename(
    "connecticut_tot_emp" = TOT_EMP,
    "connecticut_hour_mean" = H_MEAN,
    "connecticut_annual_mean" = A_MEAN
  )

washington_vs_connecticut_df <- left_join(washington_df, connecticut_df, by = c("OCC_CODE", "OCC_TITLE"))
national_vs_states_df <- left_join(national_df, washington_vs_connecticut_df, by = c("OCC_CODE", "OCC_TITLE"))

national_vs_states_df[4:11] <- lapply(national_vs_states_df[4:11], as.numeric)
national_vs_states_df <- na.omit(national_vs_states_df)

#This function has no arguments and summzaizes the national_vs_states dataframe and columns 4-11
get_summary <- function() {
  summary(national_vs_states_df[4:11])
}

#This function has no argument and creates a new column 'diff' that calculates the differences of hourly wage for each occupation between Washington and the National data.
#Then it looks for the highest difference between wages and selects the occupation title, the national average and Washington average along with the difference for that occupation.
#Returns a list regarding information relating to the job that has the highest difference in wage between Washington and the National data.
get_greatest_diff_wage_job_for_WA <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = california_hour_mean - hour_mean) %>%
    filter(diff == max(diff, na.rm = TRUE)) %>%
    select(OCC_TITLE, hour_mean, washington_hour_mean, diff)
  as.list(job)
}

#This function has no argument and creates a new column 'diff' that calculates the differences of hourly wage for each occupation between Connecticut and National data.
#Then it looks for the highest difference between wages and selects the occupation title.
#Returns a list regarding information relating to the job that has the highest difference in wage between Connecticut and the National data.
get_greatest_diff_wage_job_for_CT <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = connecticut_hour_mean - hour_mean) %>%
    filter(diff == max(diff, na.rm = TRUE)) %>%
    select(OCC_TITLE)
  as.list(job)
}

#This function has no argument and creates a new column 'diff' that calculates the differences of hourly wage for each occupation between Connecticut and Washington
#Then it looks for the highest difference between wages and selects the occupation title.
#Returns a list regarding information relating to the job that has the highest difference in wage between Connecticut and Washington data.
get_greatest_diff_wage_job_for_WA_vs_CT <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = washington_hour_mean - connecticut_hour_mean) %>%
    filter(diff == max(diff, na.rm = TRUE)) %>%
    select(OCC_TITLE)
  as.list(job)
}

#This function has no argument and filters to look for row that contains to most employees in California and selects the occupation title.
#Returns a data frame containing the occupation title.
get_largest_employment_WA <- function() {
  job <- national_vs_states_df %>%
    filter(OCC_GROUP != "major" & OCC_GROUP != "total") %>%
    filter(washington_tot_emp == max(washington_tot_emp, na.rm = TRUE)) %>%
    select(OCC_TITLE)
}

#This function has no argument and filters to look for row that contains to most employees in Connecticut and selects the occupation title.
#Returns a data frame containing the occupation title.
get_largest_employment_CT <- function() {
  job <- national_vs_states_df %>%
    filter(OCC_GROUP != "major" & OCC_GROUP != "total") %>%
    filter(connecticut_tot_emp == max(connecticut_tot_emp, na.rm = TRUE)) %>%
    select(OCC_TITLE)
}

