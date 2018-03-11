library(ggplot2)
library(car)
library(GGally)
library(tidyverse)
library(mvoutlier)
library(car)
library(outliers)
library(pastecs)
library(moments)
library(corrplot)


#Convert Data to cols separated by semi col in excel 

df <- read.csv("winequality-white.csv")

head(df)

names(df)

#[1] "fixed.acidity"        "volatile.acidity"     "citric.acid"       
#[4] "residual.sugar"       "chlorides"            "free.sulfur.dioxide"
#[7] "total.sulfur.dioxide" "density"              "pH"                 
#[10] "sulphates"            "alcohol"              "quality"  


###########################################
#Univariate and Multivariate Analysis
##########################################



#Set significant digits and get a detailed summary 
options(scipen = 100)
options(digits=2)
dmalesummary <- data.frame(stat.desc(df))

#Let's check what we got
dmalesummary
#as you can see the number of null values for citric acid are 19

#Let's count the na values 
sum(is.na(df))
#0
#If you need NA count Column wise
sapply(df, function(x) sum(is.na(x)))
#If You need NA count of all -
table(is.na(df))

#This I found from stack overflow - elegant way

for (Var in names(df)) {
  missing <- sum(is.na(df[,Var]))
  if (missing > 0) {
    print(c(Var,missing))
  }
}




#Let's move ahead 



#Let's plot qqplot for each col and study measurements which are aberrant 

qqnorm(df$fixed.acidity , main="Normal Q-Q plot for Fixed Acidity")
qqline(df$fixed.acidity, lty = 2, col="red")

qqnorm(df$volatile.acidity , main="Normal Q-Q plot for Volatile Acidity")
qqline(df$volatile.acidity, lty = 2, col="red")

qqnorm(df$citric.acid, main="Normal Q-Q plot for citric acid")
qqline(df$citric.acid, lty = 2, col="red")


qqnorm(df$residual.sugar, main="Normal Q-Q plot for Residual sugar")
qqline(df$residual.sugar, lty = 2, col="red")

qqnorm(df$chlorides, main="Normal Q-Q plot for Chlorides")
qqline(df$chlorides, lty = 2, col="red")

qqnorm(df$free.sulfur.dioxide, main="Normal Q-Q plot for free sulfur dioxide")
qqline(df$free.sulfur.dioxide, lty = 2, col="red")

qqnorm(df$total.sulfur.dioxide, main="Normal Q-Q plot for total sulfur dioxide")
qqline(df$total.sulfur.dioxide, lty = 2, col="red")

qqnorm(df$density, main="Normal Q-Q plot for density")
qqline(df$density, lty = 2, col="red")

qqnorm(df$pH, main="Normal Q-Q plot for ph")
qqline(df$pH, lty = 2, col="red")

qqnorm(df$sulphates, main="Normal Q-Q plot for sulphates")
qqline(df$sulphates, lty = 2, col="red")

qqnorm(df$alcohol, main="Normal Q-Q plot for alcohol")
qqline(df$alcohol, lty = 2, col="red")

qqnorm(df$quality, main="Normal Q-Q plot for quality")
qqline(df$quality, lty = 2, col="red")




#Let's plot histograms for each col and study distributions

hist(df$fixed.acidity)
hist(df$volatile.acidity)
hist(df$citric.acid)
hist(df$residual.sugar)
hist(df$chlorides)
hist(df$free.sulfur.dioxide)
hist(df$total.sulfur.dioxide)
hist(df$density)
hist(df$pH)
hist(df$sulphates)
hist(df$alcohol)
hist(df$quality)


#Test for skewness and kurtosis

#In statistics, skewness is a measure of the asymmetry of the probability distribution of a random variable about its mean. In other words, skewness tells you the amount and direction of skew (departure from horizontal symmetry). The skewness value can be positive or negative, or even undefined. If skewness is 0, the data are perfectly symmetrical, although it is quite unlikely for real-world data. As a general rule of thumb:

