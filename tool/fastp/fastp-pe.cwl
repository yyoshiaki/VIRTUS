#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
    InlineJavascriptRequirement: {}
    DockerRequirement:
        dockerPull: quay.io/biocontainers/fastp:0.20.0--hdbcaa40_0

baseCommand: [fastp]
arguments:
    - -o 
    - $(inputs.fastq1.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
    - -O 
    - $(inputs.fastq2.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
inputs:
    fastq1:
      type: File
      inputBinding:
        prefix: -i
    fastq2:
      type: File
      inputBinding:
        prefix: -I
    threads:
      type: int?
      default: 1
      inputBinding:
        prefix: --thread
outputs:
    out_fastq1:
       type: File
       outputBinding:
           glob: $(inputs.fastq1.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
    out_fastq2:
       type: File
       outputBinding:
           glob: $(inputs.fastq2.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq