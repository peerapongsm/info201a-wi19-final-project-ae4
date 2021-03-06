gather_server <- function(input, output) {
  ## Jacinda's Analysis Server##
  gender_race_data <- reactive({
    gender_race_data <- read.csv("server/dataset/gender_race_data.csv") # reads the gender_race_data.csv file and stores it in gender_race_data
    gender_race_data
  })

  output$gender_header <- renderText({ # displays an "observations" header
    "Observations"
  })

  output$gender_first_section_content <- renderText({ # displays the analysis for the observations section
    "While analyzing the graphs, there are many occupations that have a great gap between the number of male and female workers. There are only a handful of occupations that have a balanced number
    of different genders in a specific job. This analysis takes a closer look at the similarities between occupations that have a greater difference between male and female employees and explain why this
    gap exist. The average ethnicity distribution of all occupations is graphed and evaluated to understand the level of diversity in the workplace."
  })

  output$gender_questions <- renderText({ # displays a "questions" header
    "Questions"
  })

  output$gender_question_1 <- renderText({ # displays the first analysis question
    "Which occupation in the top 10 jobs with the most number of employees has the greatest difference in the number of male and female employees? Why does that gap exist?"
  })
  output$gender_question_1_content <- renderText({ # displays the analysis for the first question
    "By looking at the graph, the occupation with the greatest gap between male and female employees is in the category of natural resources, construction, and maintenance. 
    This may be because of cultural stereotypes that women are not as suited for labor-intensive jobs as  men. This inference is supported by an article titled \"Where are all the women? Why 99% of construction
    site workers are male\" says that \"part of the problem is sexism: research shows that more than half of female construction workers said they were treated worse than men because of their gender\". Often
    times, women are not held in the same regards as men. This category is an outlier in the gender difference data set because it has the greatest range of 10,514 more male workers than female workers. "
  })

  output$gender_question_2 <- renderText({ # displays the second analysis question
    "What are the similarities in the fields that are dominated by one specific gender?"
  })

  output$gender_employee <- renderPlot({ # plots a bar graph showing the gender difference in the top 10 occupations with the most number of employees
    sort_data <- gender_race_data() %>%
      arrange(-Total_Number_Of_Workers) %>%
      head(10) %>%
      gather(
        key = "gender", value = "employees",
        Male_Number_Of_Workers, Female_Number_Of_Workers
      )
    ggplot(sort_data, aes(x = Occupation, y = employees, fill = gender)) +
      geom_col(alpha = 0.6, position = "dodge") +
      labs(title = "Gender Difference in the Top 10 Occupations with the Most Number of Employees") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Employees")
  })

  output$male_difference_table_title <- renderText({ # displays the table title with more male than female workers
    "Top 10 Occupations with More Male Employees"
  })

  output$female_difference_table_title <- renderText({ # displays the table title with more female than male workers
    "Top 10 Occupations with More Female Employees"
  })

  output$male_difference_table <- renderTable({ # displays a table that shows the top 10 jobs that have more males than females
    sort_data <- gender_race_data() %>% mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers) %>% na.omit() %>% arrange(-diff_gender) %>% head(10) %>% select(Occupation, diff_gender)

    colnames(sort_data)[2] <- "Difference of Male Over Female Employees"

    sort_data
  })

  output$gender_question_2_content <- renderText({ # displays analysis for question two
    "Looking at the categories of the top ten fields that are dominated by men and female respectively, there are some trends to be noted. Most of the male-dominated occupations (represented by the positive difference) 
    are in the transportation and construction area. On the other hand, most of the female-dominated occupations (represented by the negative difference) are in management and in the healthcare department. Comparing the minimum (representing
    the occupation that has more female than male workers) and maximum (representing the occupation that has more male than female workers) of the gender difference column, it is evident that the gender difference is almost twice as large in the natural resources
    occupation of more males. With only 516 women in the natural resources, construction, and maintenance field, men make up 95% of that field. However, in office and adminstrative support occupations, women only make up about 60% of the field. The gap is not as significant
    in the most female-dominated job because it is more culturally common for males to work in the management and business field as it is for women to work in maintenance and construction."
  })

  output$female_difference_table <- renderTable({ # displays a table that shows the top 10 jobs that have more emales than males
    sort_data <- gender_race_data() %>% mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers) %>% na.omit() %>% arrange(diff_gender) %>% head(10) %>% select(Occupation, diff_gender)

    colnames(sort_data)[2] <- "Difference of Female Over Male Employees"

    sort_data
  })

  output$gender_question_3 <- renderText({ # displays the third analysis question
    "What do the average ethnicity distributions represent?"
  })

  output$gender_pie_title <- renderText({ # displays the title of the pie chart for the third analysis question
    "Mean Ethnicity Distribution of All Occupations in 2018"
  })

  output$ethnicity_pie <- renderPlot({ # displays a pie chart representing the average ethnicity distribution for all occupations
    filter_data <- gender_race_data() %>%
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
    filter_data_colnames <- paste(filter_data_colnames, "%", sep = "") # add % to labels
    pie(filter_data_values, labels = filter_data_colnames, col = c("purple", "green", "blue", "pink"), density = 40)
  })

  output$gender_question_3_content <- renderText({ # displays the third question's analysis
    "Looking at the average ethnicity distributions for all the occupations is important as it shows the level of diversity in the workplace. Analyzing this pie chart, it is evident
    that there is a definite lack of diversity as 75% of the employees are white. It is also significant to note that out of the three minorities, there is typically as a lesser Asian representation in the workforce."
  })

  output$gender_conclusion <- renderText({ # displays the "conclusion" header
    "Conclusion"
  })

  output$gender_conclusion_content <- renderText({ # displays the conclusion content
    "Overall, this analysis showed the areas of focus that society needs to be aware of and address. As shown on the first plot, there are still jobs with major gap in the number of female and male workers. The stereotype that women are not suited for labor-intensive jobs needs to be broken and treatment towards women in the more male-dominated occupations must to be improved. This will help better balance the number of workers in the natural resources and construction field. The second table shows that even when there are jobs that have more female workers, the gap is not as significant as to when the occupation has more male workers. There are also obvious similarities between the jobs that have more of one gender employees. Therefore, society should continue to encourage women not only to enter the workforce, but to enter fields that are more heavily male-dominated. 
    The pie chart shows the need to increase the level of diversity in all occupations. More diversity in the workplace brings in a variety of perspectives and experiences which can greatly enhance a project or task."
  })

  ## Peerapong's Server##

  arrange_data <- reactive({ # Arrange data frame for gender and race data sort by input
    arrange_data <- gender_race_data() %>%
      mutate(diff_gender = Male_Number_Of_Workers - Female_Number_Of_Workers)
    if (grepl(input$select, "emp") | grepl(input$select, "gdr")) {
      if (grepl(input$radio, "most")) {
        arrange_data <- arrange_data %>% na.omit() %>% arrange(-Total_Number_Of_Workers)
      } else {
        arrange_data <- arrange_data %>% na.omit() %>% arrange(Total_Number_Of_Workers)
      }
    } else {
      if (grepl(input$radio, "most")) {
        arrange_data <- arrange_data %>% na.omit() %>% arrange(-diff_gender)
      } else {
        arrange_data <- arrange_data %>% na.omit() %>% arrange(diff_gender)
      }
    }
    arrange_data
  })

  output$bar_header <- renderText({ # Text output for bar plot header
    tmp <- paste("Top 10 occupations with", input$radio)
    if (grepl(input$select, "emp")) {
      paste(tmp, "total workers")
    } else if (grepl(input$select, "gdr")) {
      paste(tmp, "total workers with gender details")
    } else {
      paste(tmp, "gender different in number of workers")
    }
  })

  output$gender_bar <- renderPlot({ # Bar plot for gender data
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

  output$table_header <- renderText({ # Text output for table header
    if (grepl(input$select, "emp")) {
      "Table of total workers by occupation"
    } else if (grepl(input$select, "gdr")) {
      "Table of workers per gender by occupation"
    } else {
      "Table of gender different in workers by occupation"
    }
  })

  output$gender_table <- renderDataTable({ # Data table for data use for plot
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

  output$note <- renderText({ # Text output describing behavior of the plot
    if (grepl(input$select, "gdiff")) {
      "*Note: When the differences are negative, it means that there are more females employed in that specific occupation. 
      When the differences are positive, it means that there are more males employed in the specific occupation."
    }
  })

  output$pie_header <- renderText({ # Text output for pie chart header
    if (is.null(input$gender_table_row_last_clicked)) {
      "Please select an occupation from table to plot a pie chart"
    } else {
      filter_data <- arrange_data()
      paste(
        "Pie chart of ethnicity employment percentages for", filter_data[input$gender_table_rows_selected, 3]
      )
    }
  })

  output$pie <- renderPlot({ # Pie chart for race data
    if (!is.null(input$gender_table_row_last_clicked)) {
      filter_data <- arrange_data()
      title <- filter_data[input$gender_table_rows_selected, 3]
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

  ## Sarah's Server##

  # dataset
  national_vs_states_df <- reactive({
    national_data <- read_xlsx("server/dataset/national_data.xlsx") %>%
      filter(H_MEAN != "*") %>%
      select(OCC_TITLE, OCC_GROUP, H_MEAN) %>%
      rename("national_hour_mean" = H_MEAN)
    state_data <- read_xlsx("server/dataset/state_data.xlsx")
    WA_data <- state_data %>%
      filter(
        STATE == "Washington", H_MEAN != "*", H_MEAN != "#",
        TOT_EMP != "**", TOT_EMP != "#"
      ) %>%
      select(OCC_TITLE, H_MEAN, TOT_EMP) %>%
      rename(
        "washington_hour_mean" = H_MEAN,
        "washington_tot_emp" = TOT_EMP
      )
    CT_data <- state_data %>%
      filter(
        STATE == "Connecticut", H_MEAN != "*", H_MEAN != "#",
        TOT_EMP != "**", TOT_EMP != "#"
      ) %>%
      select(OCC_TITLE, H_MEAN, TOT_EMP) %>%
      rename(
        "connecticut_hour_mean" = H_MEAN,
        "connecticut_tot_emp" = TOT_EMP
      )
    national_vs_states_df <- left_join(national_data, WA_data, by = "OCC_TITLE")
    national_vs_states_df <- left_join(national_vs_states_df, CT_data, by = "OCC_TITLE") %>% na.omit()
    national_vs_states_df[3:7] <- lapply(national_vs_states_df[3:7], as.numeric)
    national_vs_states_df
  })

  # get map for gdp
  output$gdpMap <- renderLeaflet({
    states <- geojson_read("server/dataset/us-states.json", what = "sp")
    rearranged_gdp <- rearranged_gdp()
    states@data <- states@data %>% mutate(gdp = rearranged_gdp$gdp_2017)
    bins <- seq(-2, 5, 1)
    pal <- colorBin(palette = "RdYlGn", domain = states@data$gdp, bins = bins)

    leaflet(states) %>%
      addTiles() %>%
      setView(-97, 39, zoom = 3) %>%
      addPolygons(
        fillColor = ~ pal(gdp),
        weight = 1,
        dashArray = "3",
        fillOpacity = 2,
        highlight = highlightOptions(
          weight = 5,
          color = "#999",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        label = states@data$NAME,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"
        )
      ) %>%
      addLegend(
        pal = pal,
        title = "Percent of GDP Growth (2017)",
        values = states@data$gdp,
        labFormat = labelFormat(suffix = "%", between = " to "),
        position = "bottomleft",
        opacity = 2
      )
  })

  # Washington difference 5 jobs
  output$waDiff <- renderPlot({
    job <- head(national_vs_states_df() %>%
      mutate(diff = washington_hour_mean - national_hour_mean) %>%
      arrange(desc(diff)) %>%
      select(
        OCC_TITLE, washington_hour_mean, national_hour_mean
      ), 5)
    job_gather <- job %>%
      gather(
        key = state,
        value = wage,
        -OCC_TITLE
      )
    ggplot(data = job_gather) +
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = wage,
        fill = state
      ), position = "dodge") +
      labs(
        title = "Hourly Wages between National and Washington",
        x = "Occupation",
        y = "Hourly Wage",
        color = "State Data"
      ) + theme(
        legend.justification = c("left", "top")
      )
  })

  # Connecticut difference 5 jobs
  output$ctDiff <- renderPlot({
    job <- national_vs_states_df() %>%
      mutate(diff = connecticut_hour_mean - national_hour_mean) %>%
      arrange(desc(diff)) %>%
      select(
        OCC_TITLE, connecticut_hour_mean, national_hour_mean
      )

    job_gather <- job %>%
      head(5) %>%
      gather(
        key = state,
        value = wage,
        -OCC_TITLE
      )
    ggplot(data = job_gather) +
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = wage,
        fill = state
      ), position = "dodge") +
      labs(
        title = "Hourly Wages between National and Connecticut",
        x = "Occupation",
        y = "Hourly Wage",
        color = "State Data"
      )
  })
  # Question: what job has the highest number of employees in Washington

  output$employmentWA <- renderPlot({
    job <- national_vs_states_df() %>%
      filter(OCC_GROUP == "detailed") %>%
      arrange(desc(washington_tot_emp)) %>%
      select(OCC_TITLE, washington_tot_emp, washington_hour_mean)
    ggplot(data = head(job, 5)) +
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = washington_tot_emp,
        fill = OCC_TITLE
      ), position = "dodge") +
      labs(
        title = "Top 5 Employment Occupations in Washington",
        x = "Occupation",
        y = "Employment number",
        color = "State Data"
      ) + theme(axis.text.x = element_blank())
  })
  # connecticut top 5 employment jobs
  output$employmentCT <- renderPlot({
    job <- national_vs_states_df() %>%
      filter(OCC_GROUP == "detailed") %>%
      arrange(desc(connecticut_tot_emp)) %>%
      select(OCC_TITLE, connecticut_tot_emp, connecticut_hour_mean)
    ggplot(data = head(job, 5)) +
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = connecticut_tot_emp,
        fill = OCC_TITLE
      ), position = "dodge") +
      labs(
        title = "Top 5 Employment Occupations in Connecticut",
        x = "Occupation",
        y = "Employment number",
        color = "State Data"
      ) + theme(axis.text.x = element_blank())
  })

  ## Kelly's Server##

  # A data set of the states
  state_df <- reactive({
    state_df <- read_xlsx("server/dataset/state_data.xlsx") %>%
      select(STATE, OCC_TITLE, OCC_GROUP, A_MEAN, H_MEAN, TOT_EMP) %>%
      subset(A_MEAN != "#" & A_MEAN != "*" &
        H_MEAN != "#" & H_MEAN != "*" &
        TOT_EMP != "**")
    state_df[4:6] <- lapply(state_df[4:6], as.numeric)
    state_df
  })

  # Data set of the United States' GDP
  rearranged_gdp <- reactive({
    states <- geojson_read("server/dataset/us-states.json", what = "sp")
    gdp_2017 <- read_xlsx("server/dataset/gdp_2017.xlsx") %>% select(state, gdp_2017)
    gdp <- gdp_2017[gdp_2017$state %in% state.name, ]
    left_over <- data.frame(state = c("District of Columnbia", "Puerto Rico"), gdp_2017 = c(0, 0))
    gdp <- rbind(gdp, left_over)
    levels <- states@data$NAME
    rearranged_gdp <- as.data.frame(gdp %>%
      mutate(
        state = factor(state, levels = levels)
      ) %>%
      arrange(state))
    rearranged_gdp
  })

  # This creates a map of the US that either shows the United States' GDP, Average Salary, and Average Hourly Wage
  # The user can also over over the state to reveal a specfic value related
  output$map <- renderLeaflet({
    states <- geojson_read("server/dataset/us-states.json", what = "sp")
    rearranged_gdp <- rearranged_gdp()
    states_summarized <- state_df() %>%
      group_by(STATE) %>%
      summarize(
        avg_hour_wage = round(mean(H_MEAN, na.rm = TRUE), 2),
        avg_total_employee = round(mean(TOT_EMP, na.rm = TRUE), 2)
      ) %>%
      filter(STATE != "Guam" & STATE != "Virgin Islands")
    levels <- states@data$NAME
    rearranged_states_summarized <- as.data.frame(states_summarized %>%
      mutate(
        state = factor(STATE, levels = levels)
      ) %>%
      arrange(state))
    # Adds another column
    states@data <- states@data %>% mutate(
      gdp = rearranged_gdp$gdp_2017,
      hourly_wage = rearranged_states_summarized$avg_hour_wage,
      total_employee = rearranged_states_summarized$avg_total_employee
    )

    if (input$map_value == "gdp") {
      bins <- seq(-2, 5, 1)
      pal <- colorBin(palette = "RdYlGn", domain = states@data$gdp, bins = bins)

      labels <- sprintf(
        "<strong>%s</strong><br/>%g percent",
        states@data$NAME, states@data$gdp
      ) %>% lapply(htmltools::HTML)
      map_title <- "Percent of GDP Growth (2017)"
      map_value <- states@data$gdp
    }
    else if (input$map_value == "wage") {
      bins <- seq(16, 36, length.out = 7)
      pal <- colorBin(palette = "PuBuGn", domain = states@data$hourly_wage, bins = bins)

      labels <- sprintf(
        "<strong>%s</strong><br/>$%g/hr",
        states@data$NAME, states@data$hourly_wage
      ) %>% lapply(htmltools::HTML)
      map_title <- "Hourly Wages in USD (2017)"
      map_value <- states@data$hourly_wage
    } else {
      bins <- c(1000, 5000, 10000, 20000, 30000, 40000, 50000, 68000)
      pal <- colorBin(palette = "RdPu", domain = states@data$hourly_wage, bins = bins)

      labels <- sprintf(
        "<strong>%s</strong><br/>%g employees",
        states@data$NAME, states@data$total_employee
      ) %>% lapply(htmltools::HTML)
      map_title <- "Average Total Employees Among All Occupations (2017)"
      map_value <- states@data$total_employee
    }

    # Map of the US
    leaflet(states) %>%
      addTiles() %>%
      setView(-97, 39, zoom = 3) %>%
      addPolygons(
        fillColor = ~ pal(map_value), weight = 1, dashArray = "3",
        color = "black", fillOpacity = 2,
        highlight = highlightOptions(
          weight = 5, color = "#999",
          dashArray = "", fillOpacity = 0.7, bringToFront = TRUE
        ),
        label = labels, labelOptions = labelOptions(
          style = list(
            "font-weight" = "normal",
            padding = "3px 8px"
          ),
          textsize = "15px", direction = "auto"
        )
      ) %>%
      addLegend(
        pal = pal, title = map_title,
        values = map_value, position = "bottomleft", opacity = 2
      )
  })

  # This creates a bar graph that uses the states dataframe
  output$plot <- renderPlot({
    filter_data <- state_df()

    filter_data <- filter_data %>%
      filter(OCC_GROUP == input$plot_occ) %>%
      filter(STATE == str_to_title(input$plot_state))

    if (input$plot_value == "A_MEAN") {
      filter_data <- filter_data
      if (input$plot_select == "top") {
        top_str <- "Highest"
        filter_data <- filter_data %>% arrange(A_MEAN)
      } else {
        filter_data <- filter_data %>% arrange(desc(A_MEAN))
        top_str <- "Lowest"
      }
    } else if (input$plot_value == "H_MEAN") {
      filter_data <- filter_data
      if (input$plot_select == "top") {
        filter_data <- filter_data %>% arrange(H_MEAN)
        top_str <- "Highest"
      } else {
        filter_data <- filter_data %>% arrange(desc(H_MEAN))
        top_str <- "Lowest"
      }
    } else {
      filter_data <- filter_data
      if (input$plot_select == "top") {
        filter_data <- filter_data %>% arrange(TOT_EMP)
        top_str <- "Highest"
      } else {
        filter_data <- filter_data %>% arrange(desc(TOT_EMP))
        top_str <- "Lowest"
      }
    }

    filter_data <- filter_data %>% head(5)
    if (input$plot_value == "TOT_EMP") {
      y_title <- "Total Employees"
    } else if (input$plot_value == "H_MEAN") {
      y_title <- "Hourly Wage"
    } else {
      y_title <- "Annual Salary"
    }

    ggplot(data = filter_data) +
      geom_col(mapping = aes_string(
        x = "OCC_TITLE",
        y = input$plot_value
      ), fill = "Pink", alpha = 0.4) + labs(
        title = paste("Top 5 Occupations with the", top_str, y_title, "in", input$plot_state),
        x = "Occupation",
        y = y_title
      ) + theme(
        legend.justification = c("left", "top"),
        axis.text.x = element_text(
          face = "bold",
          size = 10, angle = 90
        ),
        axis.text.y = element_text(
          face = "bold",
          size = 10
        )
      )
  })

  # This creates a table that filters to the user's selected values
  output$table <- renderTable({
    filter_data <- state_df() %>%
      filter(OCC_GROUP == input$table_occ) %>%
      filter(STATE == str_to_title(input$table_state))


    if (input$table_value == "TOT_EMP") {
      if (input$table_select == "top") {
        filter_data <- filter_data %>% arrange(TOT_EMP)
      } else {
        filter_data <- filter_data %>% arrange(desc(TOT_EMP))
      }
      filter_data <- filter_data %>% select(STATE, OCC_TITLE, TOT_EMP)
    } else if (input$table_value == "A_MEAN") {
      if (input$table_select == "top") {
        filter_data <- filter_data %>% arrange(A_MEAN)
      } else {
        filter_data <- filter_data %>% arrange(desc(A_MEAN))
      }
      filter_data <- filter_data %>% select(STATE, OCC_TITLE, A_MEAN)
    } else {
      if (input$table_select == "top") {
        filter_data <- filter_data %>% arrange(H_MEAN)
      } else {
        filter_data <- filter_data %>% arrange(desc(H_MEAN))
      }
      filter_data <- filter_data %>% select(STATE, OCC_TITLE, H_MEAN)
    }
    filter_data %>% head(10)
  })
}
