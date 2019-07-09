#when to normalize and how to do it ? 
#normalize after you split the data

x_train, x_test, y_train, y_test = train_test_split(X_features, Y_feature, test_size=0.20, random_state=4)

scaler = StandardScaler()

normalized_x_train = pd.DataFrame(scaler.fit_transform(x_train), columns = x_train.columns)
LR = LogisticRegression(C=0.01, solver='liblinear').fit(normalized_x_train, y_train)

normalized_x_test = pd.DataFrame(scaler.transform(x_test), columns = x_test.columns)
y_test_pred = LR.predict(normalized_x_test)
