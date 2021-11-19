library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")


#Extract two countries(United State & Japan) our group want to compare
suicide_table <- data.frame(
  suicide_rate %>% 
    filter(country %in% c("United States", "Japan"))
    
)

#Extract the valuable information
suicide_table <- subset(suicide_table, select = -c(suicides.100k.pop : generation))

#Change some column names to become readable
colnames(suicide_table) [5]<-"the number of suicide"

#Sort the dataset in a way that from **the furthest year to the most recent year**
suicide_table <- suicide_table %>% 
  arrange(year)

#All the data have already rounded so we don't need to change it.

View(suicide_table)
