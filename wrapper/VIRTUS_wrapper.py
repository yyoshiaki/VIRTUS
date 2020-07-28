# %%
import subprocess
import numpy as np
import pandas as pd
import argparse
import os
from scipy import stats

# %%
parser = argparse.ArgumentParser(description='This script is ...')

parser.add_argument('input_path')
parser.add_argument('--VIRTUS', required = True)
parser.add_argument('--genomeDir_human', required = True)
parser.add_argument('--genomeDir_virus', required = True)
parser.add_argument('--salmon_index_human', required = True)
parser.add_argument('--salmon_quantdir_human', default = "salmon_human")
parser.add_argument('--outFileNamePrefix_human', default = "human")
parser.add_argument('--nthreads', default = "16")

args = parser.parse_args()


# %%
df = pd.read_csv(args.input_path)


# %%
for index, item in df.iterrows():
    clean_cmd = " ".join(["rm","-rf","/tmp/*"])
    prefetch_cmd = " ".join(["prefetch",item["SRR"]])
    fasterq_cmd = " ".join(["fasterq-dump", "--split-files", item["SRR"]+".sra", "-e","16"])
    VIRTUS_PE = " ".join([
        os.path.join(args.VIRTUS, "workflow/VIRTUS.PE.cwl"), 
        "--fastq1", item["SRR"] + ".sra_1.fastq",
        "--fastq2", item["SRR"] + ".sra_2.fastq", 
        "--genomeDir_human", args.genomeDir_human, 
        "--genomeDir_virus", args.genomeDir_virus,
        "--salmon_index_human", args.salmon_index_human,
        "--salmon_quantdir_human", args.salmon_quantdir_human,
        "--outFileNamePrefix_human", args.outFileNamePrefix_human,
        "--nthreads", args.nthreads
    ])
    VIRTUS_SE = " ".join([
        os.path.join(args.VIRTUS, "workflow/VIRTUS.SE.cwl"), 
        "--fastq", item["SRR"] + ".sra_1.fastq",
        "--genomeDir_human", args.genomeDir_human, 
        "--genomeDir_virus", args.genomeDir_virus,
        "--salmon_index_human", args.salmon_index_human,
        "--salmon_quantdir_human", args.salmon_quantdir_human,
        "--outFileNamePrefix_human", args.outFileNamePrefix_human,
        "--nthreads", args.nthreads
    ])

    print(clean_cmd)
    p_clean = subprocess.Popen(clean_cmd, shell = True)
    p_clean.wait()

    print(prefetch_cmd,"\n")
    try:
        p_prefetch = subprocess.Popen(prefetch_cmd, shell = True)
        p_prefetch.wait()
    except:
        print("Download Error")
    
    os.chdir(item["SRR"])

    print(fasterq_cmd,"\n")
    try:
        p_fasterq = subprocess.Popen(fasterq_cmd, shell = True)
        p_fasterq.wait()
    except:
        print("fasterq error")

    if item["Layout"] == "SE":
        print(VIRTUS_SE,"\n")
        try:
            p_VIRTUS_SE = subprocess.Popen(VIRTUS_SE, shell = True)
            p_VIRTUS_SE.wait()
        except:
            print("VIRTUS.SE.cwl error")

    elif item["Layout"] == "PE":
        print(VIRTUS_PE,"\n")
        try:
            p_VIRTUS_PE = subprocess.Popen(VIRTUS_PE, shell = True)
            p_VIRTUS_PE.wait()
        except:
            print("VIRTUS.PE.cwl error")
    else:
        print("Layout Error")

    os.chdir("..")

# %%
series_list = []
for index, item in df.iterrows():
    df_virus = pd.read_table(os.path.join(item["SRR"],"virus.counts.final.tsv"), index_col = 0)
    series_virus = df_virus.loc[:,"rate_hit"]
    series_virus = series_virus.rename(item["SRR"])
    series_list.append(series_virus)

summary = pd.concat(series_list, axis = 1).fillna(0).T
summary["Group"] = df["Group"].values

# %%
summary_dict = {}
Group = summary["Group"].unique()
for i in Group:
    summary_dict[i] = summary[summary["Group"] == i]

#%%
uval = pd.Series()
pval = pd.Series()

if summary["Group"].nunique() == 2:
    print("Conducting Mann-Whitney U-test")
    for i in range(0,len(summary.columns)-1):
        if summary["Group"].nunique() == 2:

            u, p = stats.mannwhitneyu(summary_dict[Group[0]].iloc[:,i],summary_dict[Group[1]].iloc[:,i], alternative = "two-sided")
            uval[summary.columns[i]] = u
            pval[summary.columns[i]] = p

summary.loc["uval"] = uval
summary.loc["pval"] = pval

summary.to_csv("summary.csv")

# %%
sample = summary.index[:-2]
sample_num = len(sample)
s = 0.05/(sample_num*(sample_num-1)/2)
df = pd.DataFrame(columns=sample[:-1], index=sample[1:])

for i in range(len(sample)):
    x = [pd.np.nan for i in range(len(sample)-1)]
    for j in range(i+1,len(sample)):
        x[j-1] = stats.ttest_rel(summary.iloc[i,:-1],summary.iloc[j,:-1])[1]
    df.iloc[:,i] = x
df.to_csv("ttest.csv")

with open('ttest.csv', 'a') as f:
    print("".join(["Standard = ",str(s)]), file=f)