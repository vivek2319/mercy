library(class)
library(MASS)
library(xgboost)
library(e1071)
library(caret)
library(ggplot2)
library(deepboost)
library(glmnet)
library(ISLR)
library(leaps)
library(pls)
library(randomForest)


train <-read.csv("bllodtrain.csv")

test <- read.csv("bllodtest.csv")


train$Total.Volume.Donated..c.c.. <- NULL
test$Total.Volume.Donated..c.c.. <- NULL

Target <- as.numeric(as.character(train$Made.Donation.in.March.2007))

Ratio <- train$Months.since.Last.Donation/train$Months.since.First.Donation

AvgDon <- train$Number.of.Donations / train$Months.since.First.Donation

AvgWait <- train$Months.since.First.Donation / train$Number.of.Donations

partone <- data.frame("Months.since.Last.Donation"=train$Months.since.Last.Donation,"Number.of.Donations"=train$Number.of.Donations,"Months.since.First.Donation"= train$Months.since.First.Donation,"Ratio"=Ratio, "AverageDonation"=AvgDon, "AverageWait"=AvgWait)


normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

dfNorm <- as.data.frame(lapply(partone, normalize))
head(dfNorm)
finaltrain <- data.frame(dfNorm,Target)
head(finaltrain)


#############
#Do same with test data


Ratio <- test$Months.since.Last.Donation/test$Months.since.First.Donation

AvgDon <- test$Number.of.Donations / test$Months.since.First.Donation

AvgWait <- test$Months.since.First.Donation / test$Number.of.Donations

partwo <- data.frame("Months.since.Last.Donation"=test$Months.since.Last.Donation,"Number.of.Donations"=test$Number.of.Donations,"Months.since.First.Donation"= test$Months.since.First.Donation,"Ratio"=Ratio, "AverageDonation"=AvgDon, "AverageWait"=AvgWait)


normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

partthree <- as.data.frame(lapply(partwo, normalize))

head(partthree)
finaltest <- data.frame(partthree)
head(finaltest)




# shuffle and split the data into three parts
set.seed(1234)
finaltrain <- finaltrain[sample(nrow(finaltrain)),]
split <- floor(nrow(finaltrain)/3)
ensembleData <- finaltrain[0:split,]
blenderData <- finaltrain[(split+1):(split*2),]
testingData <- finaltrain[(split*2+1):nrow(finaltrain),]


# set label name and predictors
labelName <- 'Target'
predictors <- names(ensembleData)[names(ensembleData) != labelName]



library(caret)
# create a caret control object to control the number of cross-validations performed
myControl <- trainControl(method='cv', number=3, returnResamp='none')


# quick benchmark model 
test_model <- train(blenderData[,predictors], blenderData[,labelName], method='gbm', trControl=myControl)
preds <- predict(object=test_model, testingData[,predictors])


library(pROC)
auc <- roc(testingData[,labelName], preds)
print(auc$auc)



# train all the ensemble models with ensembleData
model_gbm <- train(ensembleData[,predictors], ensembleData[,labelName], method='gbm', trControl=myControl)
model_rpart <- train(ensembleData[,predictors], ensembleData[,labelName], method='rpart', trControl=myControl)
model_treebag <- train(ensembleData[,predictors], ensembleData[,labelName], method='treebag', trControl=myControl)




blenderData$gbm_PROB <- predict(object=model_gbm, blenderData[,predictors])
blenderData$rf_PROB <- predict(object=model_rpart, blenderData[,predictors])
blenderData$treebag_PROB <- predict(object=model_treebag, blenderData[,predictors])
testingData$gbm_PROB <- predict(object=model_gbm, testingData[,predictors])
testingData$rf_PROB <- predict(object=model_rpart, testingData[,predictors])
testingData$treebag_PROB <- predict(object=model_treebag, testingData[,predictors])


# see how each individual model performed on its own
auc <- roc(testingData[,labelName], testingData$gbm_PROB )
print(auc$auc)
#Area under the curve: 0.7524
 

auc <- roc(testingData[,labelName], testingData$rf_PROB )
print(auc$auc) 
#Area under the curve: 0.5

auc <- roc(testingData[,labelName], testingData$treebag_PROB )
print(auc$auc) 
#Area under the curve: 0.7216

# run a final model to blend all the probabilities together
predictors <- names(blenderData)[names(blenderData) != labelName]
final_blender_model <- train(blenderData[,predictors], blenderData[,labelName], method='gbm', trControl=myControl)


# See final prediction and AUC of blended ensemble
preds <- predict(object=final_blender_model, testingData[,predictors])
auc <- roc(testingData[,labelName], preds)
print(auc$auc) 
#Area under the curve: 0.7207




