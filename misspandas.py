#Dealing with Missing Data using Pandas 
import numpy as np
import pandas as pd 

d = {'A':[1,2, np.nan], 'B':[5, np.nan, np.nan], 'C':[1,2,3]}

df = pd.DataFrame(d)

df

#>>> df
#     A    B  C
#0  1.0  5.0  1
#1  2.0  NaN  2
#2  NaN  NaN  3
#>>> 

#Drop na by default this method drops na with rows meaning with axis = 0

df.dropna()
#>>> df.dropna()
#     A    B  C
#0  1.0  5.0  1

#Therefore you want to remove NA's with axis = 1
df.dropna(axis=1)
#   C
#0  1
#1  2
#2  3


df.dropna(thresh=2)
#>>> df.dropna(thresh=2)
#     A    B  C
#0  1.0  5.0  1
#1  2.0  NaN  2



#Let's fill those na values 
df.fillna(value="FILL VALUE")
#>>> df.fillna(value="FILL VALUE")
#            A           B  C
#0           1           5  1
#1           2  FILL VALUE  2
#2  FILL VALUE  FILL VALUE  3


df['A'].fillna(value=df['A'].mean())

#>>> df['A'].fillna(value=df['A'].mean())
#0    1.0
#1    2.0
#2    1.5
#Name: A, dtype: float64

