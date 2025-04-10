#read csv
df <- read.csv('LAI_factors.csv')
df


#using the cor() function
cor(df$LAI_India, df$LST_India, method="pearson")

#using the cov() function
cov(df$LAI_India, df$LST_India)  #covariance

### pearson correlation coefficient(r)
cor.test(df$LAI_India, df$LST_India, method = "pearson")
