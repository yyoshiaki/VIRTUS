#!/bin/bash
set -xe

# ls | grep -v -E 'test.sh' | xargs rm -r

fasterq-dump -e 8 ERR3240275 -p
pigz ERR3240275_*.fastq

../workflow/createindex.cwl ../workflow/createindex.job.yaml
../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.yaml
../workflow/VIRTUS.PE.cwl ../workflow/VIRTUS.PE.job.yaml
../workflow/VIRTUS.PE.singlevirus.cwl ../workflow/VIRTUS.PE.singlevirus.job.yaml
