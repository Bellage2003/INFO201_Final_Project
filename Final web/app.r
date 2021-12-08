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
  "Introduction",
  h1("A Comparison Between the U.S. and Japan Suicide Rates"),
  p("Our group has been working with a data set that involved mental health in a variety of countries. We have decided to specifically focus on the comparison between the U.S. and Japan.
     In the first chart, the information being shown is a comparison of suicide rates in men ages 25-34 in the U.S. and Japan. The shiny widget that will be used to portray this information is radio buttons.
     In the second chart, the information being shown is a comparison of suicide rates between different genders. The information will be shown through a stacked bar chart and the widget being used for this is select box.
     Lastly, the third chart will show a comparison between indifferent age groups between the U.S. and Japan. The widget that is used to portray this information is select boxes."),
  HTML('<center><img src="https://fodmap-publicsite-us-east-2.s3.amazonaws.com/production/media/images/Mental_Health__IBS__Effectiveness_of_psychologi.original.png" width="400"></center>')
  ,
  
  h3("Exploration with the Data"),
  p("We wanted to explore the data set and what it had to offer in terms of comparison between the U.S. and Japan.
     Both of these countries are known to have competitive societies in different aspects, and we wanted to explore the mental health
     of similarly aged inviduals in both of these countries as well as different age groups above and below. We also wanted to observe the differences
     in mental health within different genders in both countries. Some general questions we wanted answered are: How does the U.S. and Japan suicide rates compare overall? Does the U.S. have higher amounts of suicides? What can we tell from the data points
    when comparing maximums and minimums for specific years, and what can we infer about what was occuring during these time periods?")
  
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
        background-color: #5385ac;
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
  "Conclusion",
  h1("Mental Health in the U.S. and Japan Conclusion"),
  h3("Three Major Takeaways"),
  p("With our dataset, we were able to find information about mental health between the countries compared. In chart 1, the U.S. and Japan had the lowest difference in suicides for men ages 25-34 in
    the year 2005. The difference between U.S. and Japan was 1,204. We are able to gather from this data set that in 2005, Japan had a peak in suicides where the U.S. had lower numbers than years before."),
  p("In chart 2, we are able to see that in 2015, the lowest occurences of suicides happened in the age range of 5-14 years for both male and female. For Japan, both male and female had similar amounts of suicides for the age ranges
    of 35-54, and 55-74 where as in the U.S., we are able to see that the age range of 35-54 had a higher number of suicides than age range of 55-74 in 2015."),
  p("Lastly, in chart 3 we are able to directly compare the rates of the U.S. and Japan directly for male and female suicides. In 2015,
    the charts show similarities between the two countries in that males in both countries have higher suicide numbers than females. Japan had lower overall suicides for 2015 numerically but when comparing the overall population for the
    two countries, it can show that Japan has a higher percentage of suicides for total population."),
  h3("Conclusion"),
  p("Overall, we are able to see that when comparing the U.S. and Japan directly, we are able to see that overall the U.S. has a higher amount of suicides
    when considering the data numerically. It is consistent that men have higher suicide rates in both countries than the data collected for females. With the charts
    listed in previous pages, we are able to see that the number of suicides appear as a reflection where as one country's suicides decrease, the others increase. Due to the limitations of our data,
    we are unable to pull any concrete conclusions as to why these numbers inverse other than inferring that events took place during those years that may have affected
    the U.S. and Japan differently.")
  
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
  
  
  
  
  