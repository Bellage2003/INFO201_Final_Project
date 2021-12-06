library("shiny")
library("dplyr")
library("plotly")
library("tidyverse")

# Chart Data----

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

colnames(suicide_rate) [1]<-"country"

suicide_dataset <- data.frame(
  suicide_rate %>% 
    filter(country %in% c("United States", "Japan"))  %>% 
    filter(year == "2015")
  
)

# Chart 1 Data ----
young_males_table <- data.frame(suicide_rate %>%
                                  filter(country %in% c("United States", "Japan")) %>%
                                  filter(sex == "male", age == "25-34 years"))

# Chart 3 Data ----
#1
c3_dfj <- suicide_rate %>%
  filter(country %in% c("Japan")) %>%
  filter(year == 2015) %>%
  select(country, year, age, sex, suicides_no)
#2
c3_dfu <- suicide_rate %>%
  filter(country %in% c("United States")) %>%
  filter(year == 2015) %>%
  select(country, year, age, sex, suicides_no)


# Create Pages ----

intro_page <- tabPanel(
  "Introduction"
)
#Chart1
chart_1 <- tabPanel(
  "Chart 1",
  h1("In the United States and Japan..."),
  h3("Select which year you'd like to see the number of suicides in men aged 25-34"),
  fluidPage(
    radioButtons(
      inputId = "country",
      label = "Select a country",
      choices = unique(young_males_table$country)
    ),
  selectInput(
    inputId = "yr",
    label = "Select a year",
    choices = unique(young_males_table$year)
   ),
  plotlyOutput("radar")
))

#Chart2
chart_2 <- tabPanel(
  "Chart 2",
  h3("Firstly, Make Your Choices!"),
  
  fluidPage(tags$head(
 
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
      body {
        background-color: #c9c893;
        color: black;
      }
      h2 {
        font-family: 'Yusei Magic', sans-serif;
      }
      .shiny-input-container {
        color: #474747;
      }"))
  ),
    checkboxGroupInput(
      inputId = "countrybox",
      label = strong("Select the country(s) you want to show"),
      choices = unique(suicide_dataset$country)
    ),
    selectInput(
      inputId = "sexbox",
      label = strong("Select the gender you want to show"),
      choices = unique(suicide_dataset$sex),
      multiple = TRUE
    ),
    
    h3("Here is my stacked bar chart! "),
    plotlyOutput(outputId = "barchart")
    
  )
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
 
#chart1   

  
  output$radar <- renderPlotly({
    plot_ly(young_males_table, x=~year, y = ~suicides_no, color = ~country, type = "scatter",
            text = ~paste("Numbers of Suicides: ", suicides_no,
                          "Country: ", country, "Year: ", year)) %>% 
      filter(year %in% input$yr) %>% 
      filter(country %in% input$country) %>% 
      add_lines() %>% 
    add_annotations() %>% 
      layout(title = "Suicide Numbers in Men Aged 24-35 in the U.S. and Japan", yaxis = list(title = "Suicide numbers")) 
  })
  
#chart2
  output$barchart <- renderPlotly({
    plot_ly(suicide_dataset, x= ~age, y= ~suicides_no, 
            color = ~country, type = "bar",
            text = ~paste("Numbers of Suicides: ", suicides_no,
                          "Gender: ", sex
                          ) ) %>% 
      filter(country %in% input$countrybox) %>% 
      filter(sex %in% input$sexbox) %>% 
      add_annotations(font = list(
                                  size = 9)) %>% 
      layout(title = "<b> Comparing Suicide Numbers in Age Groups of Two Countries In 2015 <b>", 
             xaxis = list(title = "Age Groups"), yaxis = list(title = "Numbers of Suicides"),
             legend = list(title = list(text = "<b> Countries <b>")),
             barmode = "stack",
             uniformtext=list(minsize=12, mode="hide"))

    
  })
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
  
  
  
  
  