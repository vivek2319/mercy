Here I provide you the relevant code in R which can be used to calculate the Log Loss during the cross-validation stage while model building:

# Log Loss as defined on the kaggle forum

 LogLoss<-function(act, pred)
 {
 eps = 1e-15;
 nr = length(pred)
 pred = matrix(sapply( pred, function(x) max(eps,x)), nrow = nr)
 pred = matrix(sapply( pred, function(x) min(1-eps,x)), nrow = nr)
 ll = sum(act*log(pred) + (1-act)*log(1-pred))
 ll = ll * -1/(length(act))
 return(ll);
 }

 LogLoss(actual,predicted)
