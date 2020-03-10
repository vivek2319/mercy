def model_evaluation(X_train,y_train, X_test, y_test,y_pred,  model, alg_name='Model'):
    # Receive a fitted model
    #model.fit(X_train, y_train)
    #cross_val_score
    print('cross_val_score ' +str(cross_val_score(model, X_train, y_train, cv=5)))
    # make predictions for test data
    #y_pred = model.predict(X_test)
    # calculate the scores
    #accuracy_score
    print('accuracy '+ str(accuracy_score(y_pred= y_pred, y_true=y_test) * 100))
    print('balanced_accuracy_score '+ str(balanced_accuracy_score(y_pred= y_pred, y_true=y_test) * 100))
    
    #f1_score
    print('f1_score ' + str(f1_score(y_pred= y_pred, y_true=y_test, average='macro')  * 100))
    #precision_score
    print('precision_score ' + str(precision_score(y_pred= y_pred, y_true=y_test, average='weighted')* 100))
    #log_loss
    print('Log loss ' + str(log_loss(y_pred= y_pred, y_true=y_test) ))
    #recall_score
    print('recall_score ' + str(recall_score(y_pred= y_pred, y_true=y_test)*100 ))
    #roc_curve
    y_pred_proba = model.predict_proba(X_test)[:,1]
    false_positive_rate, true_positive_rate, thresholds = roc_curve(y_true=y_test, y_score=y_pred_proba)

    plt.plot([0,1],[0,1],'k--')
    plt.plot(false_positive_rate,true_positive_rate, label=alg_name)
    plt.xlabel('false_positive_rate')
    plt.ylabel('true_positive_rate')
    plt.title('ROC curve of ' + alg_name)
    plt.show()
    
    #roc_auc_score
    print('roc_auc_score ' + str(roc_auc_score(y_test,y_pred_proba) * 100))
    
    #confusion_matrix
    print('confusion_matrix ' + str(confusion_matrix(y_test,y_pred)))
    pd.crosstab(y_test, y_pred, rownames=['True'], colnames=['Predicted'], margins=True)
    
    print('classification_report', str(classification_report(y_test,y_pred)))
