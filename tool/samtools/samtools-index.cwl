class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_index
baseCommand:
  - samtools
  - index
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '*.bai'
label: samtools-index
requirements:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.2-0'
