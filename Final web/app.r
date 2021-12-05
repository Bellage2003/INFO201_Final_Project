library(shiny)
library("dplyr")
library("plotly")

# Chart3 Data ----
#1
suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")
c3_dfj <- suicide_rate %>%
  filter(ï..country %in% c("Japan")) %>%
  filter(year == 2015) %>%
  select(ï..country, year, age, sex, suicides_no)
#2
c3_dfu <- suicide_rate %>%
  filter(ï..country %in% c("United States")) %>%
  filter(year == 2015) %>%
  select(ï..country, year, age, sex, suicides_no)


# Create Pages ----
intro_page <- tabPanel(
  "Introduction"
)
#Chart1
chart_1 <- tabPanel(
  "Chart 1"

)


#Chart2
chart_2 <- tabPanel(
  "Chart 2"
)


#Chart3
chart_3 <- tabPanel(
  "Chart 3",
  sidebarLayout(
    sidebarPanel(
      h1("In Japan..."),
      h3("Explore the suicide number differences between male and female in 2015"),
      selectInput(
        inputId = "select1",
        label = "Choose one sex to explore",
        choices = unique(c3_dfj$sex),
        multiple = TRUE
      ),
      h1("In United States..."),
      h3("Explore the suicide number differences between male and female in 2015"),
      
      selectInput(
        inputId = "select2",
        label = "Choose one sex to explore",
        choices = unique(c3_dfu$sex),
        multiple = TRUE
      ),
    ),
    mainPanel(
      h1("Suicide Number Difference between male and female in Japan and in United States"),
      plotlyOutput("barp1"),
      
      plotlyOutput("barp2")
    )
  )
)

conclusion_page <- tabPanel(
  "Conclusion"
)




# Combine pages, Create UI
ui <- (
  fluidPage(
  navbarPage(
    "Comparison About Suicide Rates in Japan and United States",
    intro_page,
    chart_1,
    chart_2,
    chart_3,
    conclusion_page
  )
)
)





# Define server logic ---- 
server <- function(input, output){
  
#chart3
  output$barp1 <- renderPlotly({
    plot_ly(c3_dfj, x = ~sex, y = ~suicides_no, values = ~suicides_no, color = ~sex) %>%
      filter(sex %in% input$select1) %>%
      layout(title = "Suicide Numbers Difference between Male and Female in Japan in 2015", yaxis = list(title = 'suicide numbers')) %>%
      add_bars()
  })
  
  output$barp2 <- renderPlotly({
    plot_ly(c3_dfu, x = ~sex, y = ~suicides_no, values = ~suicides_no, color = ~sex) %>%
      filter(sex %in% input$select2) %>%
      layout(title = "Suicide Numbers Difference between Male and Female in United States in 2015", yaxis = list(title = 'suicide numbers')) %>%
      add_bars()
  })
  
}




# Run the app ----
shinyApp(ui = ui, server = server)
  
  
  
  
  