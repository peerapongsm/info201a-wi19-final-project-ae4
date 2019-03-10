
library('geojson')
library("geojsonio")
library("leaflet")
library("readxl")
library("dplyr")
library(ggplot2)

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

#Adds in District of Columbia and Puerto Rico rows 
left_over  = data.frame(state = c("District of Columnbia","Puerto Rico"), gdp_2017 = c(0,0))
gdp = rbind(gdp,left_over)
#Creates levels to match with the states json
levels = states$NAME
rearranged_gdp <- as.data.frame(gdp %>% mutate(
  state = factor(state, levels = levels)) %>% 
    arrange(state)
)

#Adds another column
states@data = states@data %>% mutate(gdp = rearranged_gdp$gdp_2017)



#Bins for the map ranging from -2 to 5 incremented by 1
bins <- seq(-2,5,1)
pal <- colorBin(palette = "RdYlGn", domain = states@data$gdp, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  states@data$NAME, states@data$gdp
) %>% lapply(htmltools::HTML)

#GDP map of the US 
leaflet(states) %>% 
  addTiles() %>% 
  setView(-97,39, zoom = 3) %>%
  addPolygons(
    fillColor = ~pal(gdp),
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
                values = gdp,
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
#Graph as box and whisker plot
get_summary <- function() {
  summary(national_vs_states_df[4:11])
}

#Question: What occupations in Washington have the highest difference of wage comapared to the national data? 
get_greatest_diff_wage_job_for_WA <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = washington_hour_mean - hour_mean) %>%
    arrange(desc(diff)) %>% 
    select(
      OCC_TITLE, washington_hour_mean, hour_mean, diff)
  
    as.data.frame(head(job))
} 

#Question: What occupations in Connecticut have the highest difference of wage comapared to the national data? 
get_greatest_diff_wage_job_for_CT <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = connecticut_hour_mean - hour_mean) %>%
    arrange(desc(diff)) %>% 
    select(
      OCC_TITLE, connecticut_hour_mean, hour_mean, diff)
  
  as.data.frame(head(job))
}



#Question: What occupation between Washington and Connecticut have  the highest difference in wages?
get_greatest_diff_wage_job_for_WA_vs_CT <- function() {
  job <- national_vs_states_df %>%
    mutate(diff = washington_hour_mean - connecticut_hour_mean) %>%
    arrange(desc(diff)) %>% 
    select(
      OCC_TITLE, connecticut_hour_mean, washington_hour_mean, diff)
  
  as.data.frame(head(job))
}

#Question: what job has the highest number of employees in Washington
get_largest_employment_WA <- function() {
  job <- national_vs_states_df %>%
    filter(OCC_GROUP != "major" & OCC_GROUP != "total") %>%
    arrange(desc(diff)) %>% 
    select(
      OCC_TITLE, washington_tot_emp, washington_hour_mean)
  
  as.data.frame(head(job))
}

#Question: What job has the hight number of employees in Connecticut
get_largest_employment_CT <- function() {
  job <- national_vs_states_df %>%
    filter(OCC_GROUP != "major" & OCC_GROUP != "total") %>%
    arrange(desc(diff)) %>% 
    select(
      OCC_TITLE, washington_tot_emp, washington_hour_mean)
  as.data.frame(head(job))
}

