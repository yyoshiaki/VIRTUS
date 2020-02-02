#!/bin/bash
set -xe

fasterq-dump -e 8 ERR3240275 -p
cwltool ../workflow/createindex.cwl ../workflow/createindex.job.yaml
cwltool ../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.yaml

wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_33/gencode.v33.annotation.gtf.gz