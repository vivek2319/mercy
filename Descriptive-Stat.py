#Load the packages
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats
%matplotlib inline 

def descriptive_stats(distribution):
    dist = np.array(distribution)

    print('Descriptive statistics for distribution:\n', dist)
    print('Number of scores:', len(dist))
    print('Number of unique scores:', len(np.unique(dist)))
    print('Sum:', sum(dist))
    print('Min:', min(dist))
    print('Max:', max(dist))
    print('Range:', max(dist)-min(dist))
    print('Mean:', np.mean(dist, axis=0))
    print('Median:', np.median(dist, axis=0))
    print('Mode:', scipy.stats.mode(dist)[0][0])
    print('Variance:', np.var(dist, axis=0))
    print('Standard deviation:', np.std(dist, axis=0))
    print('1st quartile:', np.percentile(dist, 25))
    print('3rd quartile:', np.percentile(dist, 75))
    print('Distribution skew:', scipy.stats.skew(dist))

    plt.hist(dist, bins=len(dist))
    plt.yticks(np.arange(0, 6, 1.0))
    plt.title('Histogram of distribution scores')
    plt.show()

    descriptive_stats([ 1, 4, 5, 6, 8, 8, 9, 10, 10, 11, 11, 13, 13, 13, 14, 14, 15, 15, 15, 15 ])
