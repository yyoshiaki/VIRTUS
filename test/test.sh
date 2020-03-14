#!/bin/bash
set -xe

# ls | grep -v -E 'test.sh' | xargs rm -r

fasterq-dump -e 8 ERR3240275 -p
pigz ERR3240275_*.fastq

../workflow/createindex.cwl ../workflow/createindex.job.yaml

../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.NC_007605.1.yaml

mkdir -p ERR3240275
cd ERR3240275
fasterq-dump -e 8 ERR3240275 -p
pigz ERR3240275_*.fastq
../../workflow/VIRTUS.PE.cwl ../../workflow/VIRTUS.PE.job.yaml
../../workflow/VIRTUS.PE.singlevirus.cwl ../../workflow/VIRTUS.PE.singlevirus.job.yaml

cd ..
../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.NC_001806.2.yaml

mkdir -p SRR8315715
cd SRR8315715
fasterq-dump -e 8 SRR8315715 -p
pigz SRR8315715*.fastq
../../workflow/VIRTUS.SE.cwl ../../workflow/VIRTUS.SE.job.yaml
../../workflow/VIRTUS.SE.singlevirus.cwl ../../workflow/VIRTUS.SE.singlevirus.job.yaml
