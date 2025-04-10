#install.packages('psych', 'Hmisc', 'janitor')

#calling library
library(psych)
library(Hmisc)
library(janitor)

#read csv data
d <- read.csv('columbus.csv')
d

#create data frame
dt<- data.frame(x=c(1,3,5), y=c(2,4,6))

#clean column names
d <- d %>%
  clean_names(case = "title") # only the first letter of names will be in capital letter
d <- clean_names(d)

View(d)

#### common descriptive functions

range(d$crime)

median(d$crime)

min(d$crime)

max(d$crime)

mean(d$evi)

mean(d$evi, na.rm=T) # to ignore the missing (NA) values

#standard deviation
sd(dt$x)

sd(d$crime, na.rm = T)

quantile(d$crime, probs = 0.025) # 2.5%

quantile(d$crime, probs = 0.25)  # 25%

#confidence intervals
mean(d$crime+1.96*sd(d$crime)/sqrt(200))

mean(d$crime)-1.96*sd(d$crime)/sqrt(200)

