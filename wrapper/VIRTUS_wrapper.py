#!/usr/bin/env python3

# %% Package import
import subprocess
import numpy as np
import pandas as pd
import argparse
import os
from scipy import stats
from statsmodels.stats.multitest import multipletests
import seaborn as sns
import matplotlib as mpl
import pathlib
import re
mpl.rcParams['pdf.fonttype'] = 42
mpl.rcParams['ps.fonttype'] = 42

# %% Argument setting
parser = argparse.ArgumentParser()

parser.add_argument('input_path')
parser.add_argument('--VIRTUSDir', default = os.path.dirname(os.path.abspath(__file__)))
parser.add_argument('--genomeDir_human', required = True)
parser.add_argument('--genomeDir_virus', required = True)
parser.add_argument('--salmon_index_human', required = True)
parser.add_argument('--salmon_quantdir_human', default = 'salmon_human')
parser.add_argument('--outFileNamePrefix_human', default = 'human')
parser.add_argument('--nthreads', default = '16')
parser.add_argument('-s', '--Suffix_SE')
parser.add_argument('-s1', '--Suffix_PE_1')
parser.add_argument('-s2', '--Suffix_PE_2')
parser.add_argument('--fastq', action = 'store_true')

args = parser.parse_args()

# %%
df = pd.read_csv(args.input_path)
first_dir = os.getcwd()

print(args.VIRTUSDir)
try:
    if os.path.exists(os.path.join(args.VIRTUSDir, "workflow/VIRTUS.PE.cwl")):
        dir_VIRTUS = os.path.join(args.VIRTUSDir, "workflow")
    elif os.path.exists(os.path.join(args.VIRTUSDir, "VIRTUS.PE.cwl")):  
        dir_VIRTUS = args.VIRTUSDir
    else:
        raise ValueError('not found VIRTUS.PE.cwl or VIRTUS.SE.cwl')
except (ValueError, IndexError):
    exit('invalid path to VIRTUS. try to change --VIRTUSDir to the absolute path.')

# %%
series_list = []
clean_cmd = "rm -rf tmp"

for index, item in df.iterrows():
    # parameter setting
    if args.fastq == True:
        dir = os.path.dirname(item["fastq"])
        sample_index = os.path.basename(item["fastq"])
        os.chdir(dir)

        p_temp = pathlib.Path(".")
        files = [str(i) for i in list(p_temp.iterdir()) if i.is_file()]

        if item["Layout"] == "PE":
            if args.Suffix_PE_1 == None:
                pattern_1 = "^" + sample_index + "_1((\.fq\.gz)|(\.fq)|(\.fastq)|(\.fastq\.gz))$"
                matched_files_1 = sorted([i for i in files if re.match(pattern_1,i)])
                if len(matched_files_1) >= 1:
                    fastq1 = matched_files_1[0]
                    print("fastq_1:",fastq1)
                else:
                    print("fastq_1 not found")
            else:
                fastq1 = sample_index + args.Suffix_PE_1

            if args.Suffix_PE_2 == None:
                pattern_2 = "^" + sample_index + "_2((\.fq\.gz)|(\.fq)|(\.fastq)|(\.fastq\.gz))$"
                matched_files_2 = sorted([i for i in files if re.match(pattern_2,i)])
                if len(matched_files_2) >= 1:
                    fastq2 = matched_files_2[0]
                    print("fastq_2:",fastq2)
                else:
                    print("fastq_2 not found")
            else:
                fastq2 = sample_index + args.Suffix_PE_2
        
        elif item["Layout"] == "SE":
            if args.Suffix_SE == None:
                pattern = "^" + sample_index + "((\.fq\.gz)|(\.fq)|(\.fastq)|(\.fastq\.gz))$"
                matched_files = sorted([i for i in files if re.match(pattern,i)])
                if len(matched_files) >= 1:
                    fastq = matched_files[0]
                    print("fastq:",fastq)
                else:
                    print("fastq not found")
            else:
                fastq = sample_index + args.Suffix_SE
        
        else:
            print("Layout Error")
        
        input_list = [fastq1,fastq2]

    else:
        dir = item["SRR"]
        sample_index = item["SRR"]
        prefetch_cmd = " ".join(["prefetch",sample_index])
        fasterq_cmd = " ".join(["fasterq-dump", "--split-files", sample_index + ".sra", "-e","16"])

        if item["Layout"] == "PE":
            fastq1 = sample_index + "_1.fastq"
            fastq2 = sample_index + "_2.fastq"
        elif item["Layout"] == "SE":
            fastq = sample_index + ".fastq"
        else:
            print("Layout Error")

    if item["Layout"] =="PE":
        VIRTUS_cmd = " ".join([
            "cwltool --tmpdir-prefix tmp/",
            os.path.join(dir_VIRTUS, "VIRTUS.PE.cwl"), 
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
            os.path.join(dir_VIRTUS, "VIRTUS.SE.cwl"), 
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

        input_list = [fastq]
    
    # run
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
            if item["Layout"] == "PE":
                os.rename(sample_index + ".sra_1.fastq", fastq1)
                os.rename(sample_index + ".sra_2.fastq", fastq2)
            elif item["Layout"] == "SE":
                os.rename(sample_index + ".sra.fastq", fastq)
        except:
            print("fasterq error")

    print(VIRTUS_cmd,"\n")
    try:
        p_VIRTUS = subprocess.Popen(VIRTUS_cmd, shell = True)
        p_VIRTUS.wait()
    except:
        print("VIRTUS error")

    if args.fastq == False:
        try:
            for i in input_list:
                pigz_cmd = " ".join(["pigz",i])
                print(pigz_cmd, "\n")
                p_pigz = subprocess.Popen(pigz_cmd,shell = True)
                p_pigz.wait()
        except:
            print("Compression Error")

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

# %% summary
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

# %% Graph drawing
g = sns.clustermap(summary.iloc[:-3,:-1].T, method = "ward", metric="euclidean")
g.savefig("clustermap.pdf", bbox_inches='tight')

print('All processes succeeded.')