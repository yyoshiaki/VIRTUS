class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: samtools_view
baseCommand:
  - samtools_view_removemulti.sh
inputs:
  - id: threads
    type: int?
    default: 4
    inputBinding:
      position: 0
      prefix: ''
      shellQuote: false
  - id: f
    type: int?
    default: 4
    inputBinding:
      position: 3
      prefix: ''
      shellQuote: false
  - id: prefix
    default: human
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
    dockerPull: 'yyasumizu/bam_filter_polyx:1.1'
  - class: InlineJavascriptRequirement
stdout: $(inputs.prefix).unmapped.bam
