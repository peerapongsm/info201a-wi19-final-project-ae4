peeras_jeng_analysis_server = function(input, output) {
  gender_race_data <- read.csv("dataset/gender_race_data.csv")

  output$header = renderText({
    "Observations"
  })
  
  output$first_section_content = renderText({
    "While analyzing the graphs, there are many occupations that have a great gap between the number of male and female workers. There are only a handful of occupations that have a balanced number
    of different genders in a specific job. This analysis takes a closer look at the similarities between occupations that have a greater difference between male and female employees and explain why this
    gap exist. The average ethnicity distribution of all occupations is graphed and evaluated to understand the level of diversity in the workplace."
  })
  
  output$questions = renderText({
    "Questions"
  })
  
  output$question_1 = renderText({
    "Which occupation in the top 10 jobs with the most number of employees has the greatest difference in the number of male and female employees? Why does that gap exist?"
  })
  output$question_1_content = renderText({
    "By looking at the graph, the occupation with the greatest gap between male and female employees is in the category of natural resources, construction, and maintenance. 
    This may be because of cultural stereotypes that women are not as suited for labor-intensive jobs as  men. This inference is supported by an article titled \"Where are all the women? Why 99% of construction
    site workers are male\" says that \"part of the problem is sexism: research shows that more than half of female construction workers said they were treated worse than men because of their gender\". Often
    times, women are not held in the same regards as men. This category is an outlier in the gender difference data set because it has the greatest range of 10,514 more male workers than female workers. "
  })
  
  output$question_2 = renderText({
    "What are the similarities in the fields that are dominated by one specific gender?"
  })
  
  output$gender_employee = renderPlot({
    arrange_data = gender_race_data %>% arrange(-Total_Number_Of_Workers) %>% head(10) %>% 
      gather(key = "gender", value = "employees", 
            Male_Number_Of_Workers, Female_Number_Of_Workers)
    ggplot(arrange_data, aes(x = Occupation, y = employees, fill = gender)) + 
      geom_col(alpha = 0.6, position = "dodge") +
      labs(title = "Gender Difference in the Top 10 Occupations with the Most Number of Employees") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
  })
  
  output$male_difference_table_title = renderText ({
    "Top 10 Occupations with More Male Employees"
  })
  
  output$female_difference_table_title = renderText ({
    "Top 10 Occupations with More Female Employees"
  })
  
  output$male_difference_table = renderTable({ 
   arrange_data <- gender_race_data %>% mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers) %>% na.omit() %>% arrange(-diff_gender) %>% head(10) %>% select(Occupation, diff_gender)
   
   colnames(arrange_data)[2] <- "Difference of Male Over Female Employees"
   
   arrange_data
  })
  
  output$question_2_content = renderText({
    "Looking at the categories of the top ten fields that are dominated by men and female respectively, there are some trends to be noted. Most of the male-dominated occupations (represented by the positive difference) 
    are in the transportation and construction area. On the other hand, most of the female-dominated occupations (represented by the negative difference) are in management and in the healthcare department. Comparing the minimum (representing
    the occupation that has more female than male workers) and maximum (representing the occupation that has more male than female workers) of the gender difference column, it is evident that the gender difference is almost twice as large in the natural resources
    occupation of more males. With only 516 women in the natural resources, construction, and maintenance field, men make up 95% of that field. However, in office and adminstrative support occupations, women only make up about 60% of the field. The gap is not as significant
    in the most female-dominated job because it is more culturally common for males to work in the management and business field as it is for women to work in maintenance and construction."
  })
  
  output$female_difference_table = renderTable({ 
    arrange_data <- gender_race_data %>% mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers) %>% na.omit() %>% arrange(diff_gender) %>% head(10) %>% select(Occupation, diff_gender)
  
    colnames(arrange_data)[2] <- "Difference of Female Over Male Employees"
    
    arrange_data
    
  })
  
  output$question_3 = renderText({
    "What do the average ethnicity distributions represent?"
  })
  
  output$pie_title = renderText({
    "Mean Ethnicity Distribution of All Occupations in 2018"
  })
  
  output$management_pie = renderPlot({
    filter_data <- gender_race_data %>%
      select(
        Percent_White_Employed,
        Percent_Black_or_African_American_Employed,
        Percent_Asian_Employed,
        Percent_Hispanic_or_Latino_Employed
      ) %>%
      rename(
        "White" = Percent_White_Employed, "Black" = Percent_Black_or_African_American_Employed,
        "Asian" = Percent_Asian_Employed, "Hispanic" = Percent_Hispanic_or_Latino_Employed
      ) %>%
      summarize(mean_White = mean(White), mean_Black = mean(Black), mean_Asian = mean(Asian), mean_Hispanic = mean(Hispanic))
    filter_data_colnames <- c("Mean White Percentage", "Mean Black Percentage", "Mean Asian Percentage", "Mean Hispanic Percentage")
    filter_data_values <- c(filter_data$mean_White, filter_data$mean_Black, filter_data$mean_Asian, filter_data$mean_Hispanic)
    pct <- round(filter_data_values)
    filter_data_colnames <- paste(filter_data_colnames, pct)
    filter_data_colnames <- paste(filter_data_colnames,"%",sep="") # add % to labels 
    pie(filter_data_values, labels = filter_data_colnames, col = c("purple", "green", "blue", "pink"), density = 40)
  })
  
  output$question_3_content = renderText({
    "Looking at the average ethnicity distributions for all the occupations is important as it shows the level of diversity in the workplace. Analyzing this pie chart, it is evident
    that there is a definite lack of diversity as 75% of the employees are white. It is also significant to note that out of the three minorities, there is typically as a lesser Asian representation in the workforce."
  })
  
  output$conclusion = renderText({
    "Conclusion"
  })

  output$conclusion_content = renderText({
    "Overall, this analysis showed the areas of focus that society needs to be aware of and address. As shown on the first plot, there are still jobs with major gap in the number of female and male workers. The stereotype that women are not suited
    for labor-intensive jobs needs to be broken and treatment towards women in the more male-dominated occupations must to be improved. This will help better balance the number of workers in the natural resources and construction field. The second table
    shows that even when there are jobs that have more female workers, the gap is not as significant as to when the occupation has more male workers. There are also obvious similarities between the jobs that have more of one gender employees. Therefore, society should continue to enocurage women not only
    to enter the workforce, but to enter fields that are more heavily male-dominated. The pie chart shows the need to increase the level of diversity in all occupations. More diversity in the workplace brings in a variety of perspectives and experiences which can greatly enhance
    a project or task."
  })
  
  output$reference = renderText({
    "References"
  })
  
  output$links = renderText({
   "https://www.theguardian.com/careers/careers-blog/2015/may/19/where-are-all-the-women-why-99-of-construction-site-workers-are-male"
  })
}


