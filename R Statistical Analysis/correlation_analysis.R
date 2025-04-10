#read csv
df <- read.csv('LAI_factors.csv')
df


#using the cor() function
cor(df$LAI_India, df$LST_India, method="pearson")

#using the cov() function
cov(df$LAI_India, df$LST_India)  #covariance

### pearson correlation coefficient(r)
cor.test(df$LAI_India, df$LST_India, method = "pearson")

#In the above output:
  
#  t is the t-test statistic value (t = -2.1809),
#df is the degrees of freedom (df = 14),
#p-value is the significance level of the t-test (p-value = 0.04674).
#conf.int is the confidence interval of the correlation coefficient at 95% (conf.int = [-0.79966707, -0.01049536]);
#sample estimates is the correlation coefficient (cor = -0.5035808).


#spearman's rank correlation coefficient(rho)
cor.test(df$LAI_India, df$LST_India, method = "spearman")


### kendall rank correlation coefficient(tau)
#kendall's tau is same as pearsons' and spearman's rho
