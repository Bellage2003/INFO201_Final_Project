library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

suicide_table1 <- data.frame(
  suicide_rate %>% 
    group_by(age) %>%
    filter(ï..country %in% c("United States", "Japan")) %>%
    filter(year == 2015) %>%
    filter(ï..country == "United States")
)

suicide_table1 <- subset(suicide_table1, select = -c(country.year : generation))

colnames(suicide_table1) [5]<-"suicide_number"
colnames(suicide_table1) [7]<-"the suicide rate in every 100 thousands of the population"

suicide_table1 <- suicide_table1 %>% 
  arrange(year)

View(suicide_table1)

#piechart1
suicide_sex <-ggplot (data=suicide_table1, aes(x=sex, y=suicide_number)) +
  geom_bar(stat="identity")
suicide_sex

b_p1 <- ggplot(suicide_table1, aes(x="United States", y=suicide_number, fill=sex))+
  geom_bar(width = 1, stat = "identity")
b_p1
pie1 <- b_p1 + coord_polar("y", start=0)
pie1

suicide_table2 <- data.frame(
  suicide_rate %>% 
    group_by(age) %>%
    filter(ï..country %in% c("United States", "Japan")) %>%
    filter(year == 2015) %>%
    filter(ï..country == "Japan")
)

suicide_table2 <- subset(suicide_table2, select = -c(country.year : generation))

colnames(suicide_table2) [5]<-"suicide_number"
colnames(suicide_table2) [7]<-"the suicide rate in every 100 thousands of the population"

suicide_table2 <- suicide_table2 %>% 
  arrange(year)

View(suicide_table2)

#piechart2
suicide_sex <-ggplot (data=suicide_table2, aes(x=sex, y=suicide_number)) +
  geom_bar(stat="identity")
suicide_sex

b_p2<- ggplot(suicide_table2, aes(x="Japan", y=suicide_number, fill=sex))+
  geom_bar(width = 1, stat = "identity")
b_p2
pie2 <- b_p2 + coord_polar("y", start=0)
pie2

