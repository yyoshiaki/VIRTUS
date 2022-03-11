import sys
import pandas as pd

'''
Yoshiaki Yasumizu
2020.03.08

ex.
python mk_summary_virus_count.py \
    output/donor1_day1/humanLog.final.out \
    PE \
    output/donor1_day1/virus.coverage.txt \
    VIRTUS.output.tsv
'''

input_STARLog = sys.argv[1]
# input_virus_count = sys.argv[2]
input_layout = sys.argv[2]
input_cov = sys.argv[3]
f_output = sys.argv[4]

df_STARLog = pd.read_csv(input_STARLog, sep='\t', header=None, index_col=0)
num_reads = int(df_STARLog.loc['                   Uniquely mapped reads number |', 1]) + \
            int(df_STARLog.loc['        Number of reads mapped to multiple loci |', 1])

# try:
#     # df_virus_count = pd.read_csv(input_virus_count, delim_whitespace=True)
#     df_virus_count.columns = ['num_hit', 'virus']
# except:
#     df_virus_count = pd.DataFrame(columns=['virus', 'num_hit', 'rate_hit'])

# if df_virus_count.shape[0] > 0:
#     if input_layout == 'PE':
#         df_virus_count['num_hit'] = df_virus_count['num_hit'] / 2
#     df_virus_count['rate_hit'] = df_virus_count['num_hit'] / num_reads
#     df_virus_count = df_virus_count[['virus', 'num_hit', 'rate_hit']]
#     df_virus_count = df_virus_count.sort_values(by='rate_hit', ascending=False)
df_cov = pd.read_csv(input_cov, sep='\t') 
df_cov.columns = ['virus', 'startpos', 'endpos', 'numreads', 'covbases', 'coverage', 'meandepth', 'meanbaseq', 'meanmapq']
if input_layout == 'PE':
    df_cov['numreads'] /= 2
df_cov['rate_hit'] = df_cov['numreads'] / num_reads
df_cov = df_cov.sort_values(by='rate_hit', ascending=False)
df_cov = df_cov[df_cov.numreads > 0]

df_cov.to_csv(f_output, index=None, sep='\t')