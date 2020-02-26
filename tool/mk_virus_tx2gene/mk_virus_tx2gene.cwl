class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: mk_virus_tx2gene
baseCommand:
  - python
  - /workdir/mk_virus_tx2gene.py
inputs:
  - id: input
    type: File?
    inputBinding:
      position: 0
  - id: output
    type: string
    inputBinding:
      position: 0
outputs:
  - id: tx2gene
    type: File
    outputBinding:
      glob: '*'
label: mk_virus_tx2gene
requirements:
  - class: DockerRequirement
    dockerPull: 'yyasumizu/mk_virus_tx2gene:latest'
