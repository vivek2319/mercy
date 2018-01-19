library(e1071)
head(iris)
attach(iris)
x<- subset(iris, select = -Species)
y<- Species

svm_model <- svm(Species ~ ., data = iris)
summary(svm_model)

pred1 <- predict(svm_model, x)
system.time(pred<-predict(svm_model,x))
#user  system elapsed 
#0.02    0.00    0.02 

conf<-table(pred1,y)
conf
#             y
#pred         setosa versicolor virginica
#setosa         50          0         0
#versicolor      0         48         2
#virginica       0          2        48

confusionMatrix(pred1,y)



#Tuning SVM to find the best cost and gamma

svm_tune <- tune(svm,train.x = x, train.y = y, kernel = "radial", ranges = list(cost=10^(-3:3)), gamma=c(0.5,1,1.5,2))

print(svm_tune)

#Parameter tuning of ‘svm’:
#  
#  - sampling method: 10-fold cross validation 
#
#- best parameters:
#  cost
# 1

#- best performance: 0.04666667 

#Now that we have found best cost and gamma, we can run model again with these values 

new_svm <- svm(Species ~ ., data= iris, kernel="radial", cost=1, gamma=0.4)

summary(new_svm)



pred2 <- predict(new_svm,x)
system.time(predict(new_svm,x))

table(pred2,y)
confusionMatrix(pred2,y)

#Confusion Matrix and Statistics
#
#            Reference
#Prediction   setosa versicolor virginica
#  setosa         50          0         0
#  versicolor      0         48         2
#  virginica       0          2        48
#
#Overall Statistics
#                                          
#               Accuracy : 0.9733          
#                 95% CI : (0.9331, 0.9927)
#    No Information Rate : 0.3333          
#    P-Value [Acc > NIR] : < 2.2e-16       
#                                          
#                  Kappa : 0.96            
# Mcnemar's Test P-Value : NA              
#
#Statistics by Class:
#
#                     Class: setosa Class: versicolor Class: virginica
#Sensitivity                 1.0000            0.9600           0.9600
#Specificity                 1.0000            0.9800           0.9800
#Pos Pred Value              1.0000            0.9600           0.9600
#Neg Pred Value              1.0000            0.9800           0.9800
#Prevalence                  0.3333            0.3333           0.3333
#Detection Rate              0.3333            0.3200           0.3200
#Detection Prevalence        0.3333            0.3333           0.3333
#Balanced Accuracy           1.0000            0.9700           0.9700
#> 
