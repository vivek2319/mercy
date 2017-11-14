#Subset Selection in Ridge and Lasso
library(glmnet) #lasso and ridge regression
library(ISLR)
library(caret) #tune hyper-parameters
library(leaps) #subset selection 

str(Hitters)

# We want to predict salary
reg.ss<-regsubsets(Salary~., Hitters)
summary (reg.ss)

# We want ALL 19 vars
reg.ss<-regsubsets(Salary~., Hitters, nvmax=19)
res.reg.ss<-summary(reg.ss)
res.reg.ss


# We want information on each model
res.reg.ss$rsq
