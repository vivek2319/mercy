#Suppose X is a data frame then 

x[!is.na(x)]

#create's a vector which contains only the nonmissing values in x.

#Other options are use

complete.cases

#One very useful choice for this argument is

na.omit 

#which will return a data frame with any row containing one or more missing values eliminated. 
