class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
baseCommand:
  - salmon
inputs:
  - id: index
    type: string
    inputBinding:
      position: 0
      prefix: '--index'
  - id: runThreadN
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
    doc: |
      1
      int: number of threads to run Salmon
  - id: transcripts
    type: File
    inputBinding:
      position: 0
      prefix: '--transcripts'
outputs:
  - id: index
    type: Directory
    outputBinding:
      glob: '*'
arguments:
  - index
requirements:
  - class: DockerRequirement
    dockerPull: combinelab/salmon
