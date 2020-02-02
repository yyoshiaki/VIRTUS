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
  - id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '--threads'
    doc: |
      1
      int: number of threads to run Salmon
  - id: transcripts
    type: File
    inputBinding:
      position: 0
      prefix: '--transcripts'
  - id: gencode
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--gencode'
  - id: kmer
    type: int?
    inputBinding:
      position: 0
      prefix: '-k'
  - id: type
    type: string?
    inputBinding:
      position: 0
      prefix: '--type'
outputs:
  - id: index
    type: Directory
    outputBinding:
      glob: '*'
arguments:
  - index
requirements:
  - class: DockerRequirement
    dockerPull: 'combinelab/salmon:1.1.0'
