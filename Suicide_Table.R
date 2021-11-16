library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")
View(suicide_rate)

#Extract two countries(United State & Japan) our group want to compare
suicide_table <- data.frame(
  suicide_rate %>% 
    filter(country %in% c("United States", "Japan"))
    
)
View(suicide_table)

#Extract the valuable information
suicide_table <- subset(suicide_table, select = -c(country.year : generation))

#Change some column names to become readable
colnames(suicide_table) [5]<-"the number of suicide"
colnames(suicide_table) [7]<-"the suicide rate in every 100 thousands of the population"

#Sort the dataset in a way that from **the furthest year to the most recent year**
suicide_table <- suicide_table %>% 
  arrange(year)

#All the data have already rounded so we don't need to change it.