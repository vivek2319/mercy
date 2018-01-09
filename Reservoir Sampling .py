
# coding: utf-8

# In[5]:

#Load the Packages 
import random
from collections import Counter


# In[6]:

def Reservoir_one_sample(iterable):
    for t, item in enumerate(iterable):
        if random.random() <= 1/(t+1):
            selected = item
    return selected


# In[8]:

Counter([Reservoir_one_sample(range(1,11)) for i in range(10000000)])


# In[ ]:



