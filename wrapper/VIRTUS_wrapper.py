#!/usr/bin/env python3

# %%
import subprocess
import numpy as np
import pandas as pd
import argparse
import os
from scipy import stats
from statsmodels.stats.multitest import multipletests
import seaborn as sns
import matplotlib as mpl
mpl.rcParams['pdf.fonttype'] = 42
mpl.rcParams['ps.fonttype'] = 42

# %%
parser = argparse.ArgumentParser()

parser.add_argument('input_path')
parser.add_argument('--VIRTUSDir', default = os.path.dirname(os.path.abspath(__file__)))
parser.add_argument('--genomeDir_human', required = True)
parser.add_argument('--genomeDir_virus', required = True)
parser.add_argument('--salmon_index_human', required = True)
parser.add_argument('--salmon_quantdir_human', default = 'salmon_human')
parser.add_argument('--outFileNamePrefix_human', default = 'human')
parser.add_argument('--nthreads', default = '16')
parser.add_argument('-s', '--Suffix_SE', default = '.fastq.gz')
parser.add_argument('-s1', '--Suffix_PE_1', default = '_1.fastq.gz')
parser.add_argument('-s2', '--Suffix_PE_2', default = '_2.fastq.gz')
parser.add_argument('--fastq', action = 'store_true')

args = parser.parse_args()

# %%
df = pd.read_csv(args.input_path)
df.columns = ["Name", "SRR", "Layout", "Group"] + list(df.columns[4:])
first_dir = os.getcwd()

print(args.VIRTUSDir)
try:
    if os.path.exists(os.path.join(args.VIRTUSDir, "workflow/VIRTUS.PE.cwl")):
        dir_VIRTUS = os.path.join(args.VIRTUSDir, "workflow/VIRTUS.PE.cwl")
    elif os.path.exists(os.path.join(args.VIRTUSDir, "VIRTUS.PE.cwl")):  
        dir_VIRTUS = os.path.join(args.VIRTUSDir, "VIRTUS.PE.cwl")
    else:
        raise ValueError('not found VIRTUS.PE.cwl or VIRTUS.SE.cwl')
except (ValueError, IndexError):
    exit('invalid path to VIRTUS. try to change --VIRTUSDir to the absolute path.')

# %%
series_list = []
clean_cmd = "rm -rf tmp"

for index, item in df.iterrows():
    if args.fastq == False:
        dir = item["SRR"]
        sample_index = item["Name"]
        prefetch_cmd = " ".join(["prefetch",sample_index])
        fasterq_cmd = " ".join(["fasterq-dump", "--split-files", sample_index + ".sra", "-e","16"])

        if item["Layout"] == "PE":
            fastq1 = sample_index + ".sra_1.fastq"
            fastq2 = sample_index + ".sra_2.fastq"
        elif item["Layout"] == "SE":
            fastq = sample_index + ".sra_1.fastq"
    else:
        dir = os.path.dirname(item["SRR"])
        sample_index = os.path.basename(item["SRR"])
        if item["Layout"] == "PE":
            fastq1 = sample_index + args.Suffix_PE_1
            fastq2 = sample_index + args.Suffix_PE_2
        elif item["Layout"] == "SE":
            fastq = sample_index + args.Suffix_SE

    if item["Layout"] =="PE":
        VIRTUS_cmd = " ".join([
            "cwltool --tmpdir-prefix tmp/",
            os.path.join(dir_VIRTUS, "workflow/VIRTUS.PE.cwl"), 
            "--fastq1", fastq1,
            "--fastq2", fastq2, 
            "--genomeDir_human", args.genomeDir_human, 
            "--genomeDir_virus", args.genomeDir_virus,
            "--salmon_index_human", args.salmon_index_human,
            "--salmon_quantdir_human", args.salmon_quantdir_human,
            "--outFileNamePrefix_human", args.outFileNamePrefix_human,
            "--nthreads", args.nthreads
        ])
    elif item["Layout"] =="SE":
        VIRTUS_cmd = " ".join([
            "cwltool --tmpdir-prefix tmp/",
            os.path.join(dir_VIRTUS, "workflow/VIRTUS.SE.cwl"), 
            "--fastq", fastq,
            "--genomeDir_human", args.genomeDir_human, 
            "--genomeDir_virus", args.genomeDir_virus,
            "--salmon_index_human", args.salmon_index_human,
            "--salmon_quantdir_human", args.salmon_quantdir_human,
            "--outFileNamePrefix_human", args.outFileNamePrefix_human,
            "--nthreads", args.nthreads
        ])
    else:
        print("Layout Error")

    if args.fastq == False:
        print(prefetch_cmd,"\n")
        try:
            p_prefetch = subprocess.Popen(prefetch_cmd, shell = True)
            p_prefetch.wait()
            os.chdir(dir)
        except:
            print("Download Error")

        print(fasterq_cmd,"\n")
        try:
            p_fasterq = subprocess.Popen(fasterq_cmd, shell = True)
            p_fasterq.wait()
        except:
            print("fasterq error")
    else:
        try:
            os.chdir(dir)
        except:
            print(dir," : No such directory")

    print(VIRTUS_cmd,"\n")
    try:
        p_VIRTUS = subprocess.Popen(VIRTUS_cmd, shell = True)
        p_VIRTUS.wait()
    except:
        print("VIRTUS error")

    print(clean_cmd,"\n")
    try:
        p_clean = subprocess.Popen(clean_cmd,shell = True)
        p_clean.wait()
    except:
        print("clean error")

    try:
        df_virus = pd.read_table("virus.counts.final.tsv", index_col = 0)
        series_virus = df_virus.loc[:,"rate_hit"]
        series_virus = series_virus.rename(item['Name'])
        series_list.append(series_virus)
    except:
        print("virus.counts.final.tsv not found")

    os.chdir(first_dir)

# %%
summary = pd.concat(series_list, axis = 1).fillna(0).T
summary["Group"] = df["Group"].values

summary_dict = {}
Group = summary["Group"].unique()
for i in Group:
    summary_dict[i] = summary[summary["Group"] == i]

uval = pd.Series()
pval = pd.Series()

if summary["Group"].nunique() == 2:
    print("Conducting Mann-Whitney U-test")
    for i in range(0,len(summary.columns)-1):
        if summary["Group"].nunique() == 2:

            u, p = stats.mannwhitneyu(summary_dict[Group[0]].iloc[:,i],summary_dict[Group[1]].iloc[:,i], alternative = "two-sided")
            uval[summary.columns[i]] = u
            pval[summary.columns[i]] = p

fdr = pd.Series(multipletests(pval,method = "fdr_bh")[1], index = pval.index)

summary.loc["u-value"] = uval
summary.loc["p-value"] = pval
summary.loc["FDR"] = fdr

summary.to_csv("summary.csv")

# %%
g = sns.clustermap(summary.iloc[:-3,:-1].T, method = "ward", metric="euclidean")
g.savefig("clustermap.pdf", bbox_inches='tight')

print('All processes succeeded.')