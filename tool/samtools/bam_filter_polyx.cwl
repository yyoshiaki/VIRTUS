class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bam_filter_polyx
baseCommand:
  - bam_filter_polyx.sh
inputs:
  - id: input
    type: File?
    inputBinding:
      position: 0
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: virusAligned.filtered.sortedByCoord.out.bam
label: bam_filter_polyX
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'yyasumizu/bam_filter_polyx:latest'
stdout: virusAligned.filtered.sortedByCoord.out.bam
