library(nnet)
library(MASS)
library(caret)
library(e1071)

sahdd <- read.csv('http://math.mercyhurst.edu/~sousley/STAT_139/data/sahdd.csv', as.is = T)

hdd <- subset(sahdd, select = c(chd, sbp, tobacco, ldl, adiposity, famhist, typea, obesity, alcohol, age))

ss <- cbind(hdd[,c("chd", "famhist")], scale(hdd[,c(-1,-6)]))
head(ss)
H4A <- Howells[which(Pop == 'NORSE' | Pop == 'BERG'),]

ss$chd <- as.factor(ss$chd)
ss$famhist <- as.factor(ss$famhist)


set.seed(1234)
Accuracies <-c(0.00)
for (i in seq(1000))
{
  # sample
  inTrain<-createDataPartition(ss$chd, p = .80, list = FALSE)
  
    H4AS.navg <-avNNet(chd~ ., data = ss, subset = inTrain, size = 2, rang = 0.5, decay = 5e-5, maxit= 300, repeats = 20)
  
  Accuracies[i] <-confusionMatrix(ss$chd[-inTrain], predict(H4AS.navg, ss[-inTrain,], type = "class"))$overall["Accuracy"]
  
  print(paste('Ran the process ', i, 'times.'))
}
summary(Accuracies)
  
acclen = length(na.omit(Accuracies))
plot(density(Accuracies), main = paste('Average Neural Network Model Accuracies: ', acclen, 'runs'))
  
  
