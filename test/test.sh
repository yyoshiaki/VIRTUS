#!/bin/bash
set -xe

# ls | grep -v -E 'test.sh' | xargs rm -r

fasterq-dump -e 8 ERR3240275 -p
pigz ERR3240275_*.fastq

../workflow/createindex.cwl ../workflow/createindex.job.yaml
../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.yaml
../workflow/virtect_pe.cwl ../workflow/virtect_pe.job.yaml
../workflow/virtect_pe_quant_singlevirus.cwl ../workflow/virtect_pe_quant_singlevirus.job.yaml
