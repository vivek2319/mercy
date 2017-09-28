SAHD <- read.csv('http://math.mercyhurst.edu/~sousley/STAT_139/data/sahdd.csv', as.is = T)
#remove the ID column
newshad <- data.frame(SAHD[-1])
#label 0 for absent and 1 for present in family history
SAHD$famhist[SAHD$famhist=="Absent"] <- '0'
SAHD$famhist[SAHD$famhist=="Present"] <- '1'
famhist2 <- as.numeric(SAHD$famhist)
famhist2

famhist3 <- cbind.data.frame(famhist2)

head(famhist3)

#Let's remove the old famhist 
newshad <- newshad[-5]

names(newshad)
#[1] "sbp"       "tobacco"   "ldl"       "adiposity" "typea"     "obesity"  
#[7] "alcohol"   "age"       "chd" 

#Add the newly formed famhist3 variable into dataframe
newshad2 <- data.frame(newshad, famhist3)

#Check the column names
names(newshad2)
#[1] "sbp"       "tobacco"   "ldl"       "adiposity" "typea"     "obesity"  
#[7] "alcohol"   "age"       "chd"       "famhist2"

#Let's rearrange the data
newshad2 <- subset.data.frame(newshad2, select = c('chd', 'sbp', 'tobacco', 'ldl', 'adiposity', 'typea', 'obesity', 'alcohol', 'age', 'famhist2'))

names(newshad2)
#[1] "chd"       "sbp"       "tobacco"   "ldl"       "adiposity" "typea"     "obesity"  
#[8] "alcohol"   "age"       "famhist2" 

#Let's normalize the data
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
   }

#Exclude the variable that we want to predict
navin <- as.data.frame(lapply(newshad2[2:10], normalize))
summary(navin)
library(bestglm)

myfit <- bestglm(newshad2, IC="BICq", t=0.25, family=binomial)
myfit

#Output:
BICq(q = 0.25)
BICq equivalent for q in (0.0703191746407851, 0.895940044901826)
Best Model:
  Estimate  Std. Error   z value     Pr(>|z|)
(Intercept) -1.75407801 0.330944614 -5.300216 1.156656e-07
chd          0.91518643 0.216342727  4.230262 2.334192e-05
age          0.02485654 0.007500281  3.314082 9.194469e-04

