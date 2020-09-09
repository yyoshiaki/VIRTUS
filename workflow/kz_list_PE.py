# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %%
import pandas as pd

# %%
df1 = pd.read_table("kz_1.txt", header=None)
df2 = pd.read_table("kz_2.txt", header=None)

# %%
x1 = df1[df1.iloc[:,3]<0.05].iloc[:,0].str[:-2]
x2 = df2[df2.iloc[:,3]<0.05].iloc[:,0].str[:-2]

x1.to_csv("kz_filter_list_1.txt",index=None, header=None)
x2.to_csv("kz_filter_list_2.txt",index=None, header=None)
