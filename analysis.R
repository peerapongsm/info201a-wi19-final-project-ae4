#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("hexbin")
#install.packages("leaflet")
library("leaflet")
library("hexbin")
library("ggplot2")
library("dplyr")
library("tidyr")
options(scipen = 999)

gender_data<- readxl::read_xlsx("dataset/gender_wage_2017.xlsx") %>%
  filter(Occupation != "Total, full-time wage and salary workers", Total_Median_Weekly_Earnings != "–", Male_Median_Weekly_Earnings != "–", Female_Median_Weekly_Earnings != "–")

gender_data[[1]] <- toupper(gender_data[[1]])

nation_data<- readxl::read_xlsx("dataset/nation_wage.xlsx") %>%
  filter(OCC_GROUP == "broad", H_MEAN != "*") %>%
  select(OCC_TITLE, H_MEAN, A_MEAN)

colnames(nation_data)[1] <- "Occupation"
colnames(nation_data)[2] <- "Hourly_Mean"
colnames(nation_data)[3] <- "Annual_Mean"

nation_data[[1]] <- toupper(nation_data[[1]])

gender_nation_data <- inner_join(gender_data, nation_data, by = "Occupation")

View(gender_nation_data)