#If skewness is less than -1 or greater than 1, the distribution is highly skewed.

#If skewness is between -1 and -0.5 or between 0.5 and 1, the distribution is moderately skewed.

#If skewness is between -0.5 and 0.5, the distribution is approximately symmetric.


for var in names(df)
{
 a<- sapply(df, skewness)
  print(a)
}

#fixed.acidity     volatile.acidity          citric.acid 
#0.65                 1.58                      1.28 
#residual.sugar    chlorides             free.sulfur.dioxide 
#1.08                 5.02                     1.41 
#total.sulfur.dioxide    density                   pH 
#0.39                     0.98                   0.46 
#sulphates              alcohol                 quality 
#0.98                     0.49                     0.16 

#Now write descriptions of each as 
#Fixed acidity is moderately skewed to right or on the positive side



#Kurtosis 
#Kurtosis tells you the height and sharpness of the central peak, relative to that of a standard bell curve.
#If the value is greater than 3  then distribution of the data is leptokurtic

#If the value is less than 3 then distribution of the data is platykurtic



for var in names(df)
{
  b<- sapply(df, kurtosis)
  print(b)
}


#fixed.acidity     volatile.acidity          citric.acid 
#5.2                   8.1                      9.2 
#residual.sugar     chlorides           free.sulfur.dioxide 
#6.5                  40.5                      14.5 
#total.sulfur.dioxide     density                     pH 
#3.6                        12.8                     3.5 
#sulphates            alcohol              quality 
#4.6                     2.3                  3.2 


#Now write descriptions for each as per rules 

#leptokurtic = all except alcohol


#platykurtic = just alcohol




#Perform shapiro test for normality 


sapply(df, shapiro.test)





##Interactive outlier zipping using shapiro 
# Performs a chisquared test for detection of one outlier in a vector. 
#don't use sapply here since we are adding few more parameters here so do it separately 


chisq.out.test(df$fixed.acidity, variance = var(df$fixed.acidity), opposite = FALSE)

chisq.out.test(df$volatile.acidity, variance = var(df$volatile.acidity), opposite = FALSE)

chisq.out.test(df$citric.acid, variance = var(df$citric.acid), opposite = FALSE)

chisq.out.test(df$residual.sugar, variance = var(df$residual.sugar), opposite = FALSE)

chisq.out.test(df$chlorides, variance = var(df$chlorides), opposite = FALSE)

chisq.out.test(df$free.sulfur.dioxide, variance = var(df$free.sulfur.dioxide), opposite = FALSE)

chisq.out.test(df$total.sulfur.dioxide, variance = var(df$total.sulfur.dioxide), opposite = FALSE)

chisq.out.test(df$density, variance = var(df$density), opposite = FALSE)

chisq.out.test(df$pH, variance = var(df$pH), opposite = FALSE)

chisq.out.test(df$sulphates, variance = var(df$sulphates), opposite = FALSE)

chisq.out.test(df$alcohol, variance = var(df$alcohol), opposite = FALSE)

chisq.out.test(df$quality, variance = var(df$quality), opposite = FALSE)

########################################
##############################
##############


#Boxplot method 
#Remember capital B boxplot method is from car package

Boxplot(df$fixed.acidity, col = rgb(0,0,1,0.5))


#old method boxplot
boxplot(df$fixed.acidity)

summary(df$fixed.acidity)

bm <- 7.3 + 1.5 * IQR(df$fixed.acidity)
bm
#8.8 Anything above this value is an outlier

#wait we also have outliers in first quartile as well 


bmbelow <- quantile(df$fixed.acidity, 0.25) - 1.5 * IQR(df$fixed.acidity)

bmbelow
#4.8 Anything below this value is an outlier 

high <- 8.8
low <- 4.8

newfixedacidity <- df$fixed.acidity[(df$fixed.acidity < high) & (df$fixed.acidity > low) ]


#do these steps for each col to get a new dataframe now that the number of outliers will vary per col, to make the length even before putting everyhting in dataframe is replace blanks or na with col means
