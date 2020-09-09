# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %%
import pandas as pd

# %%
df = pd.read_table("kz.txt", header=None)

# %%
x = df[df.iloc[:,3]<0.05].iloc[:,0].str[:-2]
x.to_csv("kz_filter_list.txt",index=None, header=None)
