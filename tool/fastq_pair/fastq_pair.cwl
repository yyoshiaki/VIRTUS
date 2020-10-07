class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: fastq_pair
baseCommand:
  - fastq_pair
inputs:
  - id: fq1
    type: File
    inputBinding:
      position: 0
  - id: fq2
    type: File
    inputBinding:
      position: 0
outputs:
  - id: fq1_paired
    type: File
    outputBinding:
      glob: $(inputs.fq1.basename).paired.fq
  - id: fq2_paired
    type: File
    outputBinding:
      glob: $(inputs.fq2.basename).paired.fq
label: fastq_pair
requirements:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/fastq-pair:1.0--he1b5a44_1'
  - class: InlineJavascriptRequirement
