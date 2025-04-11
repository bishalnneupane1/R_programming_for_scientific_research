#create data
group_a<- c(86, 97, 99, 100, 101, 103, 106, 110, 112, 113)
group_b<- c(50, 100, 98, 95, 90, 105, 110, 95, 100, 112)

#one sample t test
t.test(group_a)

#indepdendent (unparied) t- test
# This test is used for an independent data set that is identically distributed,
tt<-t.test(group_a, group_b)
tt
t.test(x=c(2, 4, 6), y = c(2, 4, 6))
t.test(x=c(-2, -4, -6), y = c(2,4,6))
t.test(x=c(2, 4, 6), y = c(4, 8, 12))

# paired -t test
# the paired t test is used for equal pairs of similar units
# blood pressure before and after

df <- data.frame(Name = c("Jon", "Ali", "Aviar", "Didar", "Shilan", "Tom"),
                 first_exam = c(70, 41, 85, 58, 46, 90),
                 second_exam = c(45, 80, 55, 95, 85, 80)
)

t.test(df$first_exam, df$second_exam, paired=TRUE)

# extracting p -value and the value of t=tstatic
names(tt)
t.test(group_a, group_b)$p.value 

tt$p.value
tt$statistic 
# or 
tt[['statistic']]

#If the p-value is greater than 0.05, it indicates that 
# the means of the groups of data are not significantly 
# different.