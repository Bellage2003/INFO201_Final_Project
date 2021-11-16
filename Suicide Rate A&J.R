library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

View(suicide_rate)

suicide_table <- data.frame(
  suicide_rate %>% 
  filter(country %in% c("United States", "Japan"))
)