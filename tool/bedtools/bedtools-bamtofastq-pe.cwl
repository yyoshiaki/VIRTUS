class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bedtools_bamtofastq_pe
baseCommand:
  - bedtools
  - bamtofastq
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
  - id: fq
    type: string
    inputBinding:
      position: 2
      prefix: '-fq'
  - id: fq2
    type: string?
    inputBinding:
      position: 4
      prefix: '-fq2'
outputs:
  - id: output_fq1
    type: File
    outputBinding:
      glob: $(inputs.fq)
  - id: output_fq2
    type: File?
    outputBinding:
      glob: $(inputs.fq2)
label: bedtools-bamtofastq-pe
requirements:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/bedtools:2.29.2--hc088bd4_0'
  - class: InlineJavascriptRequirement
