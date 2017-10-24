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
[1] "integer"
ED$Grp <- as.factor(ED$Grp)
ED$Grp <- as.numeric(ED$Grp)
class(ED$Grp)
[1] "numeric"



#Running LDFA model 

set.seed(1234)
Accuracies <- c(0.00)
for (i in seq(1000))
{
  inTrain <- createDataPartition(y=ED$Grp, p=0.75, list=FALSE)
  training <- ED[inTrain,]
  testing <- ED[-inTrain,]
  ED.R <- lda(as.matrix(ED[,c(2:13)]), ED[,"Grp"], data=training, prior=c(1,1,1)/3, CV = T)
  ED.R1 <- lda(Grp ~ .,data=training)
  mypred <- predict(ED.R1,testing)
  cm <- confusionMatrix(mypred$class, testing$Grp)
  Accuracies <- cm$overall["Accuracy"]
}

summary(Accuracies)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.7714  0.7714  0.7714  0.7714  0.7714  0.7714 

