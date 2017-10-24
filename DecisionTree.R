EDD <- read.csv('http://math.mercyhurst.edu/~sousley/STAT_139/data/EDDat3.csv')



library(MASS)
library(caret)
library(e1071)
library(janitor)
library(tidyr)
library(class)

NewEDD <- subset(EDD, select = c(Grp, i2, i3, i6, i7, i10, i22, i24, i35, i36, i37, i39, i45))
head(NewEDD)
newEDD2 <- na.omit(NewEDD)
head(newEDD2)
table(newEDD2$Grp)
dim(newEDD2)

table(newEDD2$Grp)


ED <-cbind(newEDD2["Grp"], scale(newEDD2[,c(2:13)]) )
head(ED)

class(ED$Grp)
#[1] "integer"
ED$Grp <- as.factor(ED$Grp)
ED$Grp <- as.numeric(ED$Grp)
class(ED$Grp)
#[1] "numeric"


#Decision Tree
#Using Rpart 
Accuracies <- c(0.00)
for (i in seq(1000))
{
  inTest <- createDataPartition(ED$Grp, p=0.20, list=FALSE)
  
  myH4A <- rpart(Grp ~., 
                 data = ED,
                 method = "class", subset = inTest,
                 parms = list(split="gini"),
                 control = rpart.control(usesurrogate = 0, maxsurrogate = 0))
  
  cm <- confusionMatrix(ED[inTest, "Grp"], predict(myH4A, newdata=ED[inTest,], type="class"))
  
  Accuracies[i] <- cm$overall["Accuracy"]
}
summary(Accuracies)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.7093  0.7907  0.8023  0.8065  0.8256  0.9070 

