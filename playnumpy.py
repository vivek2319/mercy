import numpy as np

#create an array of 10 zero's
np.zeros(10)

#Create an array of 10 one's
np.ones(10)

#Create an array of 10 five's 
#First method
np.ones(10) * 5

#Second method
np.zeros(10) + 5


#Create an array of intergers from 10 to 50
np.arange(10,51)


#Create an array of all the even integers frm 10 to 50
np.arange(10,51,2)

#Creata 3X3 matrx with values ranging from 0 to 8
np.arange(9).reshape(3,3)

#Create a 3X3 identiy matrix
np.eye(3)


#Use numpy to generate a random number between 0 and 1 
np.random.rand(1)


#Use numpy to generate an array of 25 random numbers sampled from a standard normla distribution 
np.random.rand(25)

#Create a matrix from 0.01 to 1.00, 2-D array, step size 0.01 all the way to 1
#first method
np.arange(1,101).reshape(10,10)/100


#Create an array of 20 linearly spaced points between 0 and 1 
np.linspace(0,1,20)


#Numpy Indexing and solution
#Now you will be given a few matrices, and be asked to replicate the resulting matrix outputs
mat = np.arange(1,26).reshape(5,5)
mat
'''
array([[ 1,  2,  3,  4,  5],
       [ 6,  7,  8,  9, 10],
       [11, 12, 13, 14, 15],
       [16, 17, 18, 19, 20],
       [21, 22, 23, 24, 25]])
>>> 
'''

#Write code to generate foll matix
'''
array([[12, 13, 14, 15],
       [17, 18, 19, 20],
       [22, 23, 24, 25]])
>>> 
'''
mat[2:,1:]

#Just grab 20 from mat
mat[3,4]

#Now grab following matrix
'''
array([[ 2],
       [ 7],
       [12]]])
''' 


mat[:3,1:2]

#Write a code to display array([21,22,23,24,25])
mat[-1]

#Other way 
mat[4,:]



#Write a code to display following output
#array([16,17,18,19,20],
#      [21,22,23,24,25]])


mat[3:5,:]



#Get the sum of the values in mat
np.sum(mat)

#Other way
mat.sum()


#Get the standard deviation of the values in mat
np.std(mat)

#Other way
mat.std()


#Get the sum of all columns in mat
mat.sum(axis=0)