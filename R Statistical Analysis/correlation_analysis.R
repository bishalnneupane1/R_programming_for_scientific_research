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
cor.test(df$LAI_India, df$LST_India, method = "kendall")


### extract correlation coefficient
pe <- cor.test(df$LAI_India, df$LST_India, method = "pearson")
pe
#extract the p value
pe$p.value


#extract the (r) correlation coefficient
pe$estimate

spe <- cor.test(df$LAI_India, df$LST_India, method = "spearman")
spe

# extract the p.value
spe$p.value

# extract the (rho) correlation coefficient
spe$estimate


###
ken <- cor.test(df$LAI_India, df$LST_India, method = "kendal")
ken

#extract the p.value
ken$p.value

# extract the (tau) correlation coefficient
ken$estimate


# Interpret correlation coefficient
# -1 indicates a strong negative correlation.
# 0 means that there is no association between the two variables.
# 1 indicates a strong positive correlation.
# Based on the previous tests, a significant negative relationship was found between land surface temperature and LAI vegetation index in India.

#create simple data
# and perform correlations between them

cor.test(c(1,3,5,7), c(1,3,5,7), method="pearson")
cor.test(c(1,3,5,7), c(1,3,5,7), method='spearman')
cor.test(c(1,3,5,7), c(1,3,5,7), method='kendal')
cor.test(c(1,3,5,7), c(1,3,5,1), method="pearson")
cor.test(c(1,3,5,7), c(1,3,5,1), method='spearman')
cor.test(c(1,3,5,7), c(1,3,5,1), method='kendal')

#matrix of correlation with significance levels
library(Hmisc)

rcorr(as.matrix(df), type="pearson") # type can be pearson or spearman
rcorr(as.matrix(df), type='spearman') # data should be matrix

# create data
# IQ score and weekly hours of watching tv
iq<- c(86, 97, 99, 100, 101, 103, 106, 110, 112, 113)
tv<- c(2, 20, 28, 27, 50, 29, 7, 17, 6, 12)

#correlation test
cor.test(iq, tv, method="pearson")
cor.test(iq, tv, method='spearman')
cor.test(iq, tv, method='kendal')
