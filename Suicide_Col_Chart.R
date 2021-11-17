library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

suicide_table <- data.frame(
  suicide_rate %>% 
    filter(country %in% c("United States", "Japan")) %>% 
    filter(year == "2015") %>% 
    mutate(age = word(age, 1, -2)) 
  
)


suicide_table <- subset(suicide_table, select = -c(country.year : generation))

#Because we want to compare the numbers in different age groups in two countird, so I use 
#geom_col to make the chart.

col_chart <- ggplot(suicide_table, aes(x = age , y = suicides_no, fill = country)) +
  geom_col() + labs(title = "Comparing Suicide Numbers in Age Groups of Two Countries in 2015",
                                                x = "Age Groups of People", 
                                                y = "Numbers of Suicides"
                                              )  +
  theme(plot.title = element_text(size=9)) +
  scale_fill_discrete(name = "Country's name")

col_chart


