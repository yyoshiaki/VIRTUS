class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - salmon
  - quant
inputs:
  - id: index
    type: Directory
    inputBinding:
      position: 0
      prefix: '-i'
      shellQuote: false
  - id: inf1
    type: File
    inputBinding:
      position: 0
      prefix: '-1'
      shellQuote: false
  - id: inf2
    type: File
    inputBinding:
      position: 0
      prefix: '-2'
      shellQuote: false
  - default: A
    id: libType
    type: string
    inputBinding:
      position: 0
      prefix: '-l'
      shellQuote: false
  - id: quantdir
    type: string
    inputBinding:
      position: 4
      prefix: '-o'
      shellQuote: false
  - id: runThreadN
    type: int?
    inputBinding:
      position: 0
      prefix: '-p'
      shellQuote: false
    doc: |
      1
      int: number of threads to run Salmon
  - id: gcBias
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--gcBias'
  - id: validateMappings
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--validateMappings'
outputs:
  - id: output_quantdir
    type: Directory
    outputBinding:
      glob: .
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'combinelab/salmon:1.1.0'
