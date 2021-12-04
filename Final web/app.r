library(shiny)
library(plotly)

source("Suicide_Table.R")

intro_page <- tabPanel(
  "Introduction"
)

chart_1 <- tabPanel(
  "Chart 1"

)

chart_2 <- tabPanel(
  "Chart 2"
)

chart_3 <- tabPanel(
  "Chart 3"
)

conclusion_page <- tabPanel(
  "Conclusion"
)

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
  
server <- function(input, output){
  
  
}


shinyApp(ui = ui, server = server)
  
  
  
  
  