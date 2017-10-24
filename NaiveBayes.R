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



#Naïve Bayesian 

set.seed(1234)
Accuracies <- c(0.00)
for (i in seq(1000))
{
  inTrain <- createDataPartition(y=ED$Grp, p=0.75, list=FALSE)
  training <- ED[inTrain,]
  testing <- ED[-inTrain,]
  nb_laplace1 <- naiveBayes(Grp~., data=training, laplace=1)
  laplace1_pred <- predict(nb_laplace1, testing, type="class")
  cm <- confusionMatrix(laplace1_pred, testing$Grp)
  Accuracies[i] <- cm$overall["Accuracy"]
}
summary(Accuracies)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.3238  0.5238  0.5619  0.5617  0.6095  0.7429 

