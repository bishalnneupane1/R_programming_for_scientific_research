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
