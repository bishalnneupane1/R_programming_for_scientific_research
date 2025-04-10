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

#create a wide data frame
df_wide <- data.frame('ID'=c('a', 'b', 'c', 'd'),
                      'time1'=c(1:4),
                      'time2'=c(3,5,6,9)) # create wide data frame

df_wide
#  ID time1 time2
#1  a     1     3
#2  b     2     5
#3  c     3     6
#4  d     4     9

#convert wide to long
df_long<-long(df_wide,
              c('time1', 'time2'),
              v.names='value')
df_long
#    ID time value
#a.1  a    1     1
#b.1  b    1     2
#c.1  c    1     3
#d.1  d    1     4
#a.2  a    2     3
#b.2  b    2     5
#c.2  c    2     6
#d.2  d    2     9

# convert long to wide
df_wide<-wide(df_long,
              v.names=c('value'),
              timevar='time') # convert long to wide data frame

df_wide
#    ID value.1 value.2
#a.1  a       1       3
#b.1  b       2       5
#c.1  c       3       6
#d.1  d       4       9

### joining(mergining)
df1 <- data.frame(ID=1:3,
                  x1=c('a1', 'a2', 'a3'),
                  stringsAsFactors = F)

df2<- data.frame(ID=2:4,
                 x2 = c('z1', 'z2', 'z3'),
                 stringsAsFactors = F)
df3<- data.frame(ID=3:5,
                 x2=c('a1', 'a2', 'a3'),
                 x3=c('z1', 'z2', 'z3'),
                 stringsAsFactors = F)

### inner_join() merges the variable of both data frames,
### but retains only rows with a shared ID
inner_join(df1, df2, by='ID')

#left_join
left_join(df1, df2, by='ID')

#right_join
right_join(df1, df2, by='ID')

full_join(df1, df2, by='ID') #retains the most data of all the join functions.
semi_join(df1, df2, by='ID') #return all rows from x where there are matching values in y, keeping just columns from x
anti_join(df1, df2, by='ID')#return all rows from x where there are not matching values in y, keeping just columns from x.

#join_multiple_data_frames
full_join(df1, df2, by='ID') %>%
  full_join(.,df3, by='ID') 

# join by multiple columns:
full_join(df2, df3, by=c('ID', 'x2'))

