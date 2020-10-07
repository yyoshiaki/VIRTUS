class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: kz_filter
baseCommand:
  - kz
inputs:
  - 'sbg:toolDefaultValue': '0.1'
    id: threshold
    type: float?
    inputBinding:
      prefix: '--threshold'
      shellQuote: false
      position: 0
  - id: input_fq
    type: File
  - id: output_fq
    type: string
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: $(inputs.output_fq)
label: kz-filter
arguments:
  - prefix: ''
    shellQuote: false
    position: 0
    valueFrom: '--filter'
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'yyasumizu/ko:0.1'
  - class: InlineJavascriptRequirement
stdin: $(inputs.input_fq.path)
stdout: $(inputs.output_fq)
