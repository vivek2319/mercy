#this user defined function we will use to get shape of dataframe in spark
def spark_shape(self):
    return (self.count(), len(self.columns))
pyspark.sql.dataframe.DataFrame.shape = spark_shape


dataframe_name.shape()
