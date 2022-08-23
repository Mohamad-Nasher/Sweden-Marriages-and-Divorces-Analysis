## Libs 

library(tidyverse)
library(openxlsx)
library(lubridate)

## Data Loading and cleaning

data = read.xlsx("Divorces.xlsx" , fillMergedCells = TRUE)

data1 = pivot_longer(data , cols = 3:25 , names_to = "Year" , values_to = "Number")

## Changing the format of the date


data$Month = str_replace_all(data$Month , "January", 01-01)
data1$Month = str_replace_all(data1$Month , "February", "02-01")
data1$Month = str_replace_all(data1$Month , "March", "03-01")
data1$Month = str_replace_all(data1$Month , "April", "04-01")
data1$Month = str_replace_all(data1$Month , "May", "05-01")
data1$Month = str_replace_all(data1$Month , "June", "06-01")
data1$Month = str_replace_all(data1$Month , "July", "07-01")
data1$Month = str_replace_all(data1$Month , "August", "08-01")
data1$Month = str_replace_all(data1$Month , "September", "09-01")
data1$Month = str_replace_all(data1$Month , "October", "10-01") 
data1$Month = str_replace_all(data1$Month , "November", "11-01")
data1$Month = str_replace_all(data1$Month , "December", "12-01")

data1 = data1 %>% mutate(date = paste(Year , Month , sep = "-"))

data1 = data1 %>% mutate(date = ymd(date))

Divorces = data1 %>% select(Region , date , Number)

## Remove values from June to Decmeber in 2022

Divorces = Divorces %>% filter(Number > 0)




