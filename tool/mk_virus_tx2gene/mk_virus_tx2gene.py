import argparse
import pandas as pd

parser = argparse.ArgumentParser(description='create tx2gene from an NCBI virus transcript fasta file.')

parser.add_argument('input', help='input fasta file')
parser.add_argument('output', help='output file')

args = parser.parse_args()

print('input : ', args.input)
print('output : ', args.output)

with open(args.input, 'r') as f:
    txt = f.read()
headers = [x for x in txt.split('\n') if x.startswith('>')]

pd.DataFrame([[x.split('>')[1].split(' ')[0], x.split('gene=')[1].split(']')[0]] for x in headers]).to_csv(args.output, header=None, index=None, sep='\t')