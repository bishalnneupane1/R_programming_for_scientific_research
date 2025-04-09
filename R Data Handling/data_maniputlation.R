#install.packages
# tidyverse, dplyr, furniture

#loading library
library(tidyverse)
library(furniture)
library(dplyr)

## open csv data
dt <- read.csv('columbus.csv')
dt

view(dt)

## change name of columns from capital letter to small letter
names(dt) <- tolower(names(dt))
view(dt)

# piping , grouping and sumarizing
dt %>% head(5) # View fist five columns

dt %>%
  group_by(ew) %>%
  summarize(mean_crime = mean(crime, na.rm=T))
# A tibble: 2 x 2
# ew           mean_crime
# <int>      <dbl>
#   0          303.
#   1          295.

#selecting variable
selected_dt <- dt %>%
  select(neig, evi, al, crime)
View(selected_dt)

#only choose observations that we need
filtered_dt<-dt %>%
  filter(ew ==0) # only choose 'ew' equal to 0
View(filtered_dt)

filtered_dt1 <- dt %>%
  filter(ew==0 & open<2) # only choose 'ew' equal to 0 and 'open' smaller than 2
View(filtered_dt1)

filtered_dt2<-dt %>%
  filter(ew==0 | open<2) # "&" and "|" mean both condition

#select and filter 
selected_filtered_dt <- dt%>%
  select(neig, evi, al,ew,  crime)%>%
  filter(ew==1 & evi >0.3)
View(selected_filtered_dt)

#mlibrary(dplyr)
df <- tibble(x = c(1,3,5), y =c(2, 4, 6))
df %>% mutate(z = y / x)
df %>% mutate(z = x * y, .after = x)

df %>%
  select(x, y) %>%
  mutate(
    z = y * 2,
    z_squared = z * z
  )


# reshaping
library(furniture)

