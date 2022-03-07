class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_coverage
baseCommand:
  - samtools
  - coverage
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
outputs:
  - id: output
    type: File
    outputBinding:
      glob: virus.coverage.txt
label: samtools-coverage
requirements:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.15--h1170115_1'
stdout: virus.coverage.txt
