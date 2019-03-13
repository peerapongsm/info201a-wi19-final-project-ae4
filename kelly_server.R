kelly_server <- function(input, output){
  
  #A data set of the states
  state_df = reactive({
    state_df <- read_xlsx("dataset/state_data.xlsx") %>% 
      select(STATE, OCC_TITLE, OCC_GROUP, A_MEAN, H_MEAN, TOT_EMP) %>% 
      subset(A_MEAN != "#" & A_MEAN != "*" & 
               H_MEAN != "#" & H_MEAN != "*" & 
               TOT_EMP != "**")
  })
  
  gdp_2017 = reactive({
    gdp_2017<- read_xlsx("dataset/gdp_2017.xlsx")
  })
 
  #This creates a map of the US that either shows the United States' GDP, Average Salary, and Average Hourly Wage
  #The user can also over over the state to reveal a specfic value related 
  output$map <- renderLeaflet({
    gdp_2017 = gdp_2017()
    states <- geojson_read("dataset/us-states.json", what = "sp")
    
    #Temporaily rename columns
    colnames(gdp_2017) <- letters[1:10]
    
    #Takes the rows that are states
    #Takes the first two columns and renames to state and gdp_2017
    gdp <- gdp_2017[gdp_2017$a %in% state.name,] %>% select(a,b) %>% 
      rename("state" = a,"gdp_2017" = b)
    
    #Adds in District of Columbia and Puerto Rico rows to the gdp dataframe
    left_over <- data.frame(state = c("District of Columnbia","Puerto Rico"), gdp_2017 = c(0,0))
    gdp = rbind(gdp,left_over)
    
    state_df <- state_df() 
    state_df[4:6] <- lapply(state_df[4:6], as.numeric)
    states_summarized <- state_df %>%
      group_by(STATE) %>% summarize(
        avg_hour_wage = round(mean(H_MEAN, na.rm = TRUE), 2),
        avg_total_employee = round(mean(TOT_EMP, na.rm = TRUE), 2)
      ) %>%
      filter(STATE !=  "Guam" & STATE != "Virgin Islands")
    
    
    #Creates levels to match with the states json
    levels = states$NAME
    rearranged_states_summarized <- as.data.frame(states_summarized %>% mutate(
      state = factor(STATE, levels = levels)) %>%
        arrange(state))
    rearranged_gdp <- as.data.frame(gdp %>% mutate(
      state = factor(state, levels = levels)) %>% 
        arrange(state)
    )
    
    #Adds another column
    states@data = states@data %>% mutate(gdp = rearranged_gdp$gdp_2017,
                                         hourly_wage = rearranged_states_summarized$avg_hour_wage,
                                         total_employee = rearranged_states_summarized$avg_total_employee)
    
    
    
    if(input$map_value == "gdp"){
    bins <- seq(-2,5,1)
    pal <- colorBin(palette = "RdYlGn", domain = states@data$gdp, bins = bins)
    
    labels <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      states@data$NAME, states@data$gdp
    ) %>% lapply(htmltools::HTML)
    map_title <- "Percent of GDP Growth (2017)"
    map_value <- states@data$gdp
    }
    else if(input$map_value == "wage"){
      bins <- seq(16,36, length.out = 7)
      pal <- colorBin(palette = "PuBuGn", domain = states@data$hourly_wage, bins = bins)
      
      labels <- sprintf(
        "<strong>%s</strong><br/>$%g/hr",
        states@data$NAME, states@data$hourly_wage
      ) %>% lapply(htmltools::HTML)
      map_title <- "Hourly Wages in USD (2017)"
      map_value <- states@data$hourly_wage
    } else{
      bins <-  c(1000,5000,10000,20000,30000,40000,50000,68000)
      pal <- colorBin(palette = "RdPu", domain = states@data$hourly_wage, bins = bins)
      
      labels <- sprintf(
        "<strong>%s</strong><br/>%g employees",
        states@data$NAME, states@data$total_employee
      ) %>% lapply(htmltools::HTML)
      map_title <- "Average Total Employees Among All Occupations (2017)"
      map_value <- states@data$total_employee
    }
    
    #Map of the US 
    leaflet(states) %>% 
      addTiles() %>% 
      setView(-97,39, zoom = 3) %>%
      addPolygons(fillColor = ~pal(map_value), weight = 1, dashArray = "3", color = "black", fillOpacity = 2,
        highlight = highlightOptions(weight = 5, color = "#999", dashArray = "", fillOpacity = 0.7,bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "3px 8px"),textsize = "15px",direction = "auto")
      )%>%  addLegend(pal = pal, title = map_title, values = map_value, position = "bottomleft", opacity = 2)
  })
  
  #This creates a bar graph that uses the states dataframe
  output$plot <- renderPlot({
    
    filter_data <- state_df() 
    
    filter_data <- filter_data %>% filter(OCC_GROUP == input$plot_occ) %>% 
      filter(STATE == str_to_title(input$plot_state))
    
    if(input$plot_value == "A_MEAN"){
      filter_data <- filter_data 
      if (input$plot_select == "top") { 
        top_str <- "Highest"
        filter_data <- filter_data %>% arrange(A_MEAN)
      } else {
        filter_data <- filter_data %>% arrange(desc(A_MEAN))
        top_str <- "Lowest"
      }
    } else if(input$plot_value == "H_MEAN"){
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
    if(input$plot_value == "TOT_EMP"){
      y_title <- "Total Employees"
    } else if (input$plot_value == "H_MEAN"){
      y_title <- "Hourly Wage"
    } else{
      y_title <- "Annual Salary"
    }
    
    ggplot(data = filter_data) +
      geom_col(mapping = aes_string(
        x = "OCC_TITLE",
        y = input$plot_value
      ), fill = "Pink", alpha = 0.4) + labs(
        title = paste("Top 5 Occupations with the", top_str , y_title, "in", input$plot_state),
        x = "Occupation",
        y = y_title
      ) + theme(
        legend.justification = c("left", "top"),
        axis.text.x = element_text(face="bold", 
                                   size=10, angle=90),
        axis.text.y = element_text(face="bold", 
                                   size=10)
        
      )
  })
  
  output$table <- renderDataTable({
    filter_data <- state_df() %>% filter(OCC_GROUP == input$table_occ) %>% 
      filter(STATE == str_to_title(input$table_state))
    
    filter_data <- filter_data %>% select(STATE, OCC_TITLE, input$table_value)
    
    if(input$table_value == "TOT_EMP"){
      
      if(input$table_select == "top"){
        filter_data <- filter_data %>% arrange(TOT_EMP)
      } else{
        filter_data <- filter_data %>% arrange(desc(TOT_EMP))
      }
    } else if(input$table_value == "A_MEAN"){
      
      if(input$table_select == "top"){
        filter_data <- filter_data %>% arrange(A_MEAN)
      } else{
        filter_data <- filter_data %>% arrange(desc(A_MEAN))
      }
    } else {
      
      if(input$table_select == "top"){
        filter_data <- filter_data %>% arrange(H_MEAN)
      } else{
        filter_data <- filter_data %>% arrange(desc(H_MEAN))
      }
    }
    
    filter_data  %>% head(10)
    
  })
  
  
  
}
