#The equivalnet of foll sql to python
#SELECT *
#FROM table
#WHERE colume_name = some_value

#is

#first
df.loc[df['column_name'] == some_value]

#or
#second
#if you have multiple values
df.loc[df['column_name'].isin(some_values)]

#or
#third
#combine multiple conditions using & 
df.loc[(df['column_name'] >= A) & (df['column_name'] <= B)]


#or
#fourth
#if you want "not equal to

df.loc[df['column_name'] != some_value]
