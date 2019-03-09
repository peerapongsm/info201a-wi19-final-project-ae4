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

gender_data<- readxl::read_xlsx("dataset/gender_wage.xlsx") %>%
  filter(Occupation != "Total, full-time wage and salary workers", Total_Median_Weekly_Earnings != "-")

nation_data<- readxl::read_xlsx("dataset/nation_wage.xlsx") %>%
  filter(OCC_GROUP == "broad") %>%
  select(OCC_TITLE, H_MEAN, A_MEAN)

View(gender_data)
