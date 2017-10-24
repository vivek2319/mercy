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



#KNN Model 

set.seed(1234)
Accuracies <- c(0.00)
for (i in seq(100))
{
  inTrain <- createDataPartition(y=as.factor(ED$Grp), p=0.75, list=FALSE)
  training <- ED[inTrain,]
  testing <- ED[-inTrain,]
  model_knn <- train(Grp ~ . ,data=training, method='knn')
  Pred <- predict(model_knn,type="raw",newdata = testing)
  
  cm <- confusionMatrix((Pred), testing$Grp)
  Accuracies <- cm$overall["Accuracy"]
}

summary(Accuracies)

#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.7619  0.7619  0.7619  0.7619  0.7619  0.7619 
