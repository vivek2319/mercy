Best way to remove na values; do it inplace without reassingning it

df_all.dropna(inplace=True)
df_all.reset_index(drop=True, inplace=True)


OR

df_all = df_all.dropna()
df_all = df_all.reset_index(drop=True)


---------------------------
#This worked far better than these two

df2=df1[df1['b.regression'].notnull()]
