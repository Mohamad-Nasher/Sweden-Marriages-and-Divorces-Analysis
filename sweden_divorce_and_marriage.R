## Libs 

library(tidyverse)
library(openxlsx)
library(sf)

## Data Import and cleaning

Marriages <-read.xlsx("Sweden-Marriages.xlsx")
Divorces <-read.xlsx("Sweden-Divorces.xlsx")
Marriages <- Marriages %>% rename(marriage = Sweden)
Divorces <- Divorces %>% rename(divorce = Sweden)

total = 

# Filter observations in 2022 since it may skew the data 

Marriages <- Marriages %>% filter(Year != 2022)
Divorces <- Divorces %>% filter(Year != 2022)

## Analysis

Total = inner_join(Divorces , Marriages , by = "Year")

## Plot

plot1 <-ggplot(data = Total , mapping = aes(x = Year , y = divorce)) +
  geom_line( size = 1.25) +
  geom_line(mapping = aes(x = Year , y = marriage)  , size = 1.25) +
  ylim(0 , 70000) +
  theme_minimal()+
  labs(title = "Marriages Vs Divorces" , y = "" , x="") +
  geom_point(x = 2021 , y = 23647,size = 2.5) +
  geom_point(x = 2021 , y = 38895 , size = 2) +
  geom_text(mapping = aes(x = 2021 , 42500 , label = "Marriage")) +
  geom_text(mapping = aes(x = 2021 , y = 19800 , label = "Divorce"))


## NUTS-2 Data 

Marriages2 <- read.xlsx("Marriages-NUTS-2.xlsx")

Divorces2 <- read.xlsx("Divorces-NUTS-2.xlsx")


Marriages2 <- Marriages2 %>% pivot_longer(cols = 2:24 , values_to = "marriage" , names_to = "year")

Divorces2 <- Divorces2 %>% pivot_longer(cols = 2:24 , values_to = "divorce" , names_to = "year")

Marriages2 <- Marriages2 %>% filter(year != 2022)

Divorces2 <- Divorces2 %>% filter(year != 2022)

Marriages2$year <- as.numeric(Marriages2$year)

Divorces2$year <- as.numeric(Divorces2$year)

Total_NUTS2 = inner_join(Marriages2_2021 , Divorces2_2021 , by = c("Region" , "year"))

Total_NUTS2 = Total_NUTS2 %>% mutate(code = str_sub(Region , start = 1 , end = 4))

Total_NUTS2_map = inner_join(swedennuts2_cleaned , Total_NUTS2 , by = "code")

Total_NUTS2_map = Total_NUTS2_map %>% mutate(rate = divorce/marriage)




## These Datasets are for the geom_point

Marriages2_2021 <- Marriages2 %>% filter(year == 2021)
Divorces2_2021 <- Divorces2 %>% filter(year == 2021)
## Plots


plot2marriage <- ggplot(data = Marriages2 , mapping = aes(x = year , y = marriage , color = Region)) +
  geom_line(size = 1.5) +
  labs(title = "Marriages in Sweden " , x = "" , y = "") +
  theme_minimal() + geom_point(data = Marriages2_2021 , mapping = aes(x = year , y = marriage) , size = 2.25) +
  theme(panel.grid.major = element_blank()) + ylim(1,20000)


plot2divorce <-ggplot(data = Divorces2 , mapping = aes(x = year , y = divorce , color = Region)) +
  geom_line(size = 1.5) + labs(title = "Divorces" , x = "" , y = "") +
  geom_point(data = Divorces2_2021 , mapping = aes(x = year , y = divorce , color = Region) , size = 2.25) +
  theme_minimal() + theme(panel.grid.major = element_blank()) + ylim(1,20000)

## Map 

nuts2 <- read_sf("europenuts2.shp")

swedennuts2 <- nuts2 %>% filter(CNTR_CODE == "SE")

## We still have a lot of observations we don't need , so will delete them 

swedennuts2_cleaned = swedennuts2 %>% filter(NUTS_ID == "SE11" |
                                               NUTS_ID == "SE12" |
                                               NUTS_ID == "SE21" |
                                               NUTS_ID == "SE22" |
                                               NUTS_ID == "SE23" |
                                               NUTS_ID == "SE31" |
                                               NUTS_ID == "SE32" |
                                               NUTS_ID == "SE33")

swedennuts2_cleaned = swedennuts2_cleaned %>% rename(code = NUTS_ID)

Marriages2 = Marriages2 %>% mutate(code = str_sub(Region , start = 1 , end = 4))

Divorces2 = Divorces2 %>% mutate(code = str_sub(Region , start = 1 , end = 4))

