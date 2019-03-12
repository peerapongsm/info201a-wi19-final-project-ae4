peeras_jeng_server <- function(input, output) {
  arrange_data <- reactive({
    arrange_data <- gender_race_data <- read.csv("dataset/gender_race_data.csv") %>%
      mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers)
    if (grepl(input$select, "emp") | grepl(input$select, "gdr")) {
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

  output$bar_header <- renderText({
    tmp <- paste("Top 10 occupations with", input$radio)
    if (grepl(input$select, "emp")) {
      paste(tmp, "total workers")
    } else if (grepl(input$select, "gdr")) {
      paste(tmp, "total workers with gender details")
    } else {
      paste(tmp, "gender different in number of workers")
    }
  })

  output$bar <- renderPlot({
    arrange_data <- arrange_data() %>% head(10)
    if (grepl(input$select, "emp")) {
      ggplot(arrange_data, aes(x = Occupation, y = Total_Number_Of_Workers, fill = Occupation)) +
        geom_col(alpha = 0.6) +
        theme(axis.text.x = element_blank()) + ylab("Employees")
    } else if (grepl(input$select, "gdr")) {
      arrange_data <- arrange_data %>% gather(
        key = "gender", value = "employees",
        Male_Number_Of_Workers, Female_Number_Of_Workers
      )
      ggplot(arrange_data, aes(x = Occupation, y = employees, fill = gender)) +
        geom_col(alpha = 0.6, position = "dodge") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
    } else {
      ggplot(arrange_data, aes(x = Occupation, y = diff_gender)) + geom_col(fill = "purple", alpha = 0.6) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employment differences")
    }
  })

  output$table_header <- renderText({
    if (grepl(input$select, "emp")) {
      "Table of total workers by occupation"
    } else if (grepl(input$select, "gdr")) {
      "Table of workers per gender by occupation"
    } else {
      "Table of gender different in workers by occupation"
    }
  })

  output$table <- renderDataTable({
    arrange_data <- arrange_data()
    if (grepl(input$select, "emp")) {
      arrange_data <- arrange_data %>% select(Occupation, Total_Number_Of_Workers)
    } else if (grepl(input$select, "gdr")) {
      arrange_data <- arrange_data %>% select(Occupation, Male_Number_Of_Workers, Female_Number_Of_Workers)
    } else {
      arrange_data <- arrange_data %>% select(Occupation, diff_gender)
    }
    datatable(arrange_data, filter = "none", select = "single")
  })

  output$note <- renderText({
    if (grepl(input$select, "gdiff")) {
      "*Note: When the differences are negative, it means that there are more females employed in that specific occupation. 
      When the differences are positive, it means that there are more males employed in the specific occupation."
    }
  })

  output$pie_header <- renderText({
    if (is.null(input$table_row_last_clicked)) {
      "Please select an occupation from table to plot a pie chart"
    } else {
      filter_data <- arrange_data()
      paste(
        "Pie chart of ethnicity employment percentages for", filter_data[input$table_rows_selected, 3]
      )
    }
  })
  output$pie <- renderPlot({
    if (!is.null(input$table_row_last_clicked)) {
      filter_data <- arrange_data()
      title <- filter_data[input$table_rows_selected, 3]
      filter_data <- filter_data %>%
        filter(grepl(title, Occupation)) %>%
        select(
          Occupation, Percent_White_Employed,
          Percent_Black_or_African_American_Employed,
          Percent_Asian_Employed,
          Percent_Hispanic_or_Latino_Employed
        ) %>%
        rename(
          "White" = Percent_White_Employed, "Black" = Percent_Black_or_African_American_Employed,
          "Asian" = Percent_Asian_Employed, "Hispanic" = Percent_Hispanic_or_Latino_Employed
        ) %>%
        gather(key = "Ethnicity", value = "Employed_percentage", White, Black, Asian, Hispanic)
      begin <- sum(filter_data$Employed_percentage) - 100
      bar <- ggplot(filter_data, aes(x = "", y = Employed_percentage, fill = Ethnicity)) + geom_col(alpha = 0.6)
      blank_theme <- theme_minimal() +
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.border = element_blank(),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(size = 14, face = "bold")
        )
      pie <- bar + coord_polar("y", start = begin) +
        blank_theme + theme(axis.text.x = element_blank()) +
        geom_text(aes(label = paste0(round(Employed_percentage - (begin / 4), 2), "%")),
          position = position_stack(vjust = 0.5), size = 6
        )
      pie
    }
  })
}
