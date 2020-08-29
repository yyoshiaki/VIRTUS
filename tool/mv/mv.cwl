class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - mv
inputs:
  - id: infile
    type: File
    inputBinding:
      position: 1
  - id: outfile
    type: string
    inputBinding:
      position: 2
outputs:
  - id: out
    type: File
    outputBinding:
      glob: $(inputs.outfile)
label: mv
requirements:
  - class: InlineJavascriptRequirement