Marriages_map = inner_join(swedennuts2_cleaned , Marriages2 , by = "code")

Divorces_map = inner_join(swedennuts2_cleaned , Divorces2 , by = "code")

Marriages_map_2021 = Marriages_map %>% filter(year == 2021)

Divorces_map_2021 = Divorces_map %>% filter(year == 2021)




## Plots

marriage_map_plot_2021 <- ggplot() +
  geom_sf(data = Marriages_map_2021 , aes(fill = marriage)) +
  labs(title = "Marriages" , subtitle = "For 2021") +
  theme_minimal()+
  theme(legend.position = "left" ,
        axis.text.x = element_blank(),
        axis.text.y = element_blank()) +
  scale_fill_gradient(low = "#FF3864" , high = "#261447")


divorce_map_plot_2021 <- ggplot() +
  geom_sf(data = Divorces_map_2021 , aes(fill = divorce)) +
  labs(title = "Divorces" , subtitle = "For 2021") +
  theme_minimal()+
  theme(legend.position = "left" ,
        axis.text.x = element_blank(),
        axis.text.y = element_blank()) +
  scale_fill_gradient(low = "#FF3864" , high = "#261447")



### NUTS-3 Data 

Marriages_NUTS_3_cleaned = Marriages_NUTS_3 %>% pivot_longer(cols = 2:23 , names_to = "year" , values_to = "marriage")

Marriages_NUTS_3_cleaned = Marriages_NUTS_3_cleaned %>% select(Region , year , marriage)

Marriages_NUTS_3_cleaned$year = as.numeric(Marriages_NUTS_3_cleaned$year)


Divorces_NUTS_3_cleaned = Divorces_NUTS_3 %>% pivot_longer(cols = 2:23 , names_to = "year" , values_to = "divorce")

Divorces_NUTS_3_cleaned = Divorces_NUTS_3_cleaned %>% select(Region , year , divorce)
Divorces_NUTS_3_cleaned$year = as.numeric(Divorces_NUTS_3_cleaned$year)

## Extracting only NUTS-3 From Sweden NUTS

swedennuts3 = swedennuts2

swedennuts3 = swedennuts3 %>% rename(code = NUTS_ID)

## It's Repetative but I didn't find Sweden NUTS3 so I extracted it by myself


swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE1")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE2")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE3")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE11")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE12")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE21")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE22")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE23")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE31")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE32")
swedennuts3 = swedennuts3 %>% filter(NUTS_ID != "SE33")


Marriages_NUTS_3_cleaned_2021 = Marriages_NUTS_3_cleaned %>% filter(year == 2021)

Divorces_NUTS_3_cleaned_2021 = Divorces_NUTS_3_cleaned %>% filter(year == 2021)

Marriages_NUTS_3_cleaned_2021 = Marriages_NUTS_3_cleaned_2021 %>% mutate(code = str_sub(Region , start = 1 , end = 5))

Divorces_NUTS_3_cleaned_2021 = Divorces_NUTS_3_cleaned_2021 %>% mutate(code = str_sub(Region , start = 1 , end = 5))

Marriages_NUTS3_2021_map <- inner_join(swedennuts3 , Marriages_NUTS_3_cleaned_2021 , by = "code")

Divorces_NUTS_3_map <- inner_join(swedennuts3 , Divorces_NUTS_3_cleaned_2021 , by = "code")


## Plots


Marriage_nuts3_plot <- ggplot() +
  geom_sf(data = Marriages_NUTS3_2021_map , aes(fill = marriage)) +
  labs(title = "Marriages") +
  theme_minimal() +
  theme(legend.position = "left" , axis.text.x = element_blank() , axis.text.y = element_blank()) +
  scale_fill_gradient(low = "#FF3864" , high = "#261447")



Divorces_NUTS_3_plot <-ggplot() +
  geom_sf(data = Divorces_NUTS_3_map , aes(fill = divorce)) +
  labs(title = "Divorces") + theme_minimal() +
  theme(legend.position = "left" , axis.text.x = element_blank() , axis.text.y = element_blank()) +
  scale_fill_gradient(low = "#FF3864" , high = "#261447")


## Divorace to Marriage Ratio 

Total <- Total %>% mutate(Divorace_rate = divorce/marriage)



Total_NUTS3 = inner_join(Divorces_NUTS_3_cleaned_2021 , Marriages_NUTS_3_cleaned_2021 , by = c("Region" , "year" , "code"))

Total_NUTS3 = Total_NUTS3 %>% mutate(rate = divorce/marriage)

Total_NUTS3_map = inner_join(swedennuts3,Total_NUTS3 , by = "code")


