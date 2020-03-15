#!/bin/bash
set -xe

if [[ ! -e ./ERR3240275/ERR3240275_1.fastq.gz ]]; then
 mkdir -p ERR3240275
 cd ERR3240275
 echo "null" > null.txt
 ls | grep -v -E 'ERR3240275_1.fastq.gz' | grep -v -E 'ERR3240275_2.fastq.gz' | xargs rm -r
 cd ..
fi

if [[ ! -e ./SRR8315715/SRR8315715_1.fastq.gz ]]; then
 mkdir -p SRR8315715
 cd SRR8315715
 echo "null" > null.txt
 ls | grep -v -E 'SRR8315715_1.fastq.gz' | grep -v -E 'SRR8315715_2.fastq.gz' | xargs rm -r
 cd ..
fi

echo "null" > null.txt
ls | grep -v -E 'test.sh' | grep -v -E 'ERR3240275' | grep -v -E 'SRR8315715' | xargs rm -r

../workflow/createindex.cwl ../workflow/createindex.job.yaml
../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.NC_007605.1.yaml

cd ERR3240275
if [[ ! -e ./ERR3240275_1.fastq.gz ]]; then
 fasterq-dump -e 8 ERR3240275 -p
 pigz ERR3240275_*.fastq
fi
../../workflow/VIRTUS.PE.cwl ../../workflow/VIRTUS.PE.job.yaml
../../workflow/VIRTUS.PE.singlevirus.cwl ../../workflow/VIRTUS.PE.singlevirus.job.yaml
cd ..

../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.NC_001806.2.yaml

cd SRR8315715
fasterq-dump -e 8 SRR8315715 -p
pigz SRR8315715*.fastq
if [[ ! -e ./SRR8315715_1.fastq.gz ]]; then
 fasterq-dump -e 8 SRR8315715 -p
 pigz SRR8315715_*.fastq
fi
../../workflow/VIRTUS.SE.cwl ../../workflow/VIRTUS.SE.job.yaml
../../workflow/VIRTUS.SE.singlevirus.cwl ../../workflow/VIRTUS.SE.singlevirus.job.yaml
cd ..