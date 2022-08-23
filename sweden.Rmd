---
title: "Sweden Marriages and Divorces"
output: github_document
date: "2022-08-22"

---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
setwd("C:/Users/badrn/Downloads/sweden")
load(file = "swedendirectory.RData")
```

## Three Levels of Analysis of Sweden's Marriages and Divorces

The goal of this analysis is to summarize , analyze , and identify trends in Marriages and Divorces in Sweden from 2000 - 2020

I'll First Start from the Total Divorces and Marriages in all of Sweden ,and then move to NUTS-2 .

### For Marriages and Divroces in Sweden (2000 - 2021)

```{r}
head(Total)
summary(Total)

```
```{r}
plot1
```


### In 2021 there were 38895 Marriages and 23467 Divorces


## Now for the  NUTS-2 : 

### For Marriages we have :
```{r}
Marriages2

summary(Marriages2)


plot2marriage
```


### For Divorces we Have :

```{r}
Divorces2

summary(Divorces2)

plot2divorce
```


## Now we'll plot our data Regionally :

### For Regional Marriage we have :

```{r}
Marriages2_2021
marriage_map_plot_2021
```

```{r}
Divorces2_2021
divorce_map_plot_2021
```


## Now For NUTS-3 :

### For Marriages : 

```{r}
Marriages_NUTS_3_cleaned

Marriage_nuts3_plot
```

### For Divorces :

```{r}
Divorces_NUTS_3_cleaned

Divorces_NUTS_3_plot
```



## That's intersting 
### Now lets figure out the ratio of the divorces in marriages

```{r}
Total

total_ratio
```

## In Sweden the Divorce rate is 60 % (2021) !! 







# What about the Divorace rate in Region ? 

## In NUTS-2 :

### Divorce rate :

```{r}


Divorce_rate_NUTS2_plot
```


## In NUTS-3 : 

### Divorce Rate : 

```{r}


Divorce_rate_NUTS3
```


## Data Source : Sweden Statistics
## Analysis by : Mohamad Nasher
