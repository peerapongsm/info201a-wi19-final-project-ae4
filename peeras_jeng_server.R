my_server = function(input, output) {
  gender_race_data <- read.csv("dataset/gender_race_data.csv")
  
  arrange_data <- reactive({
    arrange_data = gender_race_data %>% arrange(-Total_Number_Of_Workers)
    if (grepl(input$employee, "most")) {
      arrange_data = arrange_data %>% head(10)
    } else {
      arrange_data = arrange_data %>% tail(10)
    }
  })
  
  diff_gender_data = reactive({
    diff_gender_data = gender_race_data %>% 
      mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers) %>% 
      arrange(-diff_gender)
    if (grepl(input$diff_gender, "most")) {
      diff_gender_data = diff_gender_data %>% head(10)
    } else {
      diff_gender_data = diff_gender_data %>% tail(10)
    }
  })
  
  output$total_employee = renderPlot({
    ggplot(arrange_data(), aes(x = Occupation, y = Total_Number_Of_Workers, fill = Occupation)) + 
      geom_col(alpha = 0.6) +
      theme(axis.text.x = element_blank()) + ylab("Employees")
  })
  output$gender_employee = renderPlot({
    arrange_data = arrange_data() %>% gather(key = "gender", value = "employees", 
                                             Male_Number_Of_Workers, Female_Number_Of_Workers)
    ggplot(arrange_data, aes(x = Occupation, y = employees, fill = gender)) + 
      geom_col(alpha = 0.6, position = "dodge") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
  })
  output$table_employee = renderDataTable({
    arrange_data = arrange_data() %>% select(Occupation, Total_Number_Of_Workers, 
                                             Male_Number_Of_Workers, Female_Number_Of_Workers)
  })
  output$gender_diff = renderPlot({
    ggplot(diff_gender_data(), aes(x = Occupation, y = diff_gender)) + geom_col(fill = "purple", alpha = 0.6) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employment differences")
  })
  output$table_gender_diff = renderDataTable({
    diff_gender_data = diff_gender_data() %>% select(Occupation, diff_gender)
  })
}