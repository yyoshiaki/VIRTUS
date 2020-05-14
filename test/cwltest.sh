#!/bin/bash
set -xe

if [[ ! -e ./ERR3240275/ERR3240275_1.fastq.gz ]]; then
 mkdir -p ERR3240275
 cd ERR3240275
 echo "null" > null.txt
 ls | grep -v -E 'ERR3240275_1.fastq.gz' | grep -v -E 'ERR3240275_2.fastq.gz' | xargs rm -r
 cd ..
fi

# if [[ ! -e ./SRR8315715/SRR8315715_1.fastq.gz ]]; then
#  mkdir -p SRR8315715
#  cd SRR8315715
#  echo "null" > null.txt
#  ls | grep -v -E 'SRR8315715_1.fastq.gz' | grep -v -E 'SRR8315715_2.fastq.gz' | xargs rm -r
#  cd ..
# fi

cd ERR3240275
if [[ ! -e ./ERR3240275_1.fastq.gz ]]; then
 fasterq-dump -e 8 ERR3240275 -p
 pigz ERR3240275_*.fastq
fi
cwltest --test ../test.yml --tool cwltool --badgedir ../../badges
cd ..

# cd SRR8315715
# if [[ ! -e ./SRR8315715_1.fastq.gz ]]; then
#  fasterq-dump -e 8 SRR8315715 -p
#  pigz SRR8315715_*.fastq
# fi
# cd ..