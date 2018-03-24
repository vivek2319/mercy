#Approximate Knn
#Date 18th March 2018
#Load the packages 
library(RANN)
library(caTools)
library(caret)

MNIST <- read.table("train.csv", header = TRUE, sep = ",", quote = "")
head(MNIST)

set.seed(1234)
#create index for random, stratified 70/30 training / testing split 
index <- sample.split(MNIST$label, SplitRatio = 0.7) 

trainMNIST <- MNIST[index==1,] #Create training set 70% of Total 
testMNIST <- MNIST[index!=1,] #create testing set, 30% of Total

head(trainMNIST)
head(testMNIST)

#set a start time
ann1.start <- proc.time()
ann1 <- nn2(trainMNIST[,2:785], query = testMNIST[,2:785], k=10, treetype = "kd", searchtype = "priority", eps=0.99) #Execute ANN


#set end time
ann1.end <- proc.time()

#Show indices of nearest neighbours 
print(head(ann1$nn.idx))

#Show distances of nearest neighbours 
print(head(ann1$nn.idx.dists))

#Calculate run time
ann1.total <- ann1.end - ann1.start

print(ann1.total)



#Calcualte model accuracy and generate a confusion matrix 
for(i in 1:nrow(testMNIST)){
  testMNIST$ann1.preds[i] <- names(which.max(table(trainMNIST[ann1$nn.idx[i,],1])))
} #assign predictions based on majority of votes of nearest neighbors 


#Calculate Accuracy
ann1.auc <- (sum(testMNIST$label==testMNIST$ann1.preds) / nrow(testMNIST))

print(ann1.auc)

#Create a confusion matrix for label
table(testMNIST$ann1.preds, testMNIST$label)

#Let's do same with confusion matrix commans
confusionMatrix(testMNIST$ann1.preds, testMNIST$label)

#We achieved 96 % accuracy 


