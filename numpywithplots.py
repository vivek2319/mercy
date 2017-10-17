import matplotlib.pyplot as plt
import numpy as np
a = np.array([1234,2344, 6786, 5467, 4467, 7896, 4567, 9876, 1433])
print(data[:10])
b = np.array([121,234, 678, 546, 446, 789, 456, 987, 143])
plt.scatter(a,b,s=10)
plt.title("Practicing some things in Python")
plt.xlabel("salary in thousand $")
plt.ylabel(" per hour rate")
plt.grid(True, linestyle='-', color='0.75')
plt.show()
#Output can be viewed at https://tinyurl.com/y8wknzfr
