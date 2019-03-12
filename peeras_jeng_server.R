peeras_jeng_server = function(input, output) {
  
  arrange_data <- reactive({
    arrange_data = gender_race_data <- read.csv("dataset/gender_race_data.csv") %>% 
                    mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers)
    if(grepl(input$select, "emp") | grepl(input$select, "gdr")) {
      if (grepl(input$radio, "most")) {
        arrange_data %>% na.omit() %>% arrange(-Total_Number_Of_Workers)
      } else {
        arrange_data %>% na.omit() %>% arrange(Total_Number_Of_Workers)
      }
    } else {
      if (grepl(input$radio, "most")) {
        arrange_data %>% na.omit() %>% arrange(-diff_gender)
      } else {
        arrange_data %>% na.omit() %>% arrange(diff_gender)
      }
    }
  })
  
  output$bar_header = renderText({
    tmp = paste("Top 10 occupations with", input$radio)
    if (grepl(input$select, "emp")) {
      paste(tmp, "total workers")
    } else if (grepl(input$select, "gdr")) {
      paste(tmp, "total workers with gender details")
    }  else {
      paste(tmp, "gender different in number of workers")
    }
  })
  
  output$bar = renderPlot({
    arrange_data = arrange_data() %>% head(10)
    if(grepl(input$select, "emp")) {
      ggplot(arrange_data, aes(x = Occupation, y = Total_Number_Of_Workers, fill = Occupation)) + 
        geom_col(alpha = 0.6) +
        theme(axis.text.x = element_blank()) + ylab("Employees")
    } else if (grepl(input$select, "gdr")) {
      arrange_data = arrange_data %>% gather(key = "gender", value = "employees", 
                                               Male_Number_Of_Workers, Female_Number_Of_Workers)
      ggplot(arrange_data, aes(x = Occupation, y = employees, fill = gender)) + 
        geom_col(alpha = 0.6, position = "dodge") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
    } else {
      ggplot(arrange_data, aes(x = Occupation, y = diff_gender)) + geom_col(fill = "purple", alpha = 0.6) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employment differences")
    }
  })
  
  output$table_header = renderText({
    if (grepl(input$select, "emp")) {
      "Table of total workers by occupation"
    } else if (grepl(input$select, "gdr")) {
      "Table of workers per gender by occupation"
    }  else {
      "Table of gender different in workers by occupation"
    }
  })
  
  output$table = renderDataTable({
    arrange_data = arrange_data()
    if(grepl(input$select, "emp")) {
      arrange_data = arrange_data %>% select(Occupation, Total_Number_Of_Workers)
    } else if (grepl(input$select, "gdr")) {
      arrange_data = arrange_data %>% select(Occupation, Male_Number_Of_Workers, Female_Number_Of_Workers)
    } else {
      arrange_data = arrange_data %>% select(Occupation, diff_gender)
    }
    datatable(arrange_data, filter = "none", select = "single")
  })
  
  output$note = renderText({
    if(grepl(input$select, "gdiff")) {
      "*Note: When the differences are negative, it means that there are more females employed in that specific occupation. 
      When the differences are positive, it means that there are more males employed in the specific occupation."
    }
  })
  
  output$pie = renderPlot({
    print('test')
  })
}

