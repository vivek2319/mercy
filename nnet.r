#Running the multinom Neural network 
EDD <- read.csv('http://math.mercyhurst.edu/~sousley/STAT_139/data/EDDat3.csv')

dim(EDD)

summary(EDD)

NewEDD <- subset(EDD, select = c(Grp, i2, i3, i6, i7, i10, i22, i24, i35, i36, i37, i39, i45))
head(NewEDD)

newEDD2 <- na.omit(NewEDD)

table(newEDD2$Grp)

#1   2   3 
#72 252  98 

ED <-cbind(newEDD2["Grp"], scale(newEDD2[,c(2:13)]) )
head(ED)



ED$Grp <- as.factor(ED$Grp)
ED$Grp <- as.numeric(ED$Grp)
class(ED$Grp)
#[1] "numeric"


set.seed(1234)
Accuracies <- c(0.00)
for (i in seq(1000))
{
inTrain <- createDataPartition(y=ED$Grp, p=0.75, list=FALSE)
training <- ED[inTrain,]
testing <- ED[-inTrain,]
modelfit <- multinom(Grp ~ ., data=training, maxit=500, trace=T)

preds2 <- predict(modelfit, type="class", newdata=testing)
  
  cm <- confusionMatrix(preds2, testing$Grp)
  Accuracies[i] <- cm$overall["Accuracy"]
}
 
summary(Accuracies)