class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - fastp
inputs:
  - id: fastq
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
  - default: 1
    id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '--thread'
  - id: input
    type: File?
    inputBinding:
      position: 0
outputs:
  - id: out_fastq
    type: File
    outputBinding:
      glob: >-
        $(inputs.fastq.basename.replace(/\.gz$|\.bz2$/,
        '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
arguments:
  - '-o'
  - >-
    $(inputs.fastq1.basename.replace(/\.gz$|\.bz2$/,
    '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
  - '-O'
  - >-
    $(inputs.fastq2.basename.replace(/\.gz$|\.bz2$/,
    '').replace(/\.fq$|\.fastq$/, '')).fastp.fastq
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: '--trim_poly_x '
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/fastp:0.20.0--hdbcaa40_0'
  - class: InlineJavascriptRequirement
