#!/bin/bash
set -xe

fasterq-dump -e 8 ERR3240275 -p
cwltool ../workflow/createindex.cwl ../workflow/createindex.job.yaml
cwltool ../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.yaml
cwltool virtect_pe.cwl virtect_pe.job.yaml

STAR --runThreadN 4 \
--genomeDir STAR_index_NC_007605.1 \
--outFileNamePrefix ERR3240275/NC_007605.1 \
--readFilesIn ERR3240275/unmapped_1.fq ERR3240275/unmapped_2.fq \
--outSAMtype BAM SortedByCoordinate 
samtools index ERR3240275/NC_007605.1Aligned.sortedByCoord.out.bam

salmon quant -i salmon_index_NC_007605.1 \
-l A \
-1 ERR3240275/unmapped_1.fq \
-2 ERR3240275/unmapped_2.fq \
-p 40 \
-o ERR3240275/salmon_output_NC_007605.1 \
--gcBias \
--validateMappings
