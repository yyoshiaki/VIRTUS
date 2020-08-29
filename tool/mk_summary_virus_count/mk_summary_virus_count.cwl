class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: mk_summary_virus_count
baseCommand:
  - python
  - /workdir/mk_summary_virus_count.py
inputs:
  - id: input_STARLog
    type: File
    inputBinding:
      position: 0
  - id: input_virus_count
    type: File
    inputBinding:
      position: 2
  - id: input_layout
    type: string
    inputBinding:
      position: 4
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*'
label: mk_summary_virus_count
requirements:
  - class: DockerRequirement
    dockerPull: yyasumizu/mk_summary_virus_count:1.0
