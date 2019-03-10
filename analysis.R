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

original_gender_data<- readxl::read_xlsx("dataset/gender_wage.xlsx") 

colnames(original_gender_data) <- c("Occupation", "Total_Number_Of_Workers", "Total_Median_Weekly_Earnings", "Male_Number_Of_Workers", "Male_Median_Weekly_Earnings", "Female_Number_Of_Workers", "Female_Median_Weekly_Earnings")

gender_data <- original_gender_data[-c(1:6, 8), ] %>%
  filter(Total_Median_Weekly_Earnings != "–", Male_Median_Weekly_Earnings != "–", Female_Median_Weekly_Earnings != "–")

View(gender_data)

original_race_data <- readxl::read_xlsx("dataset/race_occupation.xlsx")

colnames(original_race_data) <- c("Occupation", "Percent_Total_Employed", "Percent_Women_Employed", "Percent_White_Employed", "Percent_Black_or_African_American_Employed", "Percent_Asian_Employed", "Percent_Hispanic_or_Latino_Employed")

race_data <- original_race_data[-c(1:6, 8), ] %>%
  filter(Percent_White_Employed != "–", Percent_Black_or_African_American_Employed != "–", Percent_Asian_Employed != "–", Percent_Hispanic_or_Latino_Employed != "–") %>%
  select("Occupation", "Percent_Total_Employed", "Percent_White_Employed", "Percent_Black_or_African_American_Employed", "Percent_Asian_Employed", "Percent_Hispanic_or_Latino_Employed")

View(race_data)

gender_race_data <- inner_join(gender_data, race_data, by = "Occupation")
gender_race_data[2:12] <- mapply(as.numeric, gender_race_data[2:12]) %>% round(2)
View(gender_race_data)
