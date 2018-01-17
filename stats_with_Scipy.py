#Python 3.5.2 (v3.5.2:4def2a2901a5, Jun 25 2016, 22:01:18) [MSC v.1900 32 bit (Intel)] on win32
#Type "copyright", "credits" or "license()" for more information.
>>> import numpy as np
>>> a = np.random.normal(0,1,size=100)
>>> b = np.random.normal(1,1,size=100)
>>> stats.ttest_ind(a,b)
Traceback (most recent call last):
  File "<pyshell#3>", line 1, in <module>
    stats.ttest_ind(a,b)
NameError: name 'stats' is not defined
>>> from scipy import scipy.stats
SyntaxError: invalid syntax
>>> from scipy import stats
>>> stats.ttest_ind(a,b)

Ttest_indResult(statistic=-9.7738812433919353, pvalue=1.1610896913232291e-18)
>>> 
#The resulting output is composed of:

#The T statistic value: it is a number the sign of which is proportional to the difference between the two random processes and 
#the magnitude is related to the significance of this difference.
    
  
#The p value: the probability of both processes being identical. If it is close to 1, the two process are almost certainly 
#identical. The closer it is to zero, the more likely it is that the processes have different means.
