about <-  tabPanel(
  "About", tags$section(
    h1("About this project", align = "center"),
    h2("AE-4 Team members"),
    h3(id = "names","Jacinda Eng, Kelly Tran Ho, Yizhen(Sarah) Jin, Peerapong Saksommon"),
    br(),
    p("These analysis showed the areas of focus that society needs to be aware of and address. 
      As shown on gender page, there are still jobs with major gap in the number of female and male workers. 
      The stereotype that women are not suited for labor-intensive jobs needs to be broken and treatment towards women in the more 
      male-dominated occupations must to be improved. This will help better balance the number of workers in the natural resources
      and construction field. Graph shows that even when there are jobs that have more female workers, the gap is not as 
      significant as to when the occupation has more male workers. There are also obvious similarities between the jobs that have more 
      of one gender employees. Therefore, society should continue to encourage women not only to enter the workforce, but to enter fields 
      that are more heavily male-dominated. The pie chart shows the need to increase the level of race diversity in all occupations. More 
      diversity in the workplace brings in a variety of perspectives and experiences which can greatly enhance a project or task."),
    br(),
    p("We used a lot of great data sets in working on this project:"),
    uiOutput("data1"),
    uiOutput("data2"),
    uiOutput("data3"),
    uiOutput("data4")
    )
  )
