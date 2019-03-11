my_server = function(input, output) {
  gender_race_data <- read.csv("dataset/gender_race_data.csv")
  arrange_data <- reactive({
    filter_data = gender_race_data %>% arrange(-Total_Number_Of_Workers)
    if (grepl(input$value, "Most Employee")) {
      filter_data = filter_data %>% head(10)
    } else {
      filter_data = filter_data %>% tail(10)
    }
  })
  output$total = renderPlot({
    ggplot(arrange_data(), aes(x = Occupation, y = Total_Number_Of_Workers)) + geom_point() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
  })
  output$gender = renderPlot({
    arrange_data = arrange_data() %>% gather(key = "gender", value = "employees", 
                                             Male_Number_Of_Workers, Female_Number_Of_Workers)
    ggplot(arrange_data, aes(x = Occupation, y = employees, fill = gender)) + 
      geom_col(alpha = 0.5, position = "dodge") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
  })
}

filter_data = filter_data %>% head(10) %>% gather(key = "gender", value = "employees", Male_Number_Of_Workers, Female_Number_Of_Workers)
