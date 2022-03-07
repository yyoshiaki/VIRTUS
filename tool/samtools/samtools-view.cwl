class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_view
baseCommand:
  - ./samtools_view_removemulti.sh
inputs:
  - default: 4
    id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: ''
      shellQuote: false
  - default: 4
    id: f
    type: int?
    inputBinding:
      position: 3
      prefix: ''
      shellQuote: false
  - default: human
    id: prefix
    type: string?
    label: prefix
  - id: bam
    type: File
    inputBinding:
      position: 5
      shellQuote: false
outputs:
  - id: output
    type: stdout
label: samtools-view
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'yyasumizu/bam_filter_polyx:1.3'
  - class: InlineJavascriptRequirement
stdout: $(inputs.prefix).unmapped.bam
