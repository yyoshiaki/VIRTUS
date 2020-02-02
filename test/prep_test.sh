#!/bin/bash
set -xe

fasterq-dump -e 8 ERR3240275 -p
cwltool ../workflow/createindex.cwl ../workflow/createindex.job.yaml
cwltool ../workflow/createindex_singlevirus.cwl ../workflow/createindex_singlevirus.job.yaml


pigz ERR3240275_1.fastq
pigz ERR3240275_2.fastq

fastp -i ERR3240275_1.fastq.gz -I ERR3240275_2.fastq.gz \
 -o ERR3240275_fp_1.fastq.gz -O ERR3240275_fp_2.fastq.gz

STAR --runThreadN 40 \
--genomeDir STAR_index_human \
--outFileNamePrefix ERR3240275/ \
--readFilesIn ERR3240275_fp_1.fastq.gz ERR3240275_fp_2.fastq.gz \
--outSAMtype BAM Unsorted \
--readFilesCommand gunzip -c \
--outSAMunmapped Within

samtools sort -@ 40 -o ERR3240275/Aligned.out ERR3240275/Aligned.out.bam

samtools view -@ 40 -b -f 4 ERR3240275/Aligned.out.bam > ERR3240275/unmapped.bam 
samtools sort -@ 40 -o ERR3240275/unmapped ERR3240275/unmapped.bam
# samtools view ERR3240275/unmapped.bam | less 

bedtools bamtofastq -i ERR3240275/unmapped.bam -fq ERR3240275/unmapped_1.fq -fq2 ERR3240275/unmapped_2.fq

STAR --runThreadN 40 \
--genomeDir STAR_index_virus \
--outFileNamePrefix ERR3240275/virus \
--readFilesIn ERR3240275/unmapped_1.fq ERR3240275/unmapped_2.fq \
--outSAMtype BAM SortedByCoordinate

samtools sort -@ 40 -o ERR3240275/Aligned.sortedByCoord.out ERR3240275/virusAligned.sortedByCoord.out.bam
samtools index ERR3240275/virusAligned.sortedByCoord.out.bam

samtools view ERR3240275/virusAligned.sortedByCoord.out.bam | cut -f3 | sort | uniq -c | awk '{if ($1>=400) print $0}' > ERR3240275//unmapped_viruses_count.txt

STAR --runThreadN 4 \
--genomeDir STAR_index_NC_007605.1 \
--outFileNamePrefix ERR3240275/NC_007605.1 \
--readFilesIn ERR3240275/unmapped_1.fq ERR3240275/unmapped_2.fq \
--outSAMtype BAM SortedByCoordinate 
samtools index ERR3240275/NC_007605.1Aligned.sortedByCoord.out.bam

salmon quant -i salmon_index_human \
-l A \
-1 ERR3240275_fp_1.fastq.gz \
-2 ERR3240275_fp_2.fastq.gz \
-p 40 \
-o ERR3240275/salmon_output_human \
--gcBias \
--validateMappings

salmon quant -i salmon_index_NC_007605.1 \
-l A \
-1 ERR3240275/unmapped_1.fq \
-2 ERR3240275/unmapped_2.fq \
-p 40 \
-o ERR3240275/salmon_output_NC_007605.1 \
--gcBias \
--validateMappings


# htseq-count -f bam ERR3240275/Aligned.out.bam gencode.v33.annotation.gtf.gz > ERR3240275/human_count_data.txt
# htseq-count -f bam ERR3240275/NC_007605.1Aligned.sortedByCoord.out.bam ../data/NC_007605.1.gtf > ERR3240275/NC_007605.1_count_data.txt