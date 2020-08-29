class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_view
baseCommand:
  - samtools
  - view
inputs:
  - id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '-@'
      shellQuote: false
  - 'sbg:altPrefix': '-b'
    id: b
    type: boolean?
    inputBinding:
      position: 2
      prefix: '-b'
      shellQuote: false
  - id: f
    type: int?
    inputBinding:
      position: 4
      prefix: '-f'
      shellQuote: false
  - id: prefix
    type: string?
    label: prefix
  - id: bam
    type: File
    inputBinding:
      position: 10
      shellQuote: false
outputs:
  - id: output
    type: stdout
label: samtools-view
arguments:
  - position: 0
    prefix: ''
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.2-0'
  - class: InlineJavascriptRequirement
stdout: $(inputs.prefix).unmapped.bam
