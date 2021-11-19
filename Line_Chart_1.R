library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

#Change some column names to become readable
colnames(suicide_rate) [1]<-"country"

#Extract two countries(United State & Japan) our group want to compare in the year 2015
suicide_table <- data.frame(suicide_rate %>% 
    filter(country %in% c("United States", "Japan")))

#Change more column names to become readable
colnames(suicide_table) [5]<-"the_number_of_suicides"
colnames(suicide_table) [7]<-"the suicide rate in every 100k of the population"

#Extract the valuable information
suicide_table <- subset(suicide_table, select = -c(country.year : generation))

#Sort the dataset in a way that from **the furthest year to the most recent year**
suicide_table <- suicide_table %>% 
  arrange(year)

#All the data have already rounded so we don't need to change it.

View(suicide_table)

#Create a line graph with U.S. and Japan suicide rates in male aged 25-34 years over time.

young_males_table <- data.frame(suicide_rate %>%
                         filter(country %in% c("United States", "Japan")) %>%
                         filter(sex == "male", age == "25-34 years"))
                       
ggplot(young_males_table, aes(x = year, y = suicides_no)) +
  geom_line(aes(col=country)) + labs(title = "Suicide Trend Over Time For Male",
                                     x = "Year",
                                     y = "Numbers of Suicides",
                                    colour = "Country's Name") +
  theme(plot.title = element_text(size=9))
