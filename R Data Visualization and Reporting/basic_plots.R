#load trees data from dataset libarary
library(datasets)
tr<-trees 
head(tr)


# for histogram
hist(tr$Volume, col = 'darkred',main="Histogram", xlab="Volume")

#for barplot
barplot(tr$Height, names.arg=c(1:31), col='darkgreen')

#for boxplot
boxplot(tr$Height, col = 'darkblue', xlab='Height',ylab='Height (m)')

boxplot(tr, col='darkorange')


# for scatterplot
plot(tr$Height, tr$Volume, col='#FDAE61', pch=19, xlab='Height', ylab=
       'Volume', main='Scatter Plot')

#more refined scatter plot
plot(tr$Volume,tr$Height, col = factor(tr$Girth[1:6]), pch=19,
     xlab='Volume', ylab='Height', main="More Refined Scatter Plot")

# Legend
legend("topleft",
       legend = levels(factor(tr$Girth[1:6])),
       pch = 19,
       col = factor(levels(factor(tr$Girth[1:6]))))

#line graph
plot(tr$Height,type = "o",col = "darkgreen", xlab = "Day", ylab = "Value", 
     main = "Line Graph", ylim = c(0, 85), pch=18, lty=6)
lines(tr$Volume, type = "o", col = "darkblue", pch=19, lty=2)

#pie chart
piedata <-c(79.814, 0.023, 16.21, 1.636, 2.318)
class <- c("Barren Land", "Water", "Built-up Area", "Tree", "Grass")
pct <- round(piedata/sum(piedata)*100, 2)
class <- paste(class, pct)
class <- paste(class,"%",sep="")
pie(piedata,labels = class, col=rainbow(5), main="LULC Types in 2013")
