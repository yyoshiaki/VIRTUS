class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: mk_virus_count
baseCommand:
  - samtools
  - view
inputs:
  - id: virus_bam
    type: File
    inputBinding:
      position: -2
      shellQuote: false
  - 'sbg:toolDefaultValue': '400'
    id: hit_cutoff
    type: int?
    inputBinding:
      position: 0
      shellQuote: false
outputs:
  - id: virus_count
    type: stdout
label: mk_virus_count
arguments:
  - position: 0
    shellQuote: false
    valueFrom: '| cut -f3 | sort | uniq -c | awk ''{if ($1>='
  - position: 2
    shellQuote: false
    valueFrom: ') print $0}'''
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.2-0'
stdout: virus_counts.txt