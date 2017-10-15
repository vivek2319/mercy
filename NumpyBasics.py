Python 3.5.2 (v3.5.2:4def2a2901a5, Jun 25 2016, 22:01:18) [MSC v.1900 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> import numpy as np
>>> a = np.array([0,1,2,3,4,5])
>>> a
array([0, 1, 2, 3, 4, 5])
>>> a.ndim
1
>>> a.shape
(6,)
>>> #Transform this array to a two-dimensional matrix
>>> b = a.reshape((3,2))
>>> b
array([[0, 1],
       [2, 3],
       [4, 5]])
>>> b.ndim
2
>>> b.shape
(3, 2)
>>> b[1][0] = 77
>>> b
array([[ 0,  1],
       [77,  3],
       [ 4,  5]])
>>> a
array([ 0,  1, 77,  3,  4,  5])
>>> c = a.reshape((3,2)).copy()
>>> c
array([[ 0,  1],
       [77,  3],
       [ 4,  5]])
>>> c[0][0]=-99
>>> c
array([[-99,   1],
       [ 77,   3],
       [  4,   5]])
>>> a
array([ 0,  1, 77,  3,  4,  5])
>>> #C & A are totally independent values
>>> d = np.array([1,2,3,4,5])
>>> d*2
array([ 2,  4,  6,  8, 10])
>>> d**2
array([ 1,  4,  9, 16, 25])
>>> [1,2,3,4,5]*2
[1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
>>> [1,2,3,4,5]**2
Traceback (most recent call last):
  File "<pyshell#23>", line 1, in <module>
    [1,2,3,4,5]**2
TypeError: unsupported operand type(s) for ** or pow(): 'list' and 'int'
>>> #Notice that if we use numpy arrays, we sacrifice the agility python lists suffer
>>> #Let's learn indexing
>>> a[np.array([2,3,4])]
array([77,  3,  4])
>>> #Let's learn how to access our data
>>> a>4
array([False, False,  True, False, False,  True], dtype=bool)
>>> a<2
array([ True,  True, False, False, False, False], dtype=bool)
>>> a[a>5]
array([77])
>>> #HAndling Nan's
>>> c = np.array([1, 2, np.NAN, 3, 4])
>>> c
array([  1.,   2.,  nan,   3.,   4.])
>>> np.isnan(c)
array([False, False,  True, False, False], dtype=bool)
>>> c[~np.isnan(c)]
array([ 1.,  2.,  3.,  4.])
>>> np.mean(c[~np.isnan(c)])
2.5
>>> #Numpy arrays always have only one data type
>>> a = np.array([1,2,3])
>>> a.dtype
dtype('int32')
>>> 
