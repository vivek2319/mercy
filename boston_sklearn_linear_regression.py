
#This is introductory python code for linear regression using sklearn library
#we will try to predict boston housing data

import pandas as pd 
import numpy as np 
from sklearn import linear_model
from sklearn.cross_validation import train_test_split

from sklearn.datasets import load_boston
boston = load_boston()
boston

df_x=pd.DataFrame(boston.data,columns=boston.feature_names)

df_y=pd.DataFrame(boston.target)

#View haead of dataframe
df_x.head()

#View tail of dataframe
df_x.tail()

#Let's see summary
df_x.describe()

reg = linear_model.LinearRegression()

x_train, x_test, y_train, y_test = train_test_split(df_x, df_y, test_size=0.2, random_state=6)


x_train.head()

y_train.head()


#Let's fit the regression

reg.fit(x_train, y_train)


reg.coef_

#Predict the house prises 

reg.predict(x_test)

#Let's compute mean square error
np.mean((reg.predict(x_test)-y_test)**2)