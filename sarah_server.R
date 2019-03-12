library('geojson')
library("geojsonio")
library("leaflet")
library("readxl")
library("dplyr")
library(tidyr)
library(ggplot2)


states <- geojson_read("dataset/us-states.json", what = "sp")
gdp_2017  = read_xlsx("dataset/qgdpstate0219.xlsx")

sarah_server <- function(input, output) {
  # map
  output$gdpMap <- renderLeaflet({
    colnames(gdp_2017) = letters[1:10]
    gdp = gdp_2017[gdp_2017$a %in% state.name,] %>% 
      select(a,b) %>% 
      rename(
        "state" = a,
        "gdp_2017" = b
      )
    
    left_over  = data.frame(state = c("District of Columnbia","Puerto Rico"), gdp_2017 = c(0,0))
    gdp = rbind(gdp,left_over)
    levels = states$NAME
    rearranged_gdp <- as.data.frame(gdp %>% mutate(
      state = factor(state, levels = levels)) %>% 
        arrange(state)
    )
    states@data = states@data %>% mutate(gdp = rearranged_gdp$gdp_2017)
    
    bins <- seq(-2,5,1)
    pal <- colorBin(palette = "RdYlGn", domain = states@data$gdp, bins = bins)
    
    leaflet(states) %>% 
      addTiles() %>% 
      setView(-97,39, zoom = 3) %>%
      addPolygons(
        fillColor = ~pal(gdp),
        weight = 1,
        dashArray = "3",
        color = "black",
        fillOpacity = 2,
        highlight = highlightOptions(
          weight = 5,
          color = "#999",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")
      ) %>%  addLegend(
        pal = pal,
        title = "Percent of GDP Growth (2017)",
        values = gdp,
        labFormat = labelFormat(suffix = "%", between = " to "),
        position = "bottomleft",
        opacity = 2)
    
  })
  
  # Washington difference 5 jobs
  output$waDiff <- renderPlot({
    job <- head( national_vs_states_df %>%
                   mutate(diff = washington_hour_mean - national_hour_mean) %>%
                   arrange(desc(diff)) %>% 
                   select(
                     OCC_TITLE, washington_hour_mean, national_hour_mean), 5)
    job_gather <- job %>% 
      gather(key = state,
             value = wage,
             -OCC_TITLE)
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
        # axis.text.x = element_text(face="bold", 
        #                            size=8, angle=90),
        # axis.text.y = element_text(face="bold", 
        #                            size=8)
      )
  })
  
  # About links
  output$data1 <- renderUI({
    tagList("- ", a("Labor Force Statistics from the Current Population", href = "https://www.bls.gov/cps/cpsaat39.htm"))
  })
  # About links
  output$data2 <- renderUI({
    tagList("- ", a("National Occupational wages and employment dataset", href = "https://www.bls.gov/oes/current/oes_nat.htm?fbclid=IwAR1bsqWqpedgsKlPKyt-FVu8KBPmyARXdAZL-B7lt0_CQDXU-yBER4l8AlM"))
  })
  # About links
  output$data3 <- renderUI({
    tagList("- ", a("States Occupational wages and employment dataset", href = "https://www.bls.gov/oes/current/oessrcst.htm?fbclid=IwAR3S4-BpXYofas6If42fOReztuCYdWgVq24MCXFLS7KU6a0BrJk7h7Zg5bQ"))
  })
  
  # Connecticut difference 5 jobs
  output$ctDiff <- renderPlot({
    job <- national_vs_states_df %>%
      mutate(diff = connecticut_hour_mean - national_hour_mean) %>%
      arrange(desc(diff)) %>% 
      select(
        OCC_TITLE, connecticut_hour_mean, national_hour_mean)
    
    job_gather <- job %>% 
      head(5) %>%
      gather(key = state,
             value = wage,
             -OCC_TITLE)
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
    #+ theme(
      #   legend.justification = c("left", "top"),
      #   axis.text.x = element_text(face="bold", 
      #                              size=8, angle=90),
      #   axis.text.y = element_text(face="bold", 
      #                              size=8)
      #)
  })
  #Question: what job has the highest number of employees in Washington
  output$employmentWA <- renderPlot({
    job <- national_vs_states_df %>%
      filter(OCC_GROUP == "detailed") %>%
      arrange(desc(washington_tot_emp)) %>% 
      select(OCC_TITLE, washington_tot_emp, washington_hour_mean)
    ggplot(data = head(job, 5))+
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = washington_tot_emp
      ), position = "dodge") +
     labs(
        title = "Top 5 Employment Occupations in Washington",
        x = "Occupation",
        y = "Employment number",
        color = "State Data"
      )
    # + theme(
    #     axis.text.x = element_text(face="bold", 
    #                                size=6, angle=90),
    #     axis.text.y = element_text(face="bold", 
    #                                size=6)
    #   )
  })
  output$employmentCT <- renderPlot({
    job <- national_vs_states_df %>%
      filter(OCC_GROUP == "detailed") %>%
      arrange(desc(connecticut_tot_emp)) %>% 
      select(OCC_TITLE, connecticut_tot_emp, connecticut_hour_mean)
    ggplot(data = head(job, 5))+
      geom_col(mapping = aes(
        x = OCC_TITLE,
        y = connecticut_tot_emp
      ), position = "dodge") +
      labs(
        title = "Top 5 Employment Occupations in Connecticut",
        x = "Occupation",
        y = "Employment number",
        color = "State Data"
      # )+ theme(
      #   axis.text.x = element_text(face="bold", 
      #                              size=6, angle=90),
      #   axis.text.y = element_text(face="bold", 
      #                              size=6)
      )
  })
 
}