library(ggplot2)
library(tidyverse)
library(dplyr)

suicide_rate <- read.csv("https://raw.githubusercontent.com/Bellage2003/INFO201_Final_Project/main/Data/Suicide%20Rates%20Overview.csv")

suicide_table <- data.frame(
  suicide_rate %>% 
    filter(country %in% c("United States", "Japan"))
  
)

suicide_table <- subset(suicide_table, select = -c(suicides.100k.pop : generation))


colnames(suicide_table) [5]<-"the number of suicide"





#1
total_suicide_female_us_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "female") %>% filter(country == "United States") %>% summarise(sum(`the number of suicide`))

#This is the total number of suicides (10,199) for the most recent years for this data set,
#I feel that this is pertinent information from the data set because it is most recent numbers as well
#as relates to all of the members in our group since we are all women and it's important to acknowledge these numbers.

total_pop_female_us_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "female") %>% filter(country == "United States") %>% summarise(sum(population))

#This value (151,958,511) is the total population for all age ranges of females in the US in 2015.
#This information is pertinent because it will be used to show the percentage of females that
#committed in suicide in 2015 for the U.S.

us_suicide_percentage_2015 <- pull(total_suicide_female_us_2015 / total_pop_female_us_2015 * 100)
us_suicide_percentage_2015
#The percentage of women that committed suicide in 2015 in the U.S. is (0.00671%)



#2
total_suicide_female_japan_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "female") %>% filter(country == "Japan") %>% summarise(sum(`the number of suicide`))

#This is the total number of suicides (6,946) for the most recent years for this data set.
#Again this is pertinent to our group as we are all females, but I think it is important to also
#acknowledge the difference in numbers between the two countries for comparison.

total_pop_female_japan_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "female") %>% filter(country == "Japan") %>% summarise(sum(population))

#The value for Japan is (61,881,634) and is important because again will be used to show the difference in percentages between
#the U.S. and Japan.

japan_suicide_percentage_2015 <- pull(total_suicide_female_japan_2015 / total_pop_female_japan_2015 * 100)
japan_suicide_percentage_2015
#The percentage of women that committed suicide in Japan in 2015 is (0.0112%) With both of these
#values in mind, these numbers are important because it seems as though Japan had less suicides 
#if looking at the actual number, but when compared percentage wise for # of suicides to population,
#we are able to see that Japan actually had a higher percentage of the women population that committed
#suicide in 2015.



#3
total_suicide_female_us_1985 <- suicide_table %>%
  filter(year == 1985) %>% filter(sex == "female") %>% filter(country == "United States") %>% summarise(sum(`the number of suicide`))
# total suicides in 1985 in U.S.: (6,308)

total_pop_female_us_1985 <- suicide_table %>%
  filter(year == 1985) %>% filter(sex == "female") %>% filter(country == "United States") %>% summarise(sum(population))
# total population of women in 1985 in U.S.: (113,781,000)

us_suicide_percentage_1985 <- pull(total_suicide_female_us_1985 / total_pop_female_us_1985 * 100)
us_suicide_percentage_1985
# The percentage of suicides for 1985 in the U.S.: (0.00554%)



#4

total_suicide_female_japan_1985 <- suicide_table %>%
  filter(year == 1985) %>% filter(sex == "female") %>% filter(country == "Japan") %>% summarise(sum(`the number of suicide`))
# total suicides in 1985 in Japan: (8,012)

total_pop_female_japan_1985 <- suicide_table %>%
  filter(year == 1985) %>% filter(sex == "female") %>% filter(country == "Japan") %>% summarise(sum(population))
# total population of women in 1985 in Japan: (57,570,400)

japan_suicide_percentage_1985 <- pull(total_suicide_female_japan_1985 / total_pop_female_japan_1985 * 100)
japan_suicide_percentage_1985
# The percentage of suicides for 1985 in Japan: (0.0139%)


#5
total_suicide_male_us_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "male") %>% filter(country == "United States") %>% summarise(sum(`the number of suicide`))

total_pop_male_us_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "male") %>% filter(country == "United States") %>% summarise(sum(population))

male_us_suicide_percentage_2015 <- pull(total_suicide_male_us_2015 / total_pop_male_us_2015 * 100)
male_us_suicide_percentage_2015

total_suicide_male_japan_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "male") %>% filter(country == "Japan") %>% summarise(sum(`the number of suicide`))

total_pop_male_japan_2015 <- suicide_table %>%
  filter(year == 2015) %>% filter(sex == "male") %>% filter(country == "Japan") %>% summarise(sum(population))

male_japan_suicide_percentage_2015 <- pull(total_suicide_male_japan_2015 / total_pop_male_japan_2015 * 100)
male_japan_suicide_percentage_2015
# The values for U.S. + Japan that I pulled are the recent percentages for males in the U.S. and Japan. The percentages for the U.S.
# and Japan are (0.0229%) + (0.0276%) respectively.


