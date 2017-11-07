#Pandas from Basics with Dataframes

import numpy as np
import pandas as pd 
from numpy.random import randn
np.random.seed(121)

df = pd.DataFrame(randn(5,4), ['A','B','C','D','E'],['W','X','Y','Z'])
df


#>>> df
#          W         X         Y         Z
#A -0.212033 -0.284929 -0.573898 -0.440310
#B -0.330111  1.183695  1.615373  0.367062
#C -0.014119  0.629642  1.709641 -1.326987
#D  0.401873 -0.191427  1.403826 -1.968769
#E -0.790415 -0.732722  0.087744 -0.500286
#'''

#Let's grab first column
df['W']



type(df['W'])
#pandas.core.series.Series


type(df)
#pandas.core.frame.DataFrame


#Let's create new column
df['New'] = df['W'] + df['Y']

#Delete the column
df.drop('New', axis=1)

#Get Size of dataframe
df.shape

#Remember row is defined as zero axis and 1 is defined as one axis

#To fetch a row we use loc
df.loc['A']

#we use iloc to pass index position 
df.iloc[2]

#Row, column
df.loc['B', 'Y']

#To subset
df.loc[['A','B'] ,['W','Y'] ]
