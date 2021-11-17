library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")


#Extract two countries(United State & Japan) our group want to compare
suicide_table1 <- data.frame(
  suicide_rate %>% 
    group_by(age) %>%
    filter(ï..country %in% c("United States", "Japan")) %>%
    filter(year == 2015) %>%
    filter(ï..country == "United States")
)

#Extract the valuable information
suicide_table1 <- subset(suicide_table1, select = -c(country.year : generation))

#Change some column names to become readable
colnames(suicide_table1) [5]<-"suicide_number"
colnames(suicide_table1) [7]<-"the suicide rate in every 100 thousands of the population"

#Sort the dataset in a way that from **the furthest year to the most recent year**
suicide_table1 <- suicide_table1 %>% 
  arrange(year)

#All the data have already rounded so we don't need to change it.

View(suicide_table1)

#Barchart
suicide_sex <-ggplot (data=suicide_table1, aes(x=sex, y=suicide_number)) +
  geom_bar(stat="identity")
suicide_sex

b_p1 <- ggplot(suicide_table1, aes(x="United States", y=suicide_number, fill=sex))+
  geom_bar(width = 1, stat = "identity")
b_p1
pie1 <- b_p1 + coord_polar("y", start=0)
pie1


#Extract two countries(United State & Japan) our group want to compare
suicide_table2 <- data.frame(
  suicide_rate %>% 
    group_by(age) %>%
    filter(ï..country %in% c("United States", "Japan")) %>%
    filter(year == 2015) %>%
    filter(ï..country == "Japan")
)

#Extract the valuable information
suicide_table2 <- subset(suicide_table2, select = -c(country.year : generation))

#Change some column names to become readable
colnames(suicide_table2) [5]<-"suicide_number"
colnames(suicide_table2) [7]<-"the suicide rate in every 100 thousands of the population"

#Sort the dataset in a way that from **the furthest year to the most recent year**
suicide_table2 <- suicide_table2 %>% 
  arrange(year)

#All the data have already rounded so we don't need to change it.

View(suicide_table2)

#Barchart
suicide_sex <-ggplot (data=suicide_table2, aes(x=sex, y=suicide_number)) +
  geom_bar(stat="identity")
suicide_sex

b_p2<- ggplot(suicide_table2, aes(x="Japan", y=suicide_number, fill=sex))+
  geom_bar(width = 1, stat = "identity")
b_p2
pie2 <- b_p2 + coord_polar("y", start=0)
pie2